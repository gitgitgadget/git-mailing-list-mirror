From: "chongyc" <chongyc27@gmail.com>
Subject: Error : git svn fetch
Date: Tue, 23 Dec 2008 20:13:10 +0800
Message-ID: <59ABE69F8B2E42BEB9091CC7EA87A275@VMware>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ks_c_5601-1987";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 13:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF69p-0000zp-Ea
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 13:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbYLWMNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 07:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbYLWMNR
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 07:13:17 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:26941 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYLWMNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 07:13:16 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2633728wfd.4
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 04:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=DkFN0IQY1sct0PXOTdqwHmNFh6PrYocQA+OABYZgHIs=;
        b=kADu0IqcZs4Ip0kctMqsPeo6azLdiNIGB0IyYnS1quBalAFQ5Dz/I6ElQzLFwSBlWO
         6k3b58bzcHFDySjmX9WV8ygeLBXi7RvkFF+QRdl0VOB5LtDhuKpOt1RbcDAzJEHarXzr
         Fw9HbgUncx/X0eaAO5l9NH/Qowk1PP6HgxV2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=RXciNRDF3J8H3DbZ5QIhmI394QZY4Q3mVAHEYxjR8b8DTbTqbiXPR3TNgR54zCHfYo
         F2BFD5CpVFsbNVxQV+0GhkaWxEvYnl7dwiV9lgcVH07xlW9LbB0r1dyRg4tBcYMWTiUN
         8rFU+deab4AcPOsgDTXNWsHOc0D2you5h+7VU=
Received: by 10.142.162.5 with SMTP id k5mr3154711wfe.49.1230034395609;
        Tue, 23 Dec 2008 04:13:15 -0800 (PST)
Received: from VMware ([221.200.196.26])
        by mx.google.com with ESMTPS id 32sm28367480wfa.40.2008.12.23.04.13.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Dec 2008 04:13:14 -0800 (PST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103814>

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
