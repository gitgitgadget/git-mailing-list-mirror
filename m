From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Define compat version of mkdtemp for systems lacking it
Date: Sun, 21 Oct 2007 23:03:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710212303200.25221@racer.site>
References: <20071021053015.GA31995@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjiuE-000399-L6
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 00:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbXJUWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 18:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXJUWEK
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 18:04:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:55952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750866AbXJUWEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 18:04:09 -0400
Received: (qmail invoked by alias); 21 Oct 2007 22:04:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 22 Oct 2007 00:04:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UKZZI4t8U3acSwuHc9A9vB699UIOluaa1KDcKj4
	Ph7qASE2XyJKnI
X-X-Sender: gene099@racer.site
In-Reply-To: <20071021053015.GA31995@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61915>

Hi,

On Sun, 21 Oct 2007, Shawn O. Pearce wrote:

> Solaris 9 doesn't have mkdtemp() so we need to emulate it for the
> rsync transport implementation.

Thanks.  I've been meaning to do it for msysGit, but I never came around 
to do it...

Ciao,
Dscho
