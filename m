From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 17:24:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404191719280.14982@s15462909.onlinehome-server.info>
References: <20140403131850.GA24449@seldon> <20140419063133.GA3617@book-mint>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: marat@slonopotamus.org, git@vger.kernel.org, 
    msysGit Mailinglist <msysgit@googlegroups.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: msysgit+bncBCZPH74Q5YNRBS5KZKNAKGQEVSMDZSY@googlegroups.com Sat Apr 19 17:25:01 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBS5KZKNAKGQEVSMDZSY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBS5KZKNAKGQEVSMDZSY@googlegroups.com>)
	id 1WbX8W-0005TG-6g
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 17:25:00 +0200
Received: by mail-lb0-f184.google.com with SMTP id u14sf213772lbd.1
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Apr 2014 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=yg58xhHKpRtWUiFzkGVpSSYXRAmCiL4TYQQpT05uI30=;
        b=S7WwiJrAkMgkKOaoD0P+0saBoYKeZFhaNwC/sM5ly/4nj8h1xiwsVNCPxWm+MHU2Vl
         77r+0C6M5563CdYt8/D+YR4vnfpMwyxYSwvDNt3SK2YoJz09ryndV0AIeUNF/aEBuHhl
         hcSnP7PsbWlemj2wdFBnrZkXgE9U97LK3v1OU2cqnanCgK1mRwWVIWhtaoPUHKTzl8Em
         oZ8Tnn5jvrOZT16fpk3eNOYJAKy2h/bt2kHCCjdhUgigEHhUaP2jtTUETKHBAaNJnOKW
         pBkUQvjTcMYvGBFRmYHyTFJEw8ZcQr8413i2qwuOj3q5hcH8s63k53VUV9q5zZyMZE58
         HS0w==
X-Received: by 10.180.87.68 with SMTP id v4mr40741wiz.1.1397921099763;
        Sat, 19 Apr 2014 08:24:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.96.2 with SMTP id do2ls191310wib.49.canary; Sat, 19 Apr
 2014 08:24:58 -0700 (PDT)
X-Received: by 10.180.87.71 with SMTP id v7mr625675wiz.2.1397921098862;
        Sat, 19 Apr 2014 08:24:58 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id u49si1767593eeo.1.2014.04.19.08.24.58
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256/256);
        Sat, 19 Apr 2014 08:24:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LzbXq-1Wwvuy0fgY-014iKh;
 Sat, 19 Apr 2014 17:24:34 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140419063133.GA3617@book-mint>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Zy0NMFJMBW0p2Xc3V+8JA1oMounZAiIywRKHqhNSqdtMr25pXHY
 vzSvjQUxGscrPKvCzg0s8Jg9ZbrW6q9083HHMjVVREoupmyovZhdp7Curp/HFFKWlwf5a4e
 Q4raX5RkFvlCzvYCmA1lr2HJL9pEHYrPK8P7zatNg6L0qaIzlrbXCGk2SslhL+Y7qEpaFgV
 HiZGsohbB00V0vulJnU0w==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246517>

Hi,

On Sat, 19 Apr 2014, Heiko Voigt wrote:

> On Thu, Apr 03, 2014 at 05:18:50PM +0400, marat@slonopotamus.org wrote:
> > I'm proud to announce WinGit:
> > an attempt to bring Git powers to 64-bit Windows.
> 
> So the reason for this new package is that you need 64bit binaries?
> 
> > Relationship with msysgit
> > =========================
> > 
> > Unlike msysgit, WinGit is a pure-Windows binary build with MSVC.

Marat, please do not add to the confusion. "msysGit" is the name of the
*development environment* for developing Git for Windows. It also brings
facilities to use MSVC instead of GCC.

So do not compare WinGit to msysgit (that would be like comparing Git to
GCC). Compare WinGit to Git for Windows (and clarify that you mean a
different WinGit than the old name of Git for Windows).

> > Like msysgit, WinGit also uses msys environment (sh/perl/etc) both
> > during build-time and runtime.

So it is not purely 64-bit, because MSys is not.

> I can see the need for a pure Windows solution (no msys tools at least for
> runtime). But this sounds to me that the only thing you changed is the
> compiler and 64bit? The git binaries in msysgit are already pure Windows
> binaries with no need of msys.dll. The only reason why so many other
> tools are shipped with msysgit is to run scripted commands (e.g. like
> gitk or rebase).
> 
> What is the reason of using a closed source compiler? Why not use the
> 64bit mingw that is already used to build the 64bit explorer extension
> to package 64bit binaries along with the 32bit ones in the installer?
> 
> Sorry if I am a little bit skeptic, but I am wondering whether it does
> make sense for you to join forces with msysgit instead of creating a
> fork? I think the main reason why there are no 64 bit binaries shipped
> with msysgit is that nobody needed them and the need to ship both (at
> least for some time).

We do have a facility to build 64-bit binaries with msysGit. It is even
dirt-easy: just run the two release scripts in /src/mingw-w64/, and then
build Git with "make W64=1".

The real reason why Git for Windows does not ship 64-bit binaries is that
they did not pass the test suite last time I tried.

And for the record: I would have welcome contributions to the Git for
Windows project. I still will. After all, there is no reason for yet
another fork.

Ciao,
Johannes

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
