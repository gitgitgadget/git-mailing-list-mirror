From: Phil Hord <hordp@cisco.com>
Subject: git submodule sync --recursive
Date: Tue, 23 Oct 2012 19:15:39 -0400
Message-ID: <1351034141-2641-1-git-send-email-hordp@cisco.com>
References: <507EF86C.4050807@web.de>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 01:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQnia-00035x-JU
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 01:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218Ab2JWXQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 19:16:06 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:58085 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934132Ab2JWXPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 19:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=170; q=dns/txt; s=iport;
  t=1351034152; x=1352243752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IwAFa9fZpAUsKhCVM+MpddKhgCV3XPb+eV3iuPFaiEo=;
  b=mm7locXfoBsMPcTuLKevSv49umcI6rBWSrwwbXYO6fsAG5NO4A4VUM5Q
   de8zR8VHplYEifUQ/AAZ5K0ROHCY/3kIMbbTCIqoUzxeOWokoEPn++vd3
   SEH22JcZOvM6BwFJZyVmIbOkyS9V4qFGs/uE5j5RcuIkHV8m0p1+QouQq
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhIFAAgkh1CtJXG9/2dsb2JhbABEjiWzWoEIgh8BAQQSAWYQUVc7h2KbHY9ckCWPG4MjA5Vyjk6Ba4ML
X-IronPort-AV: E=Sophos;i="4.80,637,1344211200"; 
   d="scan'208";a="134683503"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rcdn-iport-6.cisco.com with ESMTP; 23 Oct 2012 23:15:51 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-2.cisco.com (8.14.5/8.14.5) with ESMTP id q9NNFp9H006158;
	Tue, 23 Oct 2012 23:15:51 GMT
X-Mailer: git-send-email 1.8.0.2.gcde19fc.dirty
In-Reply-To: <507EF86C.4050807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208275>

[PATCH 1/2] Teach --recursive to submodule sync
[PATCH 2/2] Add tests for submodule sync --recursive

This series implements and tests git submodule sync --recursive
