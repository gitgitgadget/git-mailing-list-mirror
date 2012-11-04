From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/4] Simplify and document strbuf_split() functions
Date: Sun,  4 Nov 2012 07:46:50 +0100
Message-ID: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 07:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUtzn-0006Ts-Bc
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 07:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab2KDGrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 01:47:23 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:58382 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914Ab2KDGrW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 01:47:22 -0500
X-AuditID: 12074414-b7f846d0000008b8-b3-50960f792e99
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CB.EA.02232.97F06905; Sun,  4 Nov 2012 01:47:21 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA46lFQo027771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 01:47:19 -0500
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsUixO6iqFvJPy3AYO4kLYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3RvMUroK/
	LBVne74wNjA+Y+5i5OSQEDCRaNtxDMoWk7hwbz1bFyMXh5DAZUaJdSs+MYIkhATOMEk8O1YF
	YrMJ6Eos6mlmArFFBGQlvh/eCFbDLJArsfjdbXYQW1jAWWLGsTtAcQ4OFgFViaZ77iAmr4CL
	xPLDjhCr5CQ+7HnEPoGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2M
	kEAQ2cF45KTcIUYBDkYlHt7fK6YGCLEmlhVX5h5ilORgUhLl/co5LUCILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCO+Wz0DlvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoS
	vLV8QEMFi1LTUyvSMnNKENJMHJwgggtkAw/QBleQQt7igsTc4sx0iKJTjIpS4ryZIAkBkERG
	aR7cAFjMvmIUB/pHmLcFpIoHGO9w3a+ABjMBDd5+aQrI4JJEhJRUA2Pn0S/16c/dFinVb3q1
	+qldjp5U6b7vM712KKZW7ldQ9f6SNH/TRPN7e+NyLDZ3We7/dLNKISjIf3d1VM6UG9cPWZx+
	nt58TVr0t1eXpIinSH3Ii5Iz69mcmKcZmVUtmaXf4mWZtmypov2/UuntdzeufGOhwBMncv33
	mreSR79fKEw/xa6qW6TEUpyRaKjFXFScCABw1lZotAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209012>

The strbuf_split() family of functions was completely undocumented.
Add documentation and also simplify the definition of
strbuf_split_buf().

Michael Haggerty (4):
  strbuf_split_buf(): use ALLOC_GROW()
  strbuf_split_buf(): simplify iteration
  strbuf_split*(): rename "delim" parameter to "terminator"
  strbuf_split*(): document functions

 Documentation/technical/api-strbuf.txt | 16 ++++++++++++
 strbuf.c                               | 39 ++++++++++++---------------
 strbuf.h                               | 48 +++++++++++++++++++++++++++++-----
 3 files changed, 74 insertions(+), 29 deletions(-)

-- 
1.8.0
