From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t0008-ignores failure (was: Git for Windows 1.8.3)
Date: Thu, 30 May 2013 17:15:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1305301713400.650@s15462909.onlinehome-server.info>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com> <51A6A7B7.4010802@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Pat Thoyts <patthoyts@gmail.com>, msysGit <msysgit@googlegroups.com>, 
    Sebastian Schuberth <sschuberth@gmail.com>, Git List <git@vger.kernel.org>, 
    Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB7OZTWGQKGQEFFY2P6Q@googlegroups.com Thu May 30 17:15:11 2013
Return-path: <msysgit+bncBCZPH74Q5YNRB7OZTWGQKGQEFFY2P6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f60.google.com ([209.85.215.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB7OZTWGQKGQEFFY2P6Q@googlegroups.com>)
	id 1Ui4ZK-0007zt-FQ
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 17:15:10 +0200
Received: by mail-la0-f60.google.com with SMTP id fo13sf102015lab.25
        for <gcvm-msysgit@m.gmane.org>; Thu, 30 May 2013 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :x-y-gmx-trusted:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=I5XoZu6BrC+3GJBkC+M1QrFETZFOsbwrHrXcRovI6V8=;
        b=WHChVm91s3U1GyZ5F1ha2nY1YysRN9UvaPrFtsQR+6mi1l/vEL3xAJN255WtiZFpi9
         PW/dVdxj1fegzJTTVMQmxZUplvBrEM4cdGHdRJ5cVZYSb2ubZwBrFQu9z9GeIysJhF0l
         S1at3ZgWL56pdvde1YrUgLhgOFbDMEdj8R23xrywvzdlWwP+cmlS7yUQ+K8tP02mN7+A
         YNW0RIUroIzDy1U8cePlI8SjcM4Ch2UC2WExxuR4JHGb15ivebUwiNJTu0wO7EupXdU/
         JzXqJGwt3gfPFrXbH7lPpYIj8NKrBMG 
X-Received: by 10.180.104.73 with SMTP id gc9mr2101832wib.9.1369926910065;
        Thu, 30 May 2013 08:15:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.198.142 with SMTP id jc14ls1711459wic.34.canary; Thu, 30
 May 2013 08:15:09 -0700 (PDT)
X-Received: by 10.15.44.65 with SMTP id y41mr9569611eev.5.1369926909211;
        Thu, 30 May 2013 08:15:09 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTP id bj52si10024396eeb.1.2013.05.30.08.15.09
        for <msysgit@googlegroups.com>;
        Thu, 30 May 2013 08:15:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MB0kk-1UY8Ou41wq-009wtI for
 <msysgit@googlegroups.com>; Thu, 30 May 2013 17:15:09 +0200
Received: (qmail invoked by alias); 30 May 2013 15:15:08 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp020) with SMTP; 30 May 2013 17:15:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195PWJmC0Z5jRQy+gy/LzRP43Q7M2XPNmTp3pZAMq
	t0LL9Ks1zmT33Q
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <51A6A7B7.4010802@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226010>

Hi Karsten,

On Thu, 30 May 2013, Karsten Blees wrote:

> Am 25.05.2013 21:16, schrieb Pat Thoyts:
> > On that note -- with this merge as it now stands I get the following
> > test failures:
> > 
> > t0008-ignores.sh                     155, 158, 162, 164
> 
> These tests fail because they use absolute paths, e.g. "C:/.../global-excludes", which is then translated to "C<NUL>/.../global-excludes". Can be fixed like so:
> 
> --- 8< ---
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -5,7 +5,7 @@ test_description=check-ignore
>  . ./test-lib.sh
> 
>  init_vars () {
> -       global_excludes="$(pwd)/global-excludes"
> +       global_excludes="global-excludes"
>  }
> 
>  enable_global_excludes () {
> ---

Since I do not have time for the lengthy, undirected discussion upstream
seems to want to start, let's make your change, but only conditional on
MINGW?

Ciao,
Dscho

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
For more options, visit https://groups.google.com/groups/opt_out.
