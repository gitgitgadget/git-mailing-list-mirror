From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Mon, 2 Jun 2008 23:15:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806022313270.13507@racer.site.net>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 00:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ILk-0004ba-6x
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 00:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbYFBWRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 18:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbYFBWRB
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:17:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:57647 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752138AbYFBWRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 18:17:00 -0400
Received: (qmail invoked by alias); 02 Jun 2008 22:16:57 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 03 Jun 2008 00:16:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18awzE4zKca2/WKQnFu7iA9K5tNllg6MUYBEzNFmo
	nrkT+FI2mCX+2d
X-X-Sender: gene099@racer.site.net
In-Reply-To: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83583>

Hi,

On Mon, 2 Jun 2008, Marek Zawirski wrote:

> Series start with formatting stuff, as some old files were not 
> appropriatelly formatted.

You mean line-wrapping, right?  Is there a different 
recommended column/line ratio for JGit than for Git?  Because some of your 
later patches introduce lines longer than 80 columns/line.

>   Add getType() method to RevObject hierarchy

Was the idea not to use instanceof to be able to have multiple "types" per 
object?  I.e. a commit object is of type commit, but also of type 
object...

BTW I really like the iterator implementation.

Ciao,
Dscho
