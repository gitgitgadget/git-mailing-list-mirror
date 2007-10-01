From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by builtin-commit.c.
Date: Mon, 1 Oct 2007 11:14:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011114310.28395@racer.site>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
 <20070930131133.GA11209@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Oct 01 12:16:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcIJx-0000PG-K9
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 12:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXJAKQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 06:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXJAKQE
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 06:16:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:50694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751120AbXJAKQD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 06:16:03 -0400
Received: (qmail invoked by alias); 01 Oct 2007 10:15:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 01 Oct 2007 12:15:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4ijxAivH4Aj9J5gVy0FveaW3Nl5EydPz/YlTkXR
	VkWy/rTERbeKCK
X-X-Sender: gene099@racer.site
In-Reply-To: <20070930131133.GA11209@diku.dk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59593>

Hi,

On Sun, 30 Sep 2007, Jonas Fonseca wrote:

> Also, I think for this to be more usable for other built-in programs it 
> shouldn't modify argv, but instead take both argc and argv (so we don't 
> need to have code like "*++(*argv)" ;), parse _all_ options in one go, 
> and return the index (of argv) for any remaining options.

We _have_ to modify argv.  For example, "git log master -p" is perfectly 
valid.

Ciao,
Dscho
