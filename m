From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 0/2] Teach --recursive to submodule sync
Date: Fri, 26 Oct 2012 15:44:41 -0400
Message-ID: <1351280683-8402-1-git-send-email-hordp@cisco.com>
References: <508AE3E9.6000304@web.de>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 21:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpq2-0007yj-DW
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966225Ab2JZTou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:44:50 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:5090 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966153Ab2JZTot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=218; q=dns/txt; s=iport;
  t=1351280689; x=1352490289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G+okcWGeeGkQJJu/tT4AV30eCQH/i+Y3WMaNmfm3G68=;
  b=CvAoLVNoyJdQYpdgNywI8r/c7UX2BJ6NbaZ2P7zgGL/zYzPBtkVg7Yhb
   uOR/adthcYGvRCQ7PChTq0pfj+ekRKf43RIgaRz0EVN5T2wJJprQ6NmD2
   gJ7MYliGHGcBMYKKcY2yDQmCUCUa8CO9jqwNX4udONFUZaTfeLxMxQJTL
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFADvnilCtJXG9/2dsb2JhbABEjiu0K4EIgh8BAQQSAWYQUVc7h2ScXaAVjzuDJAOVc45TgWuDCw
X-IronPort-AV: E=Sophos;i="4.80,656,1344211200"; 
   d="scan'208";a="135814505"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rcdn-iport-7.cisco.com with ESMTP; 26 Oct 2012 19:44:49 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-2.cisco.com (8.14.5/8.14.5) with ESMTP id q9QJimEF022008;
	Fri, 26 Oct 2012 19:44:48 GMT
X-Mailer: git-send-email 1.8.0.3.g9dae067
In-Reply-To: <508AE3E9.6000304@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208484>

[PATCHv3 1/2] Teach --recursive to submodule sync

Now with less noise and no redundant flags passed to the recursive call.


[PATCHv3 2/2] Add tests for submodule sync --recursive

The test remains unchanged.
