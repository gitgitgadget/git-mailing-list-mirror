From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: The different EOL behavior between libgit2-based
 software and official Git
Date: Fri, 20 Jun 2014 09:33:08 -0700
Message-ID: <xmqqmwd7ee2j.fsf@gitster.dls.corp.google.com>
References: <1403146778624-7613670.post@n2.nabble.com>
	<53A285A1.3090804@web.de> <53A3DB01.7090904@web.de>
	<CAO_ghTLq-a3dJGXvmspaCYS19RhTJzT0teWO5XSfVSiRUN7rrQ@mail.gmail.com>
	<53A40DEC.4050902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Yue Lin Ho <yuelinho777@gmail.com>,  git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRBTGESGOQKGQECUYGPAI@googlegroups.com Fri Jun 20 18:33:21 2014
Return-path: <msysgit+bncBCG77UMM3EJRBTGESGOQKGQECUYGPAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f189.google.com ([209.85.128.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBTGESGOQKGQECUYGPAI@googlegroups.com>)
	id 1Wy1kc-0001Jw-6v
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 18:33:18 +0200
Received: by mail-ve0-f189.google.com with SMTP id pa12sf888724veb.16
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=26WrOSi+aeOieln919VTbkdePoZV9JV6GJ26ikH+bF4=;
        b=XnuLQtzb6WrDlogfOLCFf8Qvbo6r3GhkyROoq3kSm5wldDU6ynNKkuQ0ec/cy99AAh
         wRXIg450FuCj6q//LjT1vTgrDuA/TBl1GqZqWSuFVX8ZVGu7ZXaThLk0wX2doswAv0I0
         Z7DEtejBSu4/bbGWF87B4nVo3rK5T+0Pg1jzFSc1WD+giXIpOKeALTXFuWOO8Kbkzfi8
         E0bscs15yel0yUUaGdENMFiTI3608yHW+EAxS8jTc33CsKiGCFNvrwonqMOrCJym3neI
         +ws8i1JSvyhDyeG0F4efsmfLilS+EsApzxd7yOJniHteL2DDbCv46n7FZf14NAuz+X9F
         FSSQ==
X-Received: by 10.50.153.48 with SMTP id vd16mr98483igb.12.1403281997421;
        Fri, 20 Jun 2014 09:33:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.176.134 with SMTP id ci6ls367148igc.22.canary; Fri, 20 Jun
 2014 09:33:16 -0700 (PDT)
X-Received: by 10.42.85.142 with SMTP id q14mr1612207icl.16.1403281996343;
        Fri, 20 Jun 2014 09:33:16 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id m2si1940288qcr.2.2014.06.20.09.33.16
        for <msysgit@googlegroups.com>;
        Fri, 20 Jun 2014 09:33:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A93BF1F7FE;
	Fri, 20 Jun 2014 12:33:11 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E77B1F7FC;
	Fri, 20 Jun 2014 12:33:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 850A21F7F8;
	Fri, 20 Jun 2014 12:33:06 -0400 (EDT)
In-Reply-To: <53A40DEC.4050902@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 20 Jun 2014 12:33:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8ECAA10C-F898-11E3-B967-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252275>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

tb@Linux:~/EOL_Test/TestAutoCrlf$ t=3DLF.txt  &&  rm -f $t &&  git -c core.=
eol=3DCRLF checkout $t  && od -c  $t
0000000   L   i   n   e       1  \n   l   i   n   e       (   2   )  \n
0000020   l   i   n   e       3   .  \n   t   h   i   s       i   s   =20
0000040   l   i   n   e       4  \n   l       i       n       e       N
0000060   o   .       5  \n   L   i   n   e       N   u   m   b   e   r
0000100       6  \n  \n

In Documentation/config.txt, we find:

    core.eol::
            Sets the line ending type to use in the working directory for
            files that have the `text` property set.  Alternatives are ...

Does that file $t in your practice "have the `text` property set"?

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
