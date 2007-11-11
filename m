From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/6] Various (replacement) patches to builtin-commit
Date: Sun, 11 Nov 2007 17:35:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111730580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGic-0005m2-18
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbXKKRfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbXKKRfR
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:35:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:42822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754260AbXKKRfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:35:16 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:35:14 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 11 Nov 2007 18:35:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kLwlq2bokg9S1yceyzJdkbGsI6K7uUNOfoGslIr
	FgtvVBQWU0WtHd
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64478>

Hi,

I did some more work on top of kh/commit (rebased to next, + Kristian's 
refresh_cache() patch which is still waiting to be enhanced with 
refresh_cache()-after-commit-with-paths).

They are in chronological order.  In particular, all patches except 2/6 
resurrect old behaviour.

Ciao,
Dscho
