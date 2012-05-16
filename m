From: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>
Subject: Making git history strictly time safe
Date: Wed, 16 May 2012 15:47:11 -0700
Message-ID: <2EDEF5ABBE208442B7547C8D36B9D8840C4A03@nawespscez09v.nadsuswe.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 17 01:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUnFT-0005vv-8P
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760725Ab2EPXDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 19:03:09 -0400
Received: from NAWESDNIAX06O.nmci.navy.mil ([138.163.1.82]:52081 "EHLO
	NAWESDNIAX06O.nmci.navy.mil" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760720Ab2EPXDI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 19:03:08 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 May 2012 19:03:08 EDT
X-AuditID: 8aa30151-b7c35ae000000ee9-67-4fb41c6f8938
Received: from nawesdnieg09v.nadsuswe.nads.navy.mil (Gate1-Sandiego.nmci.navy.mil [138.163.0.41])
	by  (Symantec Mail Security) with SMTP id D4.F4.03817.F6C14BF4; Wed, 16 May 2012 21:30:23 +0000 (GMT)
Received: from nawesdnieb13v.nadsuswe.nads.navy.mil ([10.0.10.79]) by nawesdnieg09v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 16 May 2012 15:47:33 -0700
Received: from nawespsceb02v.nadsuswe.nads.navy.mil ([10.1.120.16]) by nawesdnieb13v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 16 May 2012 15:47:34 -0700
Received: from nawespscez09v.nadsuswe.nads.navy.mil ([10.1.120.174]) by nawespsceb02v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 16 May 2012 15:47:33 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Making git history strictly time safe
Thread-Index: Ac0ztdSPOp1roO6SQf6+yTm19V/JzA==
X-OriginalArrivalTime: 16 May 2012 22:47:33.0748 (UTC) FILETIME=[E201D340:01CD33B5]
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197905>

I am working towards git adoption on a project. One of the concerns is the fear that git history is not guaranteed to be time safe. How can I configure a git repository so users cannot push or pull changes into it that change it's history? This includes keeping users who work directly in the repository from doing a rebase. 
 
I've found...
http://stackoverflow.com/questions/2085871/strategy-for-preventing-or-catching-git-history-rewrite
 
Which recommends setting...
    
 git config --system receive.denyNonFastforwards true
 git config --system receive.denyDeletes true
 
...Is this enough to guarantee time safe history? 
 
Notes:
1. Only certain process-central repositories would need time safe history. 
2. Developers can change their history provided it does not impact anyone else. I don't care about this case (yet).
 
Brian P. Jones
Senior Software Engineer
Configuration Management
 
