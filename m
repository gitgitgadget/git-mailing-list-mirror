From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] rebase -i --root cleanups
Date: Mon, 26 Jan 2009 00:31:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260029480.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRESt-0001Wt-R9
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbZAYXbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbZAYXbG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:31:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:35377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750909AbZAYXbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:31:06 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:31:03 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp065) with SMTP; 26 Jan 2009 00:31:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JIjQswqAJGjiMGze2u627jG4m6lO5IV50XPcXe9
	tCr430Wske+FAo
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107130>


This is just the first part of my rebase revamp; it would be good to
get the trivial stuff out of the way early, so that I do not have to
send a large patch series nobody wants to read because of its size.

Thomas, these two patches happen to touch your --root realm, maybe you 
have comments.

Johannes Schindelin (2):
  rebase -i --root: simplify code
  rebase -i --root: fix check for number of arguments

 git-rebase--interactive.sh |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)
