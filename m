From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 0/4] git-status short sequencer state info
Date: Fri,  9 Nov 2012 13:56:21 -0500
Message-ID: <1352487385-5929-1-git-send-email-hordp@cisco.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 19:56:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtl9-0001hN-DM
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2KIS4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:56:41 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:26070 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2KIS4k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=427; q=dns/txt; s=iport;
  t=1352487400; x=1353697000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IWwu40PseyvbmL87naSYNrSxzCkq5GGWMXDq+H84z2s=;
  b=DnzGGPHjntNKsuUyYIfIQPzjebNMs5adpca0sf4nbpu4Yw7Oj5jAuW3+
   KChkgFA8IS+b1WzmO7BtQCuacDfY8iGxS1xv4lcuLnbVZrQU0mxyJq8UF
   xWi5B0Ye/9wnREocUFdT3v/N7dEmRKCIwlbufUIkLpFUkI+mCIb5V723I
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EADpRnVCtJV2c/2dsb2JhbABEw0OBCIIfAQEEEgFmEFFXO4dongmgFo83gycDiFqNIY5YgWuDDQ
X-IronPort-AV: E=McAfee;i="5400,1158,6891"; a="140711655"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-4.cisco.com with ESMTP; 09 Nov 2012 18:56:40 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id qA9IudCC020062;
	Fri, 9 Nov 2012 18:56:39 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1351553513-20385-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209237>

I think this series is fairly complete at this point. I am still
missing some tests in 4/4, but only because I am not sure how to
induce those conditions.  Maybe I should enlist help from $(git-blame).

 [PATCHv3 1/4] Refactor print_state into get_state
 [PATCHv3 2/4] wt-status: More state retrieval abstraction
 [PATCHv3 3/4] git-status: show short sequencer state
 [PATCHv3 4/4] Add tests for git-status --sequencer
