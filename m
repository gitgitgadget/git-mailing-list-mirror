From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: Date handling.
Date: Thu, 14 Apr 2005 12:42:28 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03457AE6@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:41:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMABN-0001Xo-4o
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVDNTmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVDNTmn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:42:43 -0400
Received: from fmr16.intel.com ([192.55.52.70]:58508 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261605AbVDNTml convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 15:42:41 -0400
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.1.192.59])
	by fmsfmr006.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3EJgURG016499;
	Thu, 14 Apr 2005 19:42:30 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j3EJgIDA032441;
	Thu, 14 Apr 2005 19:42:30 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005041412423000960
 ; Thu, 14 Apr 2005 12:42:30 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 14 Apr 2005 12:42:30 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 14 Apr 2005 12:42:29 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Date handling.
Thread-Index: AcVBJ2rx/E0oXXBXQ2KHSt7kMSMeNQAAdLFw
To: "David Woodhouse" <dwmw2@infradead.org>
X-OriginalArrivalTime: 14 Apr 2005 19:42:29.0636 (UTC) FILETIME=[17F60C40:01C5412A]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>I'd prefer not to lose the information. If someone has committed a
>change at 2am, I like to know that it was 2am for _them_. It helps me
>decide where to look first for the cause of problems. :)

I'd think the 8:00am-before-the-first-coffee checkins would be the
most worrying :-)

>It also helps disambiguate certain comments, especially those involving
>words or phrases such as "yesterday" or "this afternoon".

This is a very good point ... but this still has problems with the
"git is a filesystem, not a SCM" mantra.  Timezone comments don't
belong in the git inode.

-Tony
