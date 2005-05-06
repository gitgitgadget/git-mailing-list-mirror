From: "Luck, Tony" <tony.luck@intel.com>
Subject: cg-update doesn't clean away empty directories
Date: Fri, 6 May 2005 09:22:30 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F036A5809@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri May 06 18:17:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5Um-0002ZS-VN
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEFQWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVEFQWf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:22:35 -0400
Received: from fmr13.intel.com ([192.55.52.67]:31370 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261157AbVEFQWd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:22:33 -0400
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.1.192.59])
	by fmsfmr001.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j46GMVZS000402
	for <git@vger.kernel.org>; Fri, 6 May 2005 16:22:31 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j46GMT8w020864
	for <git@vger.kernel.org>; Fri, 6 May 2005 16:22:31 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005050609223126914
 for <git@vger.kernel.org>; Fri, 06 May 2005 09:22:31 -0700
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 6 May 2005 09:22:31 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 6 May 2005 09:22:30 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cg-update doesn't clean away empty directories
Thread-Index: AcVSV80BrMN/qAlAQDm639NmlADTeA==
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 06 May 2005 16:22:30.0957 (UTC) FILETIME=[CD476DD0:01C55257]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just did a cg-update from Linus' tree, and all the files
in Documentation/BK-Usage were neatly thrown away from my
working directory.  But Documentation/BK-Usage itself is
still there.  Looking at the output from git-ls-tree it was
removed from the GIT level.

-Tony
