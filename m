From: Karsten Blees <karsten.blees@gmail.com>
Subject: t0008-ignores failure (was: Git for Windows 1.8.3)
Date: Thu, 30 May 2013 03:13:27 +0200
Message-ID: <51A6A7B7.4010802@gmail.com>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Sebastian Schuberth <sschuberth@gmail.com>, 
 Git List <git@vger.kernel.org>,
 Adam Spiers <git@adamspiers.org>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBBN6PTKGQKGQEQ4IERZQ@googlegroups.com Thu May 30 03:13:30 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBN6PTKGQKGQEQ4IERZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f60.google.com ([209.85.214.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBN6PTKGQKGQEQ4IERZQ@googlegroups.com>)
	id 1UhrQn-0002Zu-8n
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 03:13:29 +0200
Received: by mail-bk0-f60.google.com with SMTP id jc10sf1687259bkc.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 May 2013 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=H8NLMZ7ZRoV4NzWgPP4iBYbcVWSohWp1s8IqZ69voqw=;
        b=tAfhC18d26ELlF5m4leBrk8KM/LPW9NGOQ3MEOZLlxVMRhC/r6BJY05eCqBlkwHeQo
         xYIYkhvWhTfGsO1Jglip4541gly+X23jsXZbisGr9C9lIAb9sKgXDi45yXvU+ntXqrjM
         p/aR3T64PYfRBJPZWpab+bmL9AM2T43R6BDF+j7kn6r+IPwSJy1yTpyK8h+vrz9j9ksY
         048ujeGoyo7RsaJW0DF4te0yQpP5aHa7qfzl4MLx5XhnO4dWVUIvsZk76M8geWBUehzJ
         V5Y81h+UeLEG2QzhFSKFcmia//5HEUSyo5CwrE9CiFMTT5BEtnizbJK4hty8f4f+413l
         ElXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=H8NLMZ7ZRoV4NzWgPP4iBYbcVWSohWp1s8IqZ69voqw=;
        b=n7ZgWXC1ZU07DRv7VvNMhAARBeSAmYbM8sW1GmMdTbVNRxNILcfBFfBUjLVCzHDlHy
         Goa8gMxybgUZPCg45loNKpuYvucNaDv5rguDlHH6i393FOeOliVSgqslCTMK3WZZSXPi
         Uxcsy3bLuzrEu/ph/Lc4cC6qRR0SEsRTfIV0yEShManqgojPlQ2ZDSlTt0fdsxmiV3Gq
         VFxcx4OzQzZSbQVkQRjF2PyAprj7eFd3tQr8qn+TUfj+3SKp4kLzAFjJDJ3ysNKf5e+Q
         VRsG3stLYwmGJbS0ozekMT1BPJhR8TGtFo1YPov2BhDi19eYyufEoBtuNWl79mixdPy2
         RIiQ==
X-Received: by 10.180.21.141 with SMTP id v13mr641820wie.0.1369876408860;
        Wed, 29 May 2013 18:13:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.212.41 with SMTP id nh9ls118440wic.32.gmail; Wed, 29 May
 2013 18:13:27 -0700 (PDT)
X-Received: by 10.14.95.6 with SMTP id o6mr6283949eef.2.1369876407535;
        Wed, 29 May 2013 18:13:27 -0700 (PDT)
Received: from mail-ea0-x22e.google.com (mail-ea0-x22e.google.com [2a00:1450:4013:c01::22e])
        by gmr-mx.google.com with ESMTPS id bj52si9442090eeb.1.2013.05.29.18.13.27
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 18:13:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c01::22e as permitted sender) client-ip=2a00:1450:4013:c01::22e;
Received: by mail-ea0-x22e.google.com with SMTP id z7so5758086eaf.19
        for <msysgit@googlegroups.com>; Wed, 29 May 2013 18:13:27 -0700 (PDT)
X-Received: by 10.15.108.6 with SMTP id cc6mr7847753eeb.28.1369876407422;
        Wed, 29 May 2013 18:13:27 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id g7sm57375841eew.15.2013.05.29.18.13.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 18:13:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c01::22e
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225906>

Am 25.05.2013 21:16, schrieb Pat Thoyts:
> On that note -- with this merge as it now stands I get the following
> test failures:
> 
> t0008-ignores.sh                     155, 158, 162, 164

These tests fail because they use absolute paths, e.g. "C:/.../global-excludes", which is then translated to "C<NUL>/.../global-excludes". Can be fixed like so:

--- 8< ---
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -5,7 +5,7 @@ test_description=check-ignore
 . ./test-lib.sh

 init_vars () {
-       global_excludes="$(pwd)/global-excludes"
+       global_excludes="global-excludes"
 }

 enable_global_excludes () {
---

However, this raises the question whether colon is such a good choice as separator in 'git-check-ignore --verbose' output.

':' conflicts at least with Windows absolute paths and ADS names, and also with URLs (in case someone finds 'git ls-files --exclude-from=http://git-tricks.foo/special-exclude-file' useful enough to implement :-)

I realize colon was chosen to mimic git-check-attr, however, check-attr prints relative paths only (I think?).

How about using TAB or '|' instead? AFAICT, these are typically not used in paths or glob patterns.

Cheers,
Karsten

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
