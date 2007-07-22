From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix update-po target to call msgmerge with right parameters
Date: Sun, 22 Jul 2007 12:48:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221246040.14781@racer.site>
References: <20070722101930.GC3408@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 13:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICZvo-0007ay-DM
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 13:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbXGVLs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 07:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755608AbXGVLs4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 07:48:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:49956 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755276AbXGVLs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 07:48:56 -0400
Received: (qmail invoked by alias); 22 Jul 2007 11:48:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 22 Jul 2007 13:48:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ndb9avT4NxS92fd1xB/5opsu7TcqrB8Dml/Xv/+
	k7j9L72e42V20Z
X-X-Sender: gene099@racer.site
In-Reply-To: <20070722101930.GC3408@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53251>

Hi,

On Sun, 22 Jul 2007, Alex Riesen wrote:

> Add accidentally forgotten semicolon at the end of msgmerge command line

Good catch!

I did a "make update-po" to test before and after your patch.  There seem 
to be some changes, but the worst part of it: update-po rewrites almost 
the whole file!  The .po files contain the line numbers where the message 
was found, and they often change.

Oh, well.  I'll probably write some alias to see what _actually_ 
changed (probably just ignoring ^#)...

Ciao,
Dscho
