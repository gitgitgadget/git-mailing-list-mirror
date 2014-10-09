From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Fri, 10 Oct 2014 00:56:25 +0100
Message-ID: <CAOYw7dtouon0EXYQPnvpc7ZMARKwaureNTK6ZL+aByknpPG-9A@mail.gmail.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-8-git-send-email-marat@slonopotamus.org>
	<alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info>
	<CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
	<alpine.DEB.1.00.1410092146310.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=f46d04388eb127d8530505062ecf
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, gitster@pobox.com, 
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDINLP4TUYEBBKWB3SQQKGQESBW3R6I@googlegroups.com Fri Oct 10 01:56:28 2014
Return-path: <msysgit+bncBDINLP4TUYEBBKWB3SQQKGQESBW3R6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDINLP4TUYEBBKWB3SQQKGQESBW3R6I@googlegroups.com>)
	id 1XcNZL-0007HJ-5L
	for gcvm-msysgit@m.gmane.org; Fri, 10 Oct 2014 01:56:27 +0200
Received: by mail-lb0-f187.google.com with SMTP id w7sf212524lbi.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=huM+vQ0HiAbpmnvWdl3K3mXHuO2jdB38vhTaJQ5P9Rg=;
        b=BIn/1QptUc+DZB2xTUjuCmJ0XgouLeP/l91Sj8jXYO5BsrJLn2y4iM7ytu4FRNKriB
         0cQK6t6sotfnJC8tbzKiFD26eZXL6pu79dCfthCercDazPqq3uyiryguslvDCBdACY/O
         BUA84tAR6UOEJbkq2g2Z8xJjLVhd91oIZM+EjDd33lz4x/ooEEthr1qFRPDtFjodJ1Up
         a9W5oPgqPBHyMSuv0W9ljMXcBpNXTpu6n3FkQU/uFClxoYxU8kZhMunTXQ7a8KlYegMh
         1x9kIlQeDmuqZFRT610FG5cS6GbUozYFhbfBmTOHypzieznrkcSa3L4R8hq9AQI3pJ3U
         RCDA==
X-Received: by 10.180.74.167 with SMTP id u7mr12970wiv.18.1412898986886;
        Thu, 09 Oct 2014 16:56:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.80.198 with SMTP id t6ls36646wix.27.gmail; Thu, 09 Oct
 2014 16:56:25 -0700 (PDT)
X-Received: by 10.194.92.13 with SMTP id ci13mr42552wjb.5.1412898985977;
        Thu, 09 Oct 2014 16:56:25 -0700 (PDT)
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com. [2a00:1450:400c:c00::22e])
        by gmr-mx.google.com with ESMTPS id p7si227000wiz.1.2014.10.09.16.56.25
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 Oct 2014 16:56:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of mingw.android@gmail.com designates 2a00:1450:400c:c00::22e as permitted sender) client-ip=2a00:1450:400c:c00::22e;
Received: by mail-wg0-f46.google.com with SMTP id l18so2571464wgh.17
        for <msysgit@googlegroups.com>; Thu, 09 Oct 2014 16:56:25 -0700 (PDT)
X-Received: by 10.181.13.73 with SMTP id ew9mr1144866wid.56.1412898985857;
 Thu, 09 Oct 2014 16:56:25 -0700 (PDT)
Received: by 10.217.160.9 with HTTP; Thu, 9 Oct 2014 16:56:25 -0700 (PDT)
Received: by 10.217.160.9 with HTTP; Thu, 9 Oct 2014 16:56:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1410092146310.990@s15462909.onlinehome-server.info>
X-Original-Sender: mingw.android@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of mingw.android@gmail.com designates 2a00:1450:400c:c00::22e
 as permitted sender) smtp.mail=mingw.android@gmail.com;       dkim=pass
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

--f46d04388eb127d8530505062ecf
Content-Type: text/plain; charset=UTF-8

Thanks Johannes.

On Thu, Oct 9, 2014 at 8:47 PM, Johannes Schindelin <
Johannes.Schindelin@gmx.de> wrote:
> Hi Ray,
>
> On Thu, 9 Oct 2014, Ray Donnelly wrote:
>
>> On Thu, Oct 9, 2014 at 8:22 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Wed, 8 Oct 2014, Marat Radchenko wrote:
>> >
>> >> +CC_MACH := $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo
not')
>> >
>> > There is a rather huge problem with that. The latest mingw-w64
>> > release, 4.9.1, does not do what you expect here: while
>> > '.../mingw32/bin/gcc -m32 -o 32.exe test.c' and '.../mingw32/bin/gcc
>> > -m64 -o 64.exe test.c' work fine, producing i686 and x86_64
>> > executables respectively, '.../mingw32/bin/gcc -dumpmachine' prints
>> > i686-w64-mingw32 *always*, even when specifying the -m64 option.
>> >
>> > So unfortunately, the test introduced by this patch (intended to
>> > figure out whether the build targets i686, and skip a compiler and a
>> > linker option otherwise) is incorrect.
>>
>> Which release are you talking about? Can you point me to the tarball
>> please?
>
> Certainly:
>
>
http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.1/threads-win32/sjlj/
>
> (rev1, not rev0)

I guess I can add passing in CFLAGS also to try to catch that case. What
would you recommend?

I've added support to build using your branch to MSYS2's MINGW-packages
git-git package in case anyone wants to help out:

https://github.com/Alexpux/MINGW-packages/tree/master/mingw-w64-git-git

Change _based_on_dscho_w64_msysgit=no to =yes. Note also that some more
patches are needed before we can build, and I think more are needed. Using
plain msysGit (I.e. =no) and 15 patches we are able to build a somewhat
functional git.

>
> Ciao,
> Johannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--f46d04388eb127d8530505062ecf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks Johannes.</p>
<p dir=3D"ltr">On Thu, Oct 9, 2014 at 8:47 PM, Johannes Schindelin &lt;<a h=
ref=3D"mailto:Johannes.Schindelin@gmx.de">Johannes.Schindelin@gmx.de</a>&gt=
; wrote:<br>
&gt; Hi Ray,<br>
&gt;<br>
&gt; On Thu, 9 Oct 2014, Ray Donnelly wrote:<br>
&gt;<br>
&gt;&gt; On Thu, Oct 9, 2014 at 8:22 PM, Johannes Schindelin<br>
&gt;&gt; &lt;<a href=3D"mailto:Johannes.Schindelin@gmx.de">Johannes.Schinde=
lin@gmx.de</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Wed, 8 Oct 2014, Marat Radchenko wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; +CC_MACH :=3D $(shell sh -c &#39;$(CC) -dumpmachine 2&gt;=
/dev/null || echo not&#39;)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; There is a rather huge problem with that. The latest mingw-w6=
4<br>
&gt;&gt; &gt; release, 4.9.1, does not do what you expect here: while<br>
&gt;&gt; &gt; &#39;.../mingw32/bin/gcc -m32 -o 32.exe test.c&#39; and &#39;=
.../mingw32/bin/gcc<br>
&gt;&gt; &gt; -m64 -o 64.exe test.c&#39; work fine, producing i686 and x86_=
64<br>
&gt;&gt; &gt; executables respectively, &#39;.../mingw32/bin/gcc -dumpmachi=
ne&#39; prints<br>
&gt;&gt; &gt; i686-w64-mingw32 *always*, even when specifying the -m64 opti=
on.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So unfortunately, the test introduced by this patch (intended=
 to<br>
&gt;&gt; &gt; figure out whether the build targets i686, and skip a compile=
r and a<br>
&gt;&gt; &gt; linker option otherwise) is incorrect.<br>
&gt;&gt;<br>
&gt;&gt; Which release are you talking about? Can you point me to the tarba=
ll<br>
&gt;&gt; please?<br>
&gt;<br>
&gt; Certainly:<br>
&gt;<br>
&gt; <a href=3D"http://sourceforge.net/projects/mingw-w64/files/Toolchains%=
20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.1/threads-win32/sjl=
j/">http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting=
%20Win32/Personal%20Builds/mingw-builds/4.9.1/threads-win32/sjlj/</a><br>
&gt;<br>
&gt; (rev1, not rev0)</p>
<p dir=3D"ltr">I guess I can add passing in CFLAGS also to try to catch tha=
t case. What would you recommend?</p>
<p dir=3D"ltr">I&#39;ve added support to build using your branch to MSYS2&#=
39;s MINGW-packages git-git package in case anyone wants to help out:</p>
<p dir=3D"ltr"><a href=3D"https://github.com/Alexpux/MINGW-packages/tree/ma=
ster/mingw-w64-git-git">https://github.com/Alexpux/MINGW-packages/tree/mast=
er/mingw-w64-git-git</a></p>
<p dir=3D"ltr">Change _based_on_dscho_w64_msysgit=3Dno to =3Dyes. Note also=
 that some more patches are needed before we can build, and I think more ar=
e needed. Using plain msysGit (I.e. =3Dno) and 15 patches we are able to bu=
ild a somewhat functional git.</p>
<p dir=3D"ltr">&gt;<br>
&gt; Ciao,<br>
&gt; Johannes</p>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--f46d04388eb127d8530505062ecf--
