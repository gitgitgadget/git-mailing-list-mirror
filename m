From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Thu, 22 Jan 2015 22:51:37 +0100
Message-ID: <54C170E9.4010401@web.de>
References: <20150114211712.GE1155@peff.net>	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>	<20150115222719.GA19021@peff.net>	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>	<20150115235752.GB25120@peff.net>	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>	<20150116013256.GA25894@peff.net>	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de> <xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>, 
 msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?=
 =?UTF-8?B?c2Vu?= <tboegi@web.de>
X-From: msysgit+bncBCUZ3EUT2ADRB3PBQWTAKGQE6N3KAZQ@googlegroups.com Thu Jan 22 22:51:42 2015
Return-path: <msysgit+bncBCUZ3EUT2ADRB3PBQWTAKGQE6N3KAZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRB3PBQWTAKGQE6N3KAZQ@googlegroups.com>)
	id 1YEPfC-0006GD-5S
	for gcvm-msysgit@m.gmane.org; Thu, 22 Jan 2015 22:51:42 +0100
Received: by mail-wi0-f185.google.com with SMTP id fb4sf467058wid.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 22 Jan 2015 13:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=YNmIeXbO0cEc911sfWqZCXuNtoNgEGdmtSSohgQzHy0=;
        b=SlSMGIXsP0gnrTEIs3wI0saEGFptZ60CCQSljBHpOoxLM4UBQjLg3Db4aTPUklspAJ
         i4iXUyyfZhyhlOwbPWefnWNZ8RE283TodU8+fewNbaCa0C8ORnB1BGcKeFuEGFPDaGXb
         /eT1jdZvlyglUHxBuaK1teYPSENqhDnkRTT7Bnk8pC/d+PtqVrTubkiPLi6XAFmAod2E
         mrrGfwFBYJIpPQBwaEU85vTVqiznBwdNdxYw3O3t+bWViOawUr0rGMEMuFjiqFSyXShH
         +t4UF7o3I9XGcDWuwr3ZZtDHPL7V8+vjqv/+RTzvBkL7CKeJXPV+VSS2FXPkW8eIvxS0
         h5yQ==
X-Received: by 10.152.241.7 with SMTP id we7mr45003lac.24.1421963501838;
        Thu, 22 Jan 2015 13:51:41 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.116.14 with SMTP id js14ls226269lab.69.gmail; Thu, 22 Jan
 2015 13:51:40 -0800 (PST)
X-Received: by 10.112.140.65 with SMTP id re1mr4990lbb.4.1421963500616;
        Thu, 22 Jan 2015 13:51:40 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.17.11])
        by gmr-mx.google.com with ESMTPS id jv2si17980wid.1.2015.01.22.13.51.40
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2015 13:51:40 -0800 (PST)
Received-SPF: pass (google.com: domain of tboegi@web.de designates 212.227.17.11 as permitted sender) client-ip=212.227.17.11;
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LqlSQ-1XkHqS00lm-00eLTZ; Thu, 22 Jan 2015 22:51:38
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:2G4hyv9LQZJ8iaOQkA+0r/ZrCQOiRFeG9BnRPwcQY47dZyJ3UnC
 4bzo+n55cT4CY3L3UaTUEi9KSA8SoY4c7KeJW1Wy8TgyudWQnBMFnnUhv5P9D+aLcYSIT0C
 86yjr+mULza2qX/SOVyMf9jOBOG4OHdOBSv2iISBO5PYE/2R0UOgtF+sGRdf2cK6swvdJno
 HEbPQVGjkVOAuHCLRydWg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of tboegi@web.de designates 212.227.17.11 as permitted
 sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262874>

On 2015-01-21 23.33, Junio C Hamano wrote:
 > Are you reporting differences between the state before these patches
> and after, or just the fact that with these patches the named tests
> break (which may or may not be broken before the patches)?
> 
The intention was to report what is now breaking.
One example is this one:
---------------------
git.git/master:
ok 15 # skip Test that "git rm -f" fails if its rm fails (missing SANITY)

git.git/pu:
not ok 15 - Test that "git rm -f" fails if its rm fails
#    
#        chmod a-w . &&
#        test_must_fail git rm -f baz &&
#        chmod 775 .
#     

The next step could be to dig further:

If I run that sequence manually:
chmod 755 .
touch x
chmod a-w .
rm x
touch y

x is gone, (but shoudn't according to POSIX)
y is not created, "access denied"

--------------
I can see that there are 3 groups of OS/FS combinations:
Group 1:
  File access bits are not maintained, and not obeyed.
  Typical: VFAT, Git for Windows, (and some network protocols like SAMBA,
	           depending on the OS/FS involved and/or the mount options)
  Typically core.filemode is false after "git init"

Group 2:
  File access bits are maintained and obeyed:
  POSIX/Unix/Linux/Mac OS and CYGWIN
  Typically core.filemode is true after "git init"

Group 3 :
  File access bits are maintained, but not (fully) obeyed
  running as root under Linux/Unix...
  Or Windows, when a file is allowed to be deleted from a directory without write permissions.

-----------------
In short, the following seems to be an improvement:
diff --git a/t/test-lib.sh b/t/test-lib.sh
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1039,7 +1039,17 @@ test_lazy_prereq NOT_ROOT '
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test_lazy_prereq SANITY '
-       test_have_prereq POSIXPERM,NOT_ROOT
+       mkdir ds &&
+       touch ds/x &&
+       chmod -w ds &&
+       if rm ds/x
+       then
+               chmod +w ds
+               false
+       else
+               chmod +w ds
+               true
+       fi
 '

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
