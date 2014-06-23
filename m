From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: The different EOL behavior between libgit2-based
 software and official Git
Date: Mon, 23 Jun 2014 10:29:10 -0700
Message-ID: <xmqqionrcz6h.fsf@gitster.dls.corp.google.com>
References: <1403146778624-7613670.post@n2.nabble.com>
	<53A285A1.3090804@web.de> <53A3DB01.7090904@web.de>
	<CAO_ghTLq-a3dJGXvmspaCYS19RhTJzT0teWO5XSfVSiRUN7rrQ@mail.gmail.com>
	<53A40DEC.4050902@web.de>
	<xmqqmwd7ee2j.fsf@gitster.dls.corp.google.com>
	<53A67BE1.4060903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Yue Lin Ho <yuelinho777@gmail.com>,  git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRB3WHUGOQKGQEO4COGOI@googlegroups.com Mon Jun 23 19:29:25 2014
Return-path: <msysgit+bncBCG77UMM3EJRB3WHUGOQKGQEO4COGOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f188.google.com ([209.85.220.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB3WHUGOQKGQEO4COGOI@googlegroups.com>)
	id 1Wz83T-0003qO-L1
	for gcvm-msysgit@m.gmane.org; Mon, 23 Jun 2014 19:29:19 +0200
Received: by mail-vc0-f188.google.com with SMTP id hy10sf1615255vcb.5
        for <gcvm-msysgit@m.gmane.org>; Mon, 23 Jun 2014 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=kHW/RRl4ZCs3EWlt2TiELTqJnzukJP5WqPbXzrbNcHw=;
        b=sdBSO8RxSwAAqeqGitLy0BS+fwYcL1LTwCLx+3kR/8mIG4Z9Mojc6/mBnR9SsWeBkH
         zVJ84jMafjgLTYgyGIZkNaGFC7vV9EFvT1YBK9Gfrcq6jp1iuGJM0JlYbqnFL6dZ3Xnz
         1Whb4KYS29FANYGDxOv37u21FVv58rVPrRdmdTJoV12pKFZ8zuWapHNfWTsLGKz9h1+S
         Wk9aU2pQ+xDWTxeBi1O3OfyNnYYE+CX1UMRIQg7SbEH5I0FIwHuiTe9kJUkQxZ29DZ3O
         KvInzB/QiwxkFrqkPWLMQ3c+vOgMWkOQhN0y6A2D1KWw0nB8h0IkqefLZFcCGILTTsCt
         15HQ==
X-Received: by 10.50.7.39 with SMTP id g7mr105145iga.8.1403544558871;
        Mon, 23 Jun 2014 10:29:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.138.76 with SMTP id qo12ls1738265igb.17.gmail; Mon, 23 Jun
 2014 10:29:18 -0700 (PDT)
X-Received: by 10.43.124.136 with SMTP id go8mr8810373icc.26.1403544558030;
        Mon, 23 Jun 2014 10:29:18 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id x7si413837qcd.3.2014.06.23.10.29.17
        for <msysgit@googlegroups.com>;
        Mon, 23 Jun 2014 10:29:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B3122267A;
	Mon, 23 Jun 2014 13:29:13 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 287DF22679;
	Mon, 23 Jun 2014 13:29:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 76AE322676;
	Mon, 23 Jun 2014 13:29:08 -0400 (EDT)
In-Reply-To: <53A67BE1.4060903@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 22 Jun 2014 08:46:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1E710C2-FAFB-11E3-8CD4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252358>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> No, it hadn't, under my Linux box.
> (And I had a .gittatributes file on the Mac OS box, which I forgot about.

OK, that explains the difference; thanks for double-checking.

> Files with mixed LF CRLF in the repo are not changed by Git, when the che=
ckout out
> or checked in, unless the .gitattributes say that the file is text.

Hmph, I would have thought, after reading the "Does anybody do that
crazy stuff" comment in convert.c, that we refrain from attempting
to convert a file with a mixed mess, even if the file is marked as
text, because it is unclear what it means to have both LF and CRLF
in a file that is text.  Is "A\rB\nC\r\n" a line terminated with a
CRLF that happens to have a lone CR and then LF in between?

You may be looking at a bug in a corner case that is so irrelevant
that nobody has even noticed, let alone attempted to fix.

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
