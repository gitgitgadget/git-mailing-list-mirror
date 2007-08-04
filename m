From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sat, 4 Aug 2007 16:36:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041636290.14781@racer.site>
References: <20070804070308.GA6493@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:37:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLhV-0004X3-6t
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762025AbXHDPhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 11:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761932AbXHDPhl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:37:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:47237 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761892AbXHDPhk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 11:37:40 -0400
Received: (qmail invoked by alias); 04 Aug 2007 15:37:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 04 Aug 2007 17:37:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tOdldic9tEQKxz14sxxTub/S6Y99JToElhyncbq
	FVOb6pri/Mwk90
X-X-Sender: gene099@racer.site
In-Reply-To: <20070804070308.GA6493@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54867>

Hi,

On Sat, 4 Aug 2007, Jeff King wrote:

> Without this flag, cpio prints the number of blocks copied,
> leading to the somewhat confusing git-clone output:
> 
> $ git-clone foo bar
> Initialized empty Git repository in ...
> 0 blocks

According to http://www.opengroup.org/onlinepubs/7990989775/xcu/cpio.html, 
cpio does not know about --quiet.  I think this is another GNUism...

Ciao,
Dscho
