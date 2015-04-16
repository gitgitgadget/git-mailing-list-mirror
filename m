From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Thu, 16 Apr 2015 14:48:54 +0200
Organization: gmx
Message-ID: <02c7702c204914ddded4014f292a90bf@www.dscho.org>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
 <xmqq3841kz32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Sixt <j6t@kdbg.org>, Luke Mewburn <luke@mewburn.net>, Nicolas
 Pitre <nico@fluxnic.net>, git@vger.kernel.org, msysGit
 <msysgit@googlegroups.com>, git-owner@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBUO7X2UQKGQEFLSPKAY@googlegroups.com Thu Apr 16 14:49:22 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBUO7X2UQKGQEFLSPKAY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBUO7X2UQKGQEFLSPKAY@googlegroups.com>)
	id 1YijEQ-0002cz-A8
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 14:49:22 +0200
Received: by lamq1 with SMTP id q1sf23972752lam.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=tehiyw12yng1q/6USe/gQ1k/LwaBh9lP7HH+iJUn6W0=;
        b=MBi7gjnLgqMS11XcjAbuRSY58vpbSZxvQE+YUszK49nnlVwSr7NTJQfzzayu9oEWJ2
         5PT9NeoQ9wxcwR75Cl3ekpuwoohgdnCFYmOAwCvHLs6UtbG4/1KbyV/oK9zLmwIwGmj5
         zelSWchOnFbqqqaprGO2fhoBxm7omOPLjzua7h0lNQeLwCX9Dmge5u0by4IynMvwNDOt
         uFpdEhavayPxdU7Jj0UmnuquP0d5fNpGKwCI683RQd3myxwC65I6UX2KhNdZ+J2XWdrH
         We85BHTbdO35dDnf0qrnKIlU1e1GZ32ClDqq3dAOR0hIvcU5DKgHxQrzzA/qdCrcLsPg
         617A==
X-Received: by 10.152.27.35 with SMTP id q3mr376214lag.9.1429188561931;
        Thu, 16 Apr 2015 05:49:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.245.43 with SMTP id xl11ls325064lac.21.gmail; Thu, 16 Apr
 2015 05:49:20 -0700 (PDT)
X-Received: by 10.112.160.197 with SMTP id xm5mr7428240lbb.15.1429188560912;
        Thu, 16 Apr 2015 05:49:20 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id g5si991736wix.1.2015.04.16.05.49.20
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 05:49:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LraSn-1ZN2851KAv-013Qtk; Thu, 16 Apr 2015 14:48:56
 +0200
In-Reply-To: <xmqq3841kz32.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:WPN/eDOpxQKWdEoeXXcWfExARycP915Tx0QPOqoIY0mpu5m/Krd
 JgvKPTqBCAO2Uvnijzx1xMls9adW66U8uKhKN2FS4ZVsj/T/jqQ/TUelSUXmEx4ODQORkRt
 nfEjh28olIgNVJyDBmS58BPRSHPR+Ja3MG2fyXRjhoMpvnG0zxrCa9IXLpZ7/1N4g6H/RUw
 M2q1Fl09t2sZO6LKp+9WA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267284>

Hi Junio,

On 2015-04-15 20:48, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>=20
>> Windows does not have process groups. It is, therefore, the simplest
>> to pretend that each process is in its own process group.
>>
>> While here, move the getppid() stub from its old location (between
>> two sync related functions) next to the two new functions.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>=20
> Thanks for a quick update.
>=20
> The patch should do for now, but I suspect that it may give us a
> better abstraction to make the "is_foreground_fd(int fd)" or even
> "is_foreground(void)" the public API that would be implemented as
>=20
> 	int we_are_in_the_foreground(void)
>         {
> 		return getpgid(0) =3D=3D tcgetpgrp(fileno(stderr));
> 	}
>=20
> in POSIX and Windows can implement entirely differently.

I really like it. We already require a couple of workarounds to be able to =
use `mintty` (which is a replacement terminal emulator that is more flexibl=
e than the default Windows terminal window, but it comes at the price that =
most Win32 programs think they are not running interactively inside a `mint=
ty` session). I would really like to avoid having to finagle some really ug=
ly code into `getpgid()` to make that test work.

In general, I find it rewarding not only from a portability point of view, =
but *especially* from a readability one if the code contains functions that=
 are named semantically, i.e. they describe *why* they are called, not *how=
* they answer the question.

In this case, I would prefer the `is_foreground_fd(int fd)` one, but I am s=
ure I can make the other signature work for us, too.

Ciao,
Dscho

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
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
