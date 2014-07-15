From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/3] fix test suite with mingw-unicode patches
Date: Wed, 16 Jul 2014 00:52:17 +0200
Message-ID: <53C5B0A1.4060502@gmail.com>
References: <20140712075035.GA12400@ucw.cz>	<1405431797-20899-1-git-send-email-kasal@ucw.cz> <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBIPBS2PAKGQEVA6GR5Q@googlegroups.com Wed Jul 16 00:52:18 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBIPBS2PAKGQEVA6GR5Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBIPBS2PAKGQEVA6GR5Q@googlegroups.com>)
	id 1X7Ba6-0006H5-Fx
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 00:52:18 +0200
Received: by mail-wg0-f62.google.com with SMTP id k14sf8750wgh.27
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=64t5VlH8vHx5jBQSZNTnW0gfbedrpys3VS419NMvZdw=;
        b=GA///OTbQ0qWEYlLv/tn/IlPThG/DkE4AV07VoUeaAKb8eYecIQyNXlCJsaIK26eaD
         HgoBFo/lRNdPNfjOuCQ666tTPctP6sDMnyiHX7wT1TqLO7+owZUnVB9+Ov5JggkD08R4
         0S7O1GBQM2+liU22vHScvNKQKoUWCTHmU/72hpln8I3nWXboNqHoSrPf4f1UoIUS0Hpr
         s7CERDLti4clY5I4p3UPHz1f6FLekLuvm9u3vTgHOLSCOwdK5w//zHw0zwZ7rOkatELI
         MXlIMo+AVXwg6bVNcTgd+alctG0H35KyYtl1pDSZDhMA70FQWb9+yH43aUYjfKCcIyVZ
         Foxw==
X-Received: by 10.180.107.162 with SMTP id hd2mr39187wib.0.1405464738196;
        Tue, 15 Jul 2014 15:52:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.187.242 with SMTP id fv18ls125682wic.47.gmail; Tue, 15 Jul
 2014 15:52:17 -0700 (PDT)
X-Received: by 10.180.91.73 with SMTP id cc9mr754806wib.4.1405464737116;
        Tue, 15 Jul 2014 15:52:17 -0700 (PDT)
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com [2a00:1450:400c:c05::22d])
        by gmr-mx.google.com with ESMTPS id gg16si715757wic.2.2014.07.15.15.52.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 15:52:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22d as permitted sender) client-ip=2a00:1450:400c:c05::22d;
Received: by mail-wi0-f173.google.com with SMTP id f8so4312859wiw.12
        for <msysgit@googlegroups.com>; Tue, 15 Jul 2014 15:52:17 -0700 (PDT)
X-Received: by 10.194.243.10 with SMTP id wu10mr31038740wjc.44.1405464736996;
        Tue, 15 Jul 2014 15:52:16 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o12sm48920400wiw.5.2014.07.15.15.52.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 15:52:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22d
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253613>

Am 15.07.2014 20:20, schrieb Junio C Hamano:
> Stepan Kasal <kasal@ucw.cz> writes:
>=20
>> Hello Hannes,
>> attached please find the patches that Karsten pointed out:
>>
>> 1) The unicode file name support was omitted from his unicode patch
>> series; my mistake, sorry.  There is still big part missing: support
>> for unicode environment; I can only hope the tests would choke on
>> that.
>>
>> 2) Windows cannot pass non-UTF parameters (commit messages in this
>> case): original patch by Pat Thoyts was extended to apply to other
>> similar cases: the commit msg is passed through stdin.
>>
>> If there are still problems remaining, please tell us.
>>
>> Thanks,
>> 	Stepan
>>
>> Karsten Blees (2):
>>   Win32: Unicode file name support (except dirent)
>>   Win32: Unicode file name support (dirent)
>>
>> Pat Thoyts and Stepan Kasal(1):
>>   tests: do not pass iso8859-1 encoded parameter
>=20
> Thanks.  I'll queue these and wait for Windows folks to respond.
> With favourable feedback they can go directly from pu to master, I
> would think.
>=20

Looking good. After fixing the ELOOP and fchmod issues (see followup
patches), there are 9 test failures left. Only one of these is
environment related, and for the rest we have fixes in the msysgit
fork:


* t0081-line-buffer: 1

Using file descriptor other than 0, 1, 2.
https://github.com/msysgit/git/commit/4940c51a


* t0110-urlmatch-normalization: 1

Passing binary data on the command line...would have to teach test-urlmatch=
-normalization.c to read from stdin or file.
https://github.com/msysgit/git/commit/be0d6dee


* t4036-format-patch-signer-mime: 1

not ok 4 - format with non ASCII signer name
#
#               GIT_COMMITTER_NAME=3D"=E3=81=AF=E3=81=BE=E3=81=AE =E3=81=B5=
=E3=81=AB=E3=81=8A=E3=81=86" \
#               git format-patch -s --stdout -1 >output &&
#               grep Content-Type output
#

Passing non-ASCII by environment variable, will be fixed by Unicode environ=
ment support.


* t4201-shortlog: 3

Passing binary data on the command line ('git-commit -m').
https://github.com/msysgit/git/commit/3717ce1b


* t4210-log-i18n: 2

Passing binary data on the command line ('git log --grep=3D$latin1_e').
https://github.com/msysgit/git/commit/dd2defa3


* t7001-mv: 6

cp -P fails in MinGW - perhaps use the long option forms (--no-dereference)=
?
https://github.com/msysgit/git/commit/00764ca1


* t8001-annotate/t8002-blame: 5

Msys.dll thinks '-L/regex/' is an absolute path and expands to '-LC:/msysgi=
t/regex/'.
https://github.com/msysgit/git/commit/2d52168a


* t8005-blame-i18n: 4

Passing binary data on the command line ('git-commit --author -m').
https://github.com/msysgit/git/commit/3717ce1b


* t9902-completion: 2

Must use 'pwd -W' to get Windows-style absolute paths.
https://github.com/msysgit/git/commit/9b612448

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
