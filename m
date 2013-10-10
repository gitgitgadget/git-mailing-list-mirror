From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Same test-path-utils behaves differently on different
 Windows systems
Date: Thu, 10 Oct 2013 14:13:32 +0200
Message-ID: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, msysGit Mailinglist <msysgit@googlegroups.com>
To: worldhello.net@gmail.com, Johannes Sixt <j6t@kdbg.org>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBDZMLEGXWQLBB3NT3KJAKGQEQQMDTRY@googlegroups.com Thu Oct 10 14:13:34 2013
Return-path: <msysgit+bncBDZMLEGXWQLBB3NT3KJAKGQEQQMDTRY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f184.google.com ([209.85.215.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBB3NT3KJAKGQEQQMDTRY@googlegroups.com>)
	id 1VUF7W-0003Nn-AR
	for gcvm-msysgit@m.gmane.org; Thu, 10 Oct 2013 14:13:34 +0200
Received: by mail-ea0-f184.google.com with SMTP id z15sf232338ead.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:date:message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ostBKXk3SCoHQa3Yvvn8WvBQGP9edBqdnWVjrHcNBK0=;
        b=vSfQMQAAyu7KjHkYFtTwK9wk0SmGA+jeU0yN39MHWcGwqKMXKHbQj//XuAeRjaPDUt
         d6yKWY+/J7g+owVFhz3pFLLgRLDzFEAIke8gaIGpzJYMXnUdt+eyCasM+5U5yZ7itHDs
         3BADeG0IZmAuiObDXKoJGZCmBk06QkKTuP6IZGJT2xcoafDNOS3BBMG8LM7Gh7oQ3B7a
         W3O6mKlXvG1KsSw3aao2xtKyauEUVsFm2FCt7aX9HtAui5kVarKJs5Y/0BaX0cq7+5mW
         5q+iyafC/zZ6z0IpviEttRNB+rrouMh8c1T3S53Zk0cnZoupR4PCZDhCJiFhaBn5Kj5K
         e2qQ==
X-Received: by 10.152.197.37 with SMTP id ir5mr16127lac.18.1381407214015;
        Thu, 10 Oct 2013 05:13:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.197.98 with SMTP id it2ls128549lac.5.gmail; Thu, 10 Oct
 2013 05:13:33 -0700 (PDT)
X-Received: by 10.112.141.232 with SMTP id rr8mr4418633lbb.11.1381407213283;
        Thu, 10 Oct 2013 05:13:33 -0700 (PDT)
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com [2a00:1450:4010:c04::236])
        by gmr-mx.google.com with ESMTPS id re4si664539bkb.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 05:13:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c04::236 as permitted sender) client-ip=2a00:1450:4010:c04::236;
Received: by mail-lb0-f182.google.com with SMTP id c11so2026361lbj.13
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 05:13:33 -0700 (PDT)
X-Received: by 10.152.202.167 with SMTP id kj7mr1166271lac.43.1381407212922;
 Thu, 10 Oct 2013 05:13:32 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 10 Oct 2013 05:13:32 -0700 (PDT)
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c04::236
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235860>

Hi,

for my mingwGitDevEnv project [1] I'm currently looking at the failing
Git tests [2]. The first tests that fails is t0060-path-utils [3]:

not ok 88 - relative path: / /a/b/ => ../../
# test "$(test-path-utils relative_path '/' '/a/b/')" = '../../'

not ok 91 - relative path: /x/y /a/b/ => ../../x/y
# test "$(test-path-utils relative_path '/x/y' '/a/b/')" = '../../x/y'

If I run "test-path-utils relative_path '/' '/a/b/'" on the server
(running Windows Server 2008 R2) that perform the testing I indeed
get:

$ test-path-utils relative_path '/' '/a/b/'
../../C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv
$ pwd -W
C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv/git

The funny thing is, if I run the exact same binary on my local Windows
8 64-bit machine I get the expected result:

$ test-path-utils relative_path '/' '/a/b/'
../../
$ pwd -W
C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv/git

So how can the exact same test-path-utils binary create different
results fo the same arguments? I'd be very grateful for any insights.
If you want to play around with it yourself, you can download the
while Jenkins workspace as a ZIP at [4] (but note that it's almost 1
GiB).

It's probably also interesting to mention that t0060-path-utils did
not yet fail in build 38 [5] and I'm currently in the process to find
out what changed.

[1] https://github.com/sschuberth/mingwGitDevEnv/
[2] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/42/
[3] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/ws/test-results/t0060-path-utils.sh/*view*/
[4] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/ws/mingwGitDevEnv/
[5] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/38/

-- 
Sebastian Schuberth

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
