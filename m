From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix tag following
Date: Wed, 19 Mar 2008 00:28:19 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0803181952230.2071@eeepc-johanness>
References: <alpine.LNX.1.00.0803172211060.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6ah-00087D-4R
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbYCSWPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757432AbYCSWPF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:15:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:42683 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S940028AbYCSWPC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:15:02 -0400
Received: (qmail invoked by alias); 19 Mar 2008 00:28:21 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO eeepc-johanness.home) [86.138.198.40]
  by mail.gmx.net (mp013) with SMTP; 19 Mar 2008 01:28:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/auVNNCOTatbjLSupFjSea4JBpdMdRiFGWLz6GXO
	y8oBneuqw1CFzQ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.LNX.1.00.0803172211060.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77570>

Hi,

On Mon, 17 Mar 2008, Daniel Barkalow wrote:

> Before the second fetch-pack connection in the same process, unmark all 
> of the objects marked in the first connection, in order that we'll list 
> them as things we have instead of thinking we've already mentioned them.

This patch is obviously correct, methinks.

Ciao,
Dscho
