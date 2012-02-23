From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: git gui:  how to fetch a single branch
Date: Thu, 23 Feb 2012 15:58:15 -0800
Message-ID: <70952A932255A2489522275A628B97C31294E91C@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 01:08:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ihd-0004nX-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 01:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab2BXAHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 19:07:52 -0500
Received: from mtv-iport-2.cisco.com ([173.36.130.13]:31019 "EHLO
	mtv-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528Ab2BXAHu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 19:07:50 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2012 19:07:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=270; q=dns/txt;
  s=iport; t=1330042070; x=1331251670;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:from:to;
  bh=0t6/ATglnLgpRzpsl0SIdPQYuEIuh6XfgT9hEys5m2Q=;
  b=dn31PgF3jQB1E3TkSk20xeWTCjHic3lJNA4ss1exn04Vu4F4cno42sMZ
   Cpx4S49eEhC5lWYrYUzrDFcKj+8IHqm3CySpKjRfvjfKnlASX2Cl8V96j
   ue6h8kwLsPmRTitoJhwj6BGwttCQqLObY3ljd9oJMf2fZCUKF9l5u2Dn8
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EACbSRk+rRDoH/2dsb2JhbABDslSBB4F1AQQSARQJClEBKgYYB1cBBBsapluBJwGWdYx6FRdHEQIBAgECAoRMAWAJBwEPUYI7YwSIT593
X-IronPort-AV: E=Sophos;i="4.73,473,1325462400"; 
   d="scan'208";a="32116262"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by mtv-iport-2.cisco.com with ESMTP; 23 Feb 2012 23:58:23 +0000
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com [128.107.191.100])
	by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id q1NNwNjC007843
	for <git@vger.kernel.org>; Thu, 23 Feb 2012 23:58:23 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-231.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 23 Feb 2012 15:58:23 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-CR-Puzzleid: {0044FE6E-F234-458E-BF5D-BC9B0983B7B9}
X-CR-Hashedpuzzle: AmB0 BUKp CU1w DJVe D+Di ELMG FGF0 FLXH FvDw GMea G82o HGJm H5Yb IVmX IWwU Ixe5;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{0044FE6E-F234-458E-BF5D-BC9B0983B7B9};bQBhAHQAcwBlAGkAdAB6AEAAYwBpAHMAYwBvAC4AYwBvAG0A;Thu, 23 Feb 2012 23:58:15 GMT;ZwBpAHQAIABnAHUAaQA6ACAAIABoAG8AdwAgAHQAbwAgAGYAZQB0AGMAaAAgAGEAIABzAGkAbgBnAGwAZQAgAGIAcgBhAG4AYwBoAA==
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git gui:  how to fetch a single branch
thread-index: AczyhwHvGKQSV9cmQIqlxLbePuMzgQ==
X-OriginalArrivalTime: 23 Feb 2012 23:58:24.0102 (UTC) FILETIME=[07212060:01CCF287]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191407>

How can I use "git gui" to fetch a single branch from a remote
repository?

If I select Remote->Fetch From, and then a remote repository, it appears
to always fetch all the branches from the remote repository with no
option to select which branch I want to fetch.
