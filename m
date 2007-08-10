From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 11:16:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708101113380.21857@racer.site>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de>
 <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org>
 <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 12:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJRYy-0007Z3-DU
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 12:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765869AbXHJKRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 06:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765064AbXHJKRG
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 06:17:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:51114 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764808AbXHJKRA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 06:17:00 -0400
Received: (qmail invoked by alias); 10 Aug 2007 10:16:58 -0000
Received: from ppp-82-135-7-57.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.7.57]
  by mail.gmx.net (mp011) with SMTP; 10 Aug 2007 12:16:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zRTQEQQkzwTBiXvRFZ3Ia/UJ+bPdzTV9VdHi4b7
	a+O5pl541BtaHe
X-X-Sender: gene099@racer.site
In-Reply-To: <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55525>

Hi,

On Fri, 10 Aug 2007, Steffen Prohaska wrote:

> I recognized that '.' is included in the PATH in /etc/profile.
> I don't think this is a good idea. At least it bit me once when
> I expected to run /bin/git but instead /git/./git was chosen.
> Shouldn't we remove '.' from the PATH?

In my experience, Windows users (not Mac users forced to use Windows) 
_expect_ "." to be in the PATH.

Regarding the tclsh thing:  IMHO to unwaste space, we should add a

	#!/bin/sh
	exec tclsh84 "$@"

instead.  MinGW does not have symlinks, and we should not put more space 
to waste than Windows does already, by copying files around (yes, the 
repository will not care, but the working tree will).

Ciao,
Dscho
