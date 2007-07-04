From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Remove obsolete commit-walkers
Date: Wed, 4 Jul 2007 12:29:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041228290.4071@racer.site>
References: <Pine.LNX.4.64.0707030128110.14638@iabervon.org>
 <7vwsxiroqa.fsf@assigned-by-dhcp.cox.net> <18058.17778.692974.122271@lisa.zopyra.com>
 <7vsl84lpo3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 13:29:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I633A-00064g-2C
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 13:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757988AbXGDL3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 07:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756171AbXGDL3d
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 07:29:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:51984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757988AbXGDL3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 07:29:33 -0400
Received: (qmail invoked by alias); 04 Jul 2007 11:29:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 04 Jul 2007 13:29:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5wANrdr25PMHOp0NHyONQtbgm0Yv7FHbNIkqDny
	M17Bx3/AAAqI4F
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl84lpo3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51596>

Hi,

On Tue, 3 Jul 2007, Junio C Hamano wrote:

> Bill Lear <rael@zopyra.com> writes:
> 
> > On Monday, July 2, 2007 at 23:22:05 (-0700) Junio C Hamano writes:
> >>I'll apply this after 1.5.3.  In the meantime, I'll do this for 1.5.3.
> >>
> >>diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
> >>index 19b5f88..141b767 100644
> >>--- a/Documentation/git-local-fetch.txt
> >>+++ b/Documentation/git-local-fetch.txt
> >>@@ -14,6 +14,8 @@ SYNOPSIS
> >> 
> >> DESCRIPTION
> >> -----------
> >>+THIS COMMAND IS DEPRECATED.
> >>...
> >
> > If a deprecated command has a replacement, the deprecation notice
> > should point the user to that.
> 
> Actually these fetch backend shouldn't even be needed by the end
> users.  "git fetch" simply does not drive them these days.

You forget that this backend is a plumbing component, which might well be 
used by other porcelains. IIRC cogito uses it, optionally.

Ciao,
Dscho
