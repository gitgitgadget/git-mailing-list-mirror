From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/5] First part of Unicode console support for msysgit
Date: Fri, 06 Jun 2014 19:44:33 +0200
Message-ID: <5391FE01.9040501@gmail.com>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCH3XYXLXQDBB773Y6OAKGQE4527OBY@googlegroups.com Fri Jun 06 19:44:33 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB773Y6OAKGQE4527OBY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f60.google.com ([209.85.215.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB773Y6OAKGQE4527OBY@googlegroups.com>)
	id 1WsyBs-0000AY-8d
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 19:44:32 +0200
Received: by mail-la0-f60.google.com with SMTP id pn19sf376684lab.25
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=qiGmSiaOYOOu/MPkc6eLIZ778Hq5mID5Mmzu2iYsVaE=;
        b=g0/da4S1+V/I8U9kTg48BYUm2ExCGqrVU9+kd/lQMqRvFrxnHDYUhQY90wNTULiDGY
         j+WomvcnPsy8Aynxa4BkqTwMXNK0zEKdqS0Wp0bS7aA8N9v5EsXXAJPypdMraBa+EW6p
         qP5dp2+Fpv0mEwS7Q5VY1s5AloSypePtzIfOUfQXYkVzDtQGiYKh73exDNIDoAPGK6LP
         hiiXVLtL9vxTuvmll97TXuT3gHRKybjztB0s+AcnMOUra8gqJniuN38wQcTAn4i9MV2a
         NB4+V1uiA81TGA2/6MHD/GwhSdmsGLm7DCxmjkECDyrc+YSiVOtx1FcB18yhbCpj10F9
         9OTw==
X-Received: by 10.152.2.131 with SMTP id 3mr37503lau.18.1402076672126;
        Fri, 06 Jun 2014 10:44:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.4 with SMTP id m4ls144276laj.45.gmail; Fri, 06 Jun 2014
 10:44:31 -0700 (PDT)
X-Received: by 10.112.199.101 with SMTP id jj5mr488211lbc.22.1402076671040;
        Fri, 06 Jun 2014 10:44:31 -0700 (PDT)
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com [2a00:1450:400c:c05::236])
        by gmr-mx.google.com with ESMTPS id xk11si1384384wib.0.2014.06.06.10.44.31
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 10:44:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236 as permitted sender) client-ip=2a00:1450:400c:c05::236;
Received: by mail-wi0-x236.google.com with SMTP id r20so1430135wiv.3
        for <msysgit@googlegroups.com>; Fri, 06 Jun 2014 10:44:31 -0700 (PDT)
X-Received: by 10.15.64.76 with SMTP id n52mr813125eex.48.1402076670733;
        Fri, 06 Jun 2014 10:44:30 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id f45sm3327703eem.15.2014.06.06.10.44.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 10:44:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250953>

Am 06.06.2014 15:42, schrieb Stepan Kasal:
> Hello,
>=20
> this is first part of the unicode support pathes from msysgit.
>=20

Nicely done, thanks!

I think its important to reiterate that these patches were written several =
years apart, so there are some inconsistencies and back-and-forth changes (=
e.g. [5/5] fixes line break errors introduced in [3/5]). I'm OK with mergin=
g this as is, if there are no objections from the list, simply because it r=
epresents the battle tested history we have in Git for Windows.

The only real complaint I have is that I'm missing [6/5] "Win32: fix broken=
 pipe detection" [1], which leaves this series in a slightly broken state (=
terminating the pager will not terminate the calling git process).


Nitpicking follows...

> The first three patches originate in Jun 2010, though some fixups from 20=
12
> have been squashed in.
> The fourth one is just a trivial prerequisite for
> the last one, that was written in Jan 2012, with a fixup from Mar 2012.
>=20

The dates are missing from the patches.
It would also have been nice to name (or link to) the patches you sqashed.

> Regards,
> 	Stepan
>=20
> Karsten Blees (5):
>   Support Unicode console output on Windows

This introduces WriteConsoleW, so you could have squashed half of "Win32: f=
ix segfault in WriteConsoleW when debugging in gdb" [2] (second  half in [5=
/5]).

>   Detect console streams more reliably on Windows
>   Warn if the Windows console font doesn't support Unicode

I think this one includes "MSVC: fix winansi.c compile errors " [3] and "Un=
icode console: fix font warning on Vista and Win7" [4] (which is partly rev=
erted by [5/5], which also fixes the formatting).

>   Win32: move main macro to a function

Note: this one was submitted seperately on May 29 and May 1 (can't find it =
in the gmane archive, though).

>   Win32: Thread-safe windows console output
>=20
>  compat/mingw.c   |  24 ++-
>  compat/mingw.h   |  24 +--
>  compat/winansi.c | 446 ++++++++++++++++++++++++++++++++++++++++---------=
------
>  3 files changed, 356 insertions(+), 138 deletions(-)
>=20

[1] https://github.com/msysgit/git/commit/67934f93
[2] https://github.com/msysgit/git/commit/cd0792af
[3] https://github.com/msysgit/git/commit/3abcb04d
[4] https://github.com/msysgit/git/commit/981aa538


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
