From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Test that git add removes stages 1,2,3.
Date: Mon, 2 Jul 2007 12:34:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021232510.4438@racer.site>
References: <11833750863127-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, j.sixt@eudaptics.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 02 13:35:06 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5KBJ-0005vy-N8
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 13:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbXGBLew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 07:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbXGBLev
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 07:34:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:45244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752694AbXGBLev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 07:34:51 -0400
Received: (qmail invoked by alias); 02 Jul 2007 11:34:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 02 Jul 2007 13:34:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YJMcjTOdYUArCkJQj0HaogpbctM9yhC3WDWbN+e
	khnFGHdif8MLfr
X-X-Sender: gene099@racer.site
In-Reply-To: <11833750863127-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51357>

Hi,

On Mon, 2 Jul 2007, Johannes Sixt wrote:

> git add seems to have a bug, where it doesn't remove stages 1,2,3
> if a stage 0 entry is already in the index.

But how does that happen? I do not know any way to use porcelain to 
achieve that bogus state.

AFAIK stages 1,2,3 are only populated when there are conflicts, in which 
case there is no stage 0. Literally the only way I see to have both is to 
_make_ update-index put them in there.

Pilot error?

Ciao,
Dscho
