From: "chongyc" <chongyc27@gmail.com>
Subject: Error : git svn fetch
Date: Tue, 23 Dec 2008 20:12:22 +0800
Message-ID: <EFF48A5B1B204E18A68F7CC928E12058@VMware>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ks_c_5601-1987";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 13:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF68x-0000iz-7T
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 13:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYLWMM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 07:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYLWMM3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 07:12:29 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:26830 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYLWMM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 07:12:28 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2633453wfd.4
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 04:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=DkFN0IQY1sct0PXOTdqwHmNFh6PrYocQA+OABYZgHIs=;
        b=TBhtrEhjzyw5MVI720NxbnRy35vSVlXDF3TYJb30dZ6D8Bvngk5lqQsgwd1inCuakH
         OYDQUk0sfLP+milwlzIS2w8ylogDhbvjytF8bSLABQJnGej0sVsO8XqEXfOuDuN/5OA5
         a+HV8nqbsne3Ca99k5CVCCoTs0I61nXeTl9rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=OLRfTELbUD2/HEj0Hyx90ZOAMslrKxkNJOVOeQdcWc+3bXCQvyNptyU1ODVeYKshHv
         kW7/Xsr7ynOEK1Jzoh0+EvvI5ZH5nTeGCYJa8pKND+aGnHyvHa0yJRrYBo1GJuyyH3xR
         V6nBOT0L7U3b5U3CeLE1HQRFA2J3syHUbu1XQ=
Received: by 10.142.246.19 with SMTP id t19mr3153011wfh.9.1230034347640;
        Tue, 23 Dec 2008 04:12:27 -0800 (PST)
Received: from VMware ([221.200.196.26])
        by mx.google.com with ESMTPS id 20sm15980745wfi.47.2008.12.23.04.12.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Dec 2008 04:12:26 -0800 (PST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103813>

Hi

I found that 'git svn fetch' failed in cloning the hudson svn reposotory.

I want to git-clone the svn repository

svn repository URL : https://svn.dev.java.net/svn/hudson/
username : guest
password :


So I run followings to git-clone

[root@localhost hudson]# git --version
git version 1.6.0.6
[root@localhost hudson]# git svn init -T trunk -t tags -b branches 
https://svn.dev.java.net/svn/hudson/
[root@localhost hudson]# git svn fetch
Found possible branch point: 
https://svn.dev.java.net/svn/hudson/tags/hudson-1_230 => 
https://svn.dev.java.net/svn/hudson/branches/buildnav-1636, 10490
Initializing parent: buildnav-1636@10490
Found possible branch point: 
https://svn.dev.java.net/svn/hudson/trunk/hudson/main => 
https://svn.dev.java.net/svn/hudson/tags/hudson-1_230, 10450
Initializing parent: buildnav-1636@10450
Found branch parent: (buildnav-1636@10490) a1c395e5db063ca1ffbbe008e309c5
11d56219e0
Following parent with do_switch
remoting/pom.xml was not found in commit 
a1c395e5db063ca1ffbbe008e309c511d56219e0 (r10447)
[root@localhost hudson]#

What shall I do to git-clone it ?

Please help me

>From chongyc 
