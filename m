From: "Brown, Len" <len.brown@intel.com>
Subject: RE: fatal: git-write-tree: not able to write tree
Date: Fri, 28 Apr 2006 04:43:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB64A432C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 28 10:43:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZOZS-00070S-Ar
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 10:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWD1InX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 04:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWD1InX
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 04:43:23 -0400
Received: from mga03.intel.com ([143.182.124.21]:23726 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030322AbWD1InW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 04:43:22 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101-1.ch.intel.com with ESMTP; 28 Apr 2006 01:43:21 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by azsmga001.ch.intel.com with ESMTP; 28 Apr 2006 01:43:21 -0700
X-IronPort-AV: i="4.04,163,1144047600"; 
   d="scan'208"; a="28972848:sNHT26763870"
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 01:43:03 -0700
Received: from hdsmsx402.amr.corp.intel.com ([10.127.2.62]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 01:43:02 -0700
Received: from hdsmsx411.amr.corp.intel.com ([10.127.2.70]) by hdsmsx402.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 28 Apr 2006 04:43:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fatal: git-write-tree: not able to write tree
Thread-Index: AcZqnl0BSU4fkcn9TY2MbzqY+AcAAwAAKLiA
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 28 Apr 2006 08:43:01.0604 (UTC) FILETIME=[C222C240:01C66A9F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19271>

 
>> git am --3way --interactive --signoff --utf8 --resolved

>Please say "--resolved" after you have actually resolved them,
>eh, meaning, (1) edit the working tree file into a desired
>shape, and (2) git-update-index drivers/acpi/thermal.c.

Thanks Junio, once again, for your help, we're up and running!

I'm okay with git being conservative and not doing the update-index
for me.  Perhaps the thing to do here is to make the failure message
more useful?

"fatal: git-write-tree: not able to write tree"

everything after "fatal" here is effectively a string
of random characters to the hapless user.

thanks,
-Len
