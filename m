From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Sat, 28 Jun 2008 15:51:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806281542160.9925@racer>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 16:54:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCbog-0002Lx-Fk
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 16:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbYF1OxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 10:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbYF1OxV
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 10:53:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:49018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753167AbYF1OxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 10:53:20 -0400
Received: (qmail invoked by alias); 28 Jun 2008 14:53:18 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp067) with SMTP; 28 Jun 2008 16:53:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GnBZsVQJGOLKPyjHGGV9KOJoPiRFuaA28DhmGTo
	eJXev4+vDB4taq
X-X-Sender: gene099@racer
In-Reply-To: <1214602538-7888-1-git-send-email-dpotapov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86722>

Hi,

On Sat, 28 Jun 2008, Dmitry Potapov wrote:

> A lot of modules that have nothing to do with git-shell functionality
> were linked in, bloating git-shell more than 8 times.

/me wonders if "strip git-shell" would not take care of all that.

Just curious,
Dscho
