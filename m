From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Issue 125 in msysgit: gitk crashes when quit while reading
 (fwd)
Date: Sat, 28 Feb 2009 00:45:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902280044050.10279@pacific.mpi-cbg.de>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: patthoyts@gmail.com, git@vger.kernel.org, msysgit@googlegroups.com
To: paulus@samba.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Feb 28 00:46:01 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f181.google.com ([209.85.217.181])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdCOz-0007vW-AA
	for gcvm-msysgit@m.gmane.org; Sat, 28 Feb 2009 00:45:57 +0100
Received: by gxk1 with SMTP id 1so1218432gxk.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Feb 2009 15:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:message-id:user-agent:mime-version:content-type
         :x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=02aTdnYYccXC6Mxtf8mkzmH2dk0+5Nq69+6usTC2USU=;
        b=ZA1t+OZpWfZrlAa72mhRyAFXn5brlvGvNfHNh33s8IcS//3TumIrRoZM7comNUHwN+
         n73zRTu6XfRMZKmerU3pwb+wXOJOWq+giWj9AjmSAe+1XcnZZfzxOY/nihkTrzPWZpaU
         XiFPZNsDSk904pRNpaYrSPkbhzW1QlnvyZIIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :message-id:user-agent:mime-version:content-type:x-y-gmx-trusted
         :x-fuhafi:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=PhFnpZP7eQ8yohaagV2lXdEiL3Wfrl1r13ZdQY6xaRok0seCOrxPrtMf46mFFJLA08
         0sVGyU4iSJoA/mymeAKbT/aDiyRU/vy9NP7zpKQEjWwVFj6gYxFtH4CrqpHJyb5ySHqy
         xzM8ekR+ARZzC6kj6oQvONZ6kLEYlIzQo8+ho=
Received: by 10.90.80.18 with SMTP id d18mr532580agb.8.1235778267978;
        Fri, 27 Feb 2009 15:44:27 -0800 (PST)
Received: by 10.177.6.2 with SMTP id j2gr3736yqi.0;
	Fri, 27 Feb 2009 15:44:27 -0800 (PST)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.181.26.7 with SMTP id d7mr59772bkj.25.1235778266942; Fri, 27 Feb 2009 15:44:26 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 16si1142443bwz.4.2009.02.27.15.44.26; Fri, 27 Feb 2009 15:44:26 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 27 Feb 2009 23:44:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp006) with SMTP; 28 Feb 2009 00:44:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NRWcMARzNcS8g+IY3o6J9xMuBDBjQ4SMQY0dnG1 t/z6S8s8StHNFr
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111724>


Hi Paul,

this came in through msysGit's issue tracker, from a guy who is involved 
in the Tk project.

---------- Forwarded message ----------
Date: Fri, 27 Feb 2009 23:12:11 +0000
From: codesite-noreply@google.com
To: msysgit@googlegroups.com
Subject: [msysGit] Issue 125 in msysgit: gitk crashes when quit while reading



Comment #4 on issue 125 by patthoyts: gitk crashes when quit while reading
http://code.google.com/p/msysgit/issues/detail?id=125

The simplest fix for all current versions of Tk is to apply the following patch
to
gitk which will flush all the geometry events before it begins reading the
commit
ids. This avoids the crash. A fix has now been applied to Tk 8.5 and HEAD
branches to
avoid this in the future.

diff --git a/gitk b/gitk
index dc2a439..197bc67 100755
--- a/gitk
+++ b/gitk
@@ -10884,6 +10884,7 @@ makewindow
# wait for the window to become visible
tkwait visibility .
wm title . "[file tail $argv0]: [file tail [pwd]]"
+update
readrefs

if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {

--
You received this message because you are listed in the owner
or CC fields of this issue, or because you starred this issue.
You may adjust your issue notification preferences at:
http://code.google.com/hosting/settings
