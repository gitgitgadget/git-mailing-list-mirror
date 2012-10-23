From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2] git-pull: Avoid merge-base on detached head
Date: Tue, 23 Oct 2012 16:39:55 -0400
Message-ID: <1351024796-28174-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 22:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQlI4-0005dF-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 22:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987Ab2JWUlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 16:41:21 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:52802 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933821Ab2JWUkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 16:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=24; q=dns/txt; s=iport;
  t=1351024814; x=1352234414;
  h=from:to:cc:subject:date:message-id;
  bh=0bDimc4BO2OInrk0p2EFMYugxH3rZ3sV5hLK4mXVZOo=;
  b=km6KzANMRV0AJQOoM28IHGrTfoOgqWq3lPPakbqSkXoJYxqSUMszcy2l
   Gow48FdnEufcNuvl1i0/JX64R4TfiSjq9wTZ/ObK8jdjqjdOqOGVJLt1G
   iounFOwEkcr/Ti85znSAHkaJ+Nq/fkAP6IjQyHeCWw3BQNpo4M5jbC2Xm
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhEFAKf/hlCtJV2a/2dsb2JhbABEjiWzWIEIgjcBBmCBc4dim0CPXJAvjxuDIwOVco5OgWuDCw
X-IronPort-AV: E=Sophos;i="4.80,637,1344211200"; 
   d="scan'208";a="134635012"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-7.cisco.com with ESMTP; 23 Oct 2012 20:40:13 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id q9NKeDVS019733;
	Tue, 23 Oct 2012 20:40:13 GMT
X-Mailer: git-send-email 1.8.0.2.gc921d59.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208245>


Add Signed-off-by...
