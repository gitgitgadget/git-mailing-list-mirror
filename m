From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/4] gitweb: Some improvements
Date: Mon, 4 Sep 2006 18:10:09 +0200
Message-ID: <200609041810.09838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 18:37:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKHRa-0002bY-OH
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 18:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWIDQg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWIDQgz
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 12:36:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:6629 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751469AbWIDQgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 12:36:55 -0400
Received: by nz-out-0102.google.com with SMTP id n1so855128nzf
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 09:36:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VuAzbg1syGS7jGSj1Uit2prW1L8PAERn/bXbfCyjN3I4MJS8UFyma+iImZVsVbac9JQvH3lOgreweSksH4NV4s/U6U10MK7f7A3dtgUptiUHMTl+SBv5D4mBxfCOBrkzWTZ2wemQ7UYGxkSM4fmroGlogvcoUoqs4tIb2i71XdE=
Received: by 10.64.149.15 with SMTP id w15mr5821742qbd;
        Mon, 04 Sep 2006 09:36:54 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c5sm3859928qbc.2006.09.04.09.36.53;
        Mon, 04 Sep 2006 09:36:54 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26422>

This is small series of patches, applicable both to 'master' and 'next',
which adds simple improvements, or in the case of last patch
fix bug/typo.

First two patches were sent earlier, I don't know if they were dropped
or forgotten. 

---
Diffstat:
 Makefile               |    2 ++
 gitweb/git-favicon.png |  Bin
 gitweb/gitweb.perl     |   44 +++++++++++++++++++++++++++++++-------------
 3 files changed, 33 insertions(+), 13 deletions(-)

Shortlog:
 gitweb: Add GIT favicon, assuming image/png type.
 gitweb: Change the name of diff to parent link in "commit" view to "diff"
 gitweb: Divide page path into directories -- path's "breadcrumbs"
 gitweb: Correct typo: '==' instead of 'eq' in git_difftree_body

-- 
Jakub Narebski
ShadeHawk on #git
Poland
