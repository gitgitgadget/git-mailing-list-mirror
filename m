From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2 0/2] Reroll submodule sync --recursive
Date: Fri, 26 Oct 2012 13:31:29 -0400
Message-ID: <1351272691-24718-1-git-send-email-hordp@cisco.com>
References: <5089BBE1.3040107@web.de>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 19:32:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRnlM-000614-RF
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 19:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965490Ab2JZRbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 13:31:53 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:53619 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965459Ab2JZRbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 13:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=102; q=dns/txt; s=iport;
  t=1351272712; x=1352482312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sAM9FTQgY882gONE0ZLwtAVOWW12wm+eVz8BIB0j3x4=;
  b=cXBdmfnwh2bDH+qODAgBz7BWn2PkuTp7VpTf9jOB+5whDrbF7kpLOASn
   55EDxWRu+Hvawh+ePYLNcSHwon3HLAy1q/cRkGSuWjKxUM9MwXR2DOp2k
   Lb+Kks26MfsCMZSjwgr/ODapr/B0mv29uliFBJFrlvSZ9CY+HGcbcdVj6
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAKPHilCtJV2c/2dsb2JhbABEjiu0FIEIgh8BAQQSAWYQUVc7h2ScfqAXjzuDJAOVc45TgWuDCw
X-IronPort-AV: E=Sophos;i="4.80,654,1344211200"; 
   d="scan'208";a="135803074"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-3.cisco.com with ESMTP; 26 Oct 2012 17:31:51 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id q9QHVp48026203;
	Fri, 26 Oct 2012 17:31:51 GMT
X-Mailer: git-send-email 1.8.0.2.g35128e8
In-Reply-To: <5089BBE1.3040107@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208468>


This one fixes "$orig_flags" problems noticed by Jens.
Copy-and-paste is gift from Satan.

Phil
