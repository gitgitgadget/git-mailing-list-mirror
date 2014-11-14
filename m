From: Axel Magard <axel_magard@de.ibm.com>
Subject: Question about chapter "3.1 Git Branching - Branches in a Nutshell" in git
 docu
Date: Fri, 14 Nov 2014 15:39:29 +0100
Message-ID: <OF6CCD47D8.ABB2F49C-ONC1257D90.004E1845-C1257D90.005084C1@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 15:39:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpI2E-00068K-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 15:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbaKNOjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 09:39:35 -0500
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:51502 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965136AbaKNOje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 09:39:34 -0500
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <axel_magard@de.ibm.com>;
	Fri, 14 Nov 2014 14:39:32 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
	by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Fri, 14 Nov 2014 14:39:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2DA562190043
	for <git@vger.kernel.org>; Fri, 14 Nov 2014 14:39:04 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAEEdUGl10617152
	for <git@vger.kernel.org>; Fri, 14 Nov 2014 14:39:30 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAEEdTQk014092
	for <git@vger.kernel.org>; Fri, 14 Nov 2014 07:39:29 -0700
Received: from d06ml038.portsmouth.uk.ibm.com (d06ml038.portsmouth.uk.ibm.com [9.149.76.238])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAEEdTOU014082
	for <git@vger.kernel.org>; Fri, 14 Nov 2014 07:39:29 -0700
Importance: Normal
X-Priority: 3 (Normal)
Reply-By: 
Expiry-Date: 
X-KeepSent: 6CCD47D8:ABB2F49C-C1257D90:004E1845;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1SHF211 December 19, 2013
X-MIMETrack: Serialize by Router on D06ML038/06/M/IBM(Release 9.0.1FP2|August  03, 2014) at
 14/11/2014 15:39:29,
	Serialize complete at 14/11/2014 15:39:29
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14111414-0009-0000-0000-000001FD3F2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,
either I still didn't grasp it or there is a mistake in chapter 3.1 "3.1 
Git Branching - Branches in a Nutshell" 
(http://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)

The last figure on that page shows that branch 'master' and HEAD are 
pointing to patch 87ab2, branch 'testing' to c2b9e.
 
But the output from git log --oneline --decorate --graph --all 
shows this:

* c2b9e (HEAD, master) made other changes
| * 87ab2 (testing) made a change
|/
* f30ab add feature #32 - ability to add new formats to the
* 34ac2 fixed bug #1328 - stack overflow under certain conditions
* 98ca9 initial commit of my project

Shouldn't it look like this ?

* 87ab2 (HEAD, master) made a change
| * c2b9e (testing) made other changes
|/
* f30ab add feature #32 - ability to add new formats to the
* 34ac2 fixed bug #1328 - stack overflow under certain conditions
* 98ca9 initial commit of my project

Cheers ... Axel Magard 
