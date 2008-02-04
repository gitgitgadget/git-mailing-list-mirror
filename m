From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH] compat: Add simplified merge sort implementation from
 glibc
Date: Mon, 4 Feb 2008 01:05:52 +0100
Message-ID: <20080204010552.03541642.froese@gmx.de>
References: <20080203011130.GK26392@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLoqw-0001OV-Gk
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbYBDAFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbYBDAFy
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:05:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:33208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753588AbYBDAFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:05:53 -0500
Received: (qmail invoked by alias); 04 Feb 2008 00:05:52 -0000
Received: from p5B010819.dip0.t-ipconnect.de (EHLO dialup) [91.1.8.25]
  by mail.gmx.net (mp010) with SMTP; 04 Feb 2008 01:05:52 +0100
X-Authenticated: #271361
X-Provags-ID: V01U2FsdGVkX1/MYrQYPxTM4r2pZEhoSJJrC2AYGBkc1JwdrakhYg
	XFZb+OxDm1UAD7
In-Reply-To: <20080203011130.GK26392@lavos.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72427>

	if (size < 1024) {
-		char buf[size]; /* gcc-ism */
+		char buf[1024];
