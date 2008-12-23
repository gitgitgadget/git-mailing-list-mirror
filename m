From: "chongyc" <chongyc27@gmail.com>
Subject: Error : git svn fetch
Date: Tue, 23 Dec 2008 20:25:30 +0800
Message-ID: <E48CF49FF0FE4F96BE206B2689165AF9@VMware>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 13:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF6N1-0004tE-Tq
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 13:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbYLWM04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 07:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYLWM04
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 07:26:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:23214 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYLWM0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 07:26:55 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2349122rvb.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 04:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:x-priority:x-msmail-priority:x-mailer:x-mimeole:x-rfc2646;
        bh=DkFN0IQY1sct0PXOTdqwHmNFh6PrYocQA+OABYZgHIs=;
        b=xmNU59gPVKxj260J6+buNrFUsKfNNTxnZYuGf9iu3q9i01cezTNch1MkZxF5rJB0zg
         FjXk4GnSIDVLee5loK22tQQK2oPZ/Vm1gfdnjmzjsbMvj1JL5K8sis11+y5I/353ogln
         cDnkIkpGirqVV+HBOc4rHVSFmcc2QHMhqOqOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:subject:date:x-priority:x-msmail-priority
         :x-mailer:x-mimeole:x-rfc2646;
        b=TiUvXmkwBGBACyMa473lSa+fN4KfDUszz7sfBCjp/nN6DWBfHRGpsPbKQF15VAcpQV
         Qgt79PBnBxaZWPjCNSOGWU8cIbzsEcbrNSTPsg5WY1/EVvAQls8z3R5BnCngnGOyivTw
         G/W7FlcEcbI76WActh+rr0Jyb8woArtEsVUKo=
Received: by 10.143.6.1 with SMTP id j1mr3153308wfi.152.1230035135332;
        Tue, 23 Dec 2008 04:25:35 -0800 (PST)
Received: from VMware ([221.200.196.26])
        by mx.google.com with ESMTPS id 30sm23982568wfc.35.2008.12.23.04.25.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Dec 2008 04:25:34 -0800 (PST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103815>

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
