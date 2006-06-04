From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Using subversion tools on Mozilla CVS
Date: Sat, 3 Jun 2006 23:09:00 -0400
Message-ID: <9e4733910606032009p252ff5fai7401401427ae3ec3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 04 05:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmizF-0004wN-CC
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 05:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWFDDJD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 23:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWFDDJD
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 23:09:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:18493 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751449AbWFDDJB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 23:09:01 -0400
Received: by nz-out-0102.google.com with SMTP id s18so931180nze
        for <git@vger.kernel.org>; Sat, 03 Jun 2006 20:09:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZZOcWNcdBnuEhJNB+VTvFxVkhJ9IsCe9xj8c513x+jnUpGTJhNT13+L4hRHgcN+ERzRjA4Vb8/sxOnO/vhMTmlx9DKkTs53RqPsR+3zWp08ehri22meNc/VdP69z0UdcHmXyR5XgQ/a40qcedyhhffNsVZiYxVTG1cNXZoE6QH0=
Received: by 10.36.33.17 with SMTP id g17mr1925742nzg;
        Sat, 03 Jun 2006 20:09:00 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Sat, 3 Jun 2006 20:09:00 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21244>

I found this tool written in Python for importing CVS into Subversion.
It seems to be handling the Mozilla CVS repository with fewer problems
than parsecvs.

http://cvs2svn.tigris.org/cvs2svn.html

Since I'm not a native Python speaker, anyone else want to give a try
at changing it to support git?

It found these symbols to be ambiguous, so I manually forced them the
way they look like they should be.

cvs2svn --trunk-only -s svntest \
  --force-tag=THUNDERBIRD_0_7_RELEASE --force-tag=CVS \
 --force-branch=JAVADEV_RTM_20001102 \
 --force-branch=XPCOM_BRANCH_LANDING_981104 \
 --force-branch=MOZILLA_1_3_BRANCH \
 --force-branch=N3 \
 --force-branch=SeaMonkey_M4_BRANCH \
 --force-branch=NORMANDY_BRANCH \
 --force-branch=FASTLOAD_20010529_BRANCH \
 --force-branch=MozillaSourceClassic_19981026_BRANCH \
 --force-branch=RDF_19981124_BRANCH \
 --force-branch=OTIS_TEST_BRANCH \
 --force-branch=Netscape61_PR1_Mini_BRANCH \
 --force-branch=XPCOM20_BRANCH \
 --force-branch=XPC_IDISP_20020417_BRANCH \
 --force-branch=RDF_122898_BRANCH \
 --force-branch=MOZILLA_1_4_BRANCH \
 --force-branch=Netscape_20000922_BRANCH \
 --force-branch=NETSCAPE_7_0_OEM_BRANCH \
 --force-branch=RDF_19990407_BRANCH \
 --force-branch=ALERT_SERVICE_BRANCH \
 --force-branch=SeaMonkey_M12_BRANCH \
 --force-branch=SpiderMonkey140_NES40Rtm_Branch \
mozilla/mozilla

-- 
Jon Smirl
jonsmirl@gmail.com
