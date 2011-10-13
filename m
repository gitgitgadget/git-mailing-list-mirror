From: Phil Hord <hordp@cisco.com>
Subject: [PATCH 0/1] transport: Use is_bundle instead of !is_gitfile
Date: Thu, 13 Oct 2011 16:26:01 -0400
Message-ID: <1318537562-18581-1-git-send-email-hordp@cisco.com>
Cc: Phil Hord <hordp@cisco.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 22:26:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RERrO-00083o-8a
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 22:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab1JMU03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 16:26:29 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:29358 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1JMU01 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 16:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=492; q=dns/txt;
  s=iport; t=1318537587; x=1319747187;
  h=from:to:cc:subject:date:message-id;
  bh=SwEvMcxporoaeffPdAkzBtQ/LFi8cYWbHSKXe+VsogQ=;
  b=jPeNbjyXqpw/JA5a+gnt0FP6fXV41o0Vb58qV9hFAr4e867k8Q7sBVcv
   1TENYlPF5Zj/36WdZaRJq1VftFfzNnyh+SV5bgSrZ4m3l/Xf8JE2LhFEE
   Z9lszibpNV2jyCzLlFT4Ny39DRl0u5MZlVfABUl2KBDJBMZx+7f8nRaRU
   I=;
X-IronPort-AV: E=Sophos;i="4.69,342,1315180800"; 
   d="scan'208";a="28287754"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-5.cisco.com with ESMTP; 13 Oct 2011 20:26:27 +0000
Received: from hordp-wxp.cisco.com (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p9DKQSVp028401;
	Thu, 13 Oct 2011 20:26:28 GMT
X-Mailer: git-send-email 1.7.7.334.g311c9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183522>

I'm not sure where this patch should go now since I see my
original patchset on both next and pu.  Should I re-roll the
original series with this one merged in, or just submit this
one isolated, as I am doing here?

Pardon my newbieness.

Phil Hord (1):
  transport: Add is_bundle() to detect bundle urls

 bundle.c    |   16 ++++++++++++++++
 bundle.h    |    1 +
 transport.c |   10 +---------
 3 files changed, 18 insertions(+), 9 deletions(-)

-- 
1.7.7.334.g311c9.dirty
