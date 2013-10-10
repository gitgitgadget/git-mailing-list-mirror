From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Same test-path-utils behaves differently on different
 Windows systems
Date: Thu, 10 Oct 2013 17:52:15 +0200
Message-ID: <CAHGBnuORD-nTaYVVMt5WJhFnHU4oj0=5WiLXMAMa2Y4mz-vNXg@mail.gmail.com>
References: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, msysGit Mailinglist <msysgit@googlegroups.com>
To: worldhello.net@gmail.com, Johannes Sixt <j6t@kdbg.org>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBDZMLEGXWQLBBL423OJAKGQEHEIFQCA@googlegroups.com Thu Oct 10 17:52:18 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBL423OJAKGQEHEIFQCA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f63.google.com ([74.125.83.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBL423OJAKGQEHEIFQCA@googlegroups.com>)
	id 1VUIXA-0001sI-Gt
	for gcvm-msysgit@m.gmane.org; Thu, 10 Oct 2013 17:52:16 +0200
Received: by mail-ee0-f63.google.com with SMTP id c50sf246870eek.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=yZqcKBqKxBK0ncrq0Dxy8jdFLc5TtLdeqPZ5DfK03+s=;
        b=GmLyBAURRfVrXUavYBV5r4wjJfX0NwyJo5MEWLVKeDPDcGFwtFM+4rfDzfgPBYteGv
         LKIcr4B6P5l1vO7NivarAjwXLO1XQ7FEszezjoYm1GTftmoHd5qULrhM1GIsO/QxCQHw
         BJ49/aYVeG1pEh5tPcakgswQTvtbd1liiEixHRbini7G0p4mIJVoS6KNvnWA27RNG4gp
         +xvxS461/WPbF3qUCAhdsL8PJrH7QptNWCGa+KosE3DCbgnk1167gMUvgfY3+TJqoAIS
         UtoPrMk5FaeThdPeV2NBywhBW+9evY+jnYXamQY0QPKnuf5X06m5LB5gsOiEl5q6z3Tk
         UBDQ==
X-Received: by 10.152.36.9 with SMTP id m9mr51644laj.13.1381420336211;
        Thu, 10 Oct 2013 08:52:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.9.99 with SMTP id y3ls163374laa.60.gmail; Thu, 10 Oct 2013
 08:52:15 -0700 (PDT)
X-Received: by 10.152.25.161 with SMTP id d1mr4374104lag.7.1381420335480;
        Thu, 10 Oct 2013 08:52:15 -0700 (PDT)
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com [2a00:1450:4010:c03::229])
        by gmr-mx.google.com with ESMTPS id qy6si3956375bkb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 08:52:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::229 as permitted sender) client-ip=2a00:1450:4010:c03::229;
Received: by mail-la0-x229.google.com with SMTP id ec20so2305971lab.28
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 08:52:15 -0700 (PDT)
X-Received: by 10.152.170.233 with SMTP id ap9mr704248lac.51.1381420335286;
 Thu, 10 Oct 2013 08:52:15 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 10 Oct 2013 08:52:15 -0700 (PDT)
In-Reply-To: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::229
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235867>

Hi again,

the problem can also be reproduced in an easier way, independently of
mingwGitDevEnv and using the mingw_path function instead of
relative_path. If I install msysGit 1.8.4 from [1] and run
test-path-utils I get this on Windows Server 2008 R2 64-bit:

$ test-path-utils mingw_path /a/b/
a:/b/

But if I install [1] on my local Windows 8 64-bit I get:

$ test-path-utils mingw_path /a/b/
C:/msysgit/msysGit/a/b/

So the only obvious thing that changed is the Windows version, but I
find it hard to believe that this influences MSYS path mangling.

[1] http://msysgit.googlecode.com/files/msysGit-fullinstall-1.8.4-preview20130916.exe

-- 
Sebastian Schuberth


On Thu, Oct 10, 2013 at 2:13 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:

> Hi,
>
> for my mingwGitDevEnv project [1] I'm currently looking at the failing
> Git tests [2]. The first tests that fails is t0060-path-utils [3]:
>
> not ok 88 - relative path: / /a/b/ => ../../
> # test "$(test-path-utils relative_path '/' '/a/b/')" = '../../'
>
> not ok 91 - relative path: /x/y /a/b/ => ../../x/y
> # test "$(test-path-utils relative_path '/x/y' '/a/b/')" = '../../x/y'
>
> If I run "test-path-utils relative_path '/' '/a/b/'" on the server
> (running Windows Server 2008 R2) that perform the testing I indeed
> get:
>
> $ test-path-utils relative_path '/' '/a/b/'
> ../../C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv
> $ pwd -W
> C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv/git
>
> The funny thing is, if I run the exact same binary on my local Windows
> 8 64-bit machine I get the expected result:
>
> $ test-path-utils relative_path '/' '/a/b/'
> ../../
> $ pwd -W
> C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv/git
>
> So how can the exact same test-path-utils binary create different
> results fo the same arguments? I'd be very grateful for any insights.
> If you want to play around with it yourself, you can download the
> while Jenkins workspace as a ZIP at [4] (but note that it's almost 1
> GiB).
>
> It's probably also interesting to mention that t0060-path-utils did
> not yet fail in build 38 [5] and I'm currently in the process to find
> out what changed.
>
> [1] https://github.com/sschuberth/mingwGitDevEnv/
> [2] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/42/
> [3] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/ws/test-results/t0060-path-utils.sh/*view*/
> [4] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/ws/mingwGitDevEnv/
> [5] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/38/
>
> --
> Sebastian Schuberth

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
