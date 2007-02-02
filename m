From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Question: next, master and pu branches
Date: Fri, 2 Feb 2007 11:42:08 +0600
Message-ID: <200702021142.08975.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 06:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrBz-0002c5-K7
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 06:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423100AbXBBFm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 00:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423103AbXBBFm0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 00:42:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:28750 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423100AbXBBFm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 00:42:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so676523uga
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 21:42:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:x-uid:x-length:content-type:content-transfer-encoding;
        b=jOk9B/TYee22bjJH3HA4S4X7hZiMuYQSV5Pe4CCb3ngBDDWjqhJ3NK6jPzQg+tuSS3/mhdYZ209/7mHxsXgwbk1HCAz5hvCp2Zb68OQdLZtI5wzlecdXFuVZAOjQ/v/UJrZWwhCqhBzTnhSLuUYP9EB4Bv9uMd+UaGvmKmr23kE=
Received: by 10.67.20.3 with SMTP id x3mr3839481ugi.1170394944463;
        Thu, 01 Feb 2007 21:42:24 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id j3sm3783911ugd.2007.02.01.21.42.19;
        Thu, 01 Feb 2007 21:42:23 -0800 (PST)
User-Agent: KMail/1.8
Content-Disposition: inline
X-UID: 3792
X-Length: 1329
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38455>

Hello,

Can somebody explain the meaning of next and pu branches and some documenation 
about using topic branches.

My development model use two branches now: stable release and develment 
branch. All changes in the stable release branch are bug-fix only changes. 
All (or most) of them must go to development release. Now I do this using 
cherry-pick but it is not easy to track what was merged especialy when merge 
pruduce confic resloved by hands. Stable branch live long life, much more 
than 100 commits. 

It seems topic branches can help me here, but reading Documentation under git 
sources teach to make topic branch from the branch point and then merge it to 
both branches. This can work while stable branch has short life and was not 
heavily rewritten. 

If there any technique that can help me ?
