From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 22:28:50 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE5C@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 07:23:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRkRk-0005M5-Ou
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 07:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVD3F3C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 01:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVD3F3C
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 01:29:02 -0400
Received: from fmr14.intel.com ([192.55.52.68]:20867 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262511AbVD3F3A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 01:29:00 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.1.192.58])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3U5SvQg024640;
	Sat, 30 Apr 2005 05:28:57 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j3U5ShDI006141;
	Sat, 30 Apr 2005 05:28:57 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005042922285611475
 ; Fri, 29 Apr 2005 22:28:56 -0700
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 29 Apr 2005 22:28:55 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 29 Apr 2005 22:28:55 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Trying to use AUTHOR_DATE
Thread-Index: AcVNQCwd0vl6nquISuWiCzbZf+ScIwABKhPQ
To: "Edgar Toernig" <froese@gmx.de>
X-OriginalArrivalTime: 30 Apr 2005 05:28:55.0275 (UTC) FILETIME=[806EBBB0:01C54D45]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>Fixed version below.

Yup ... that fixes it for my initial test cases.  Thanks.

-Tony

P.S. The libcurl that I found (curl-7.12.1-3.src.rpm) has curl_getdate()
implemented as >1000 lines of yacc.  Which seems like overkill (unless
I really need to set AUTHOR_DATE="a week ago last tuesday" :-)
