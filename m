From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 00:41:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6tkdnee.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5za925w.fsf@assigned-by-dhcp.cox.net> <17849.13327.527531.262943@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEEb-00040T-SG
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbXAYXlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbXAYXlp
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:41:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:44620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030501AbXAYXlo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:41:44 -0500
Received: (qmail invoked by alias); 25 Jan 2007 23:41:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 26 Jan 2007 00:41:42 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17849.13327.527531.262943@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37780>

Hi,

On Thu, 25 Jan 2007, Bill Lear wrote:

> On Thursday, January 25, 2007 at 14:23:07 (-0800) Junio C Hamano writes:
> >...
> >Then
> >
> >	Seriously, this option needs to be documented.  Volunteers?
> 
> If you think someone new to git could do this, I would be happy to make 
> this my first contribution to the git community.
> 
> Tell me where to look for the thing to modify, how to modify it, and how 
> to tell you about what I did (etc.), and I'll give it a go.

The --check option is handled in diff.c (you can find out by e.g. "git 
grep -e --check -- \*"). Thus, it should be documented in 
Documentation/diff-options.txt.

The easiest way to find out what it does is to execute:

	git log -S--check diff.c

This will lead you to v1.4.0-rc1~110.

The file format for Documentation/*.txt is easily imitated by looking at 
the context, and maybe eventually "make doc" (you'll need asciidoc for 
that).

Once you made that change, just commit and make a patch with "git 
format-patch HEAD^". Submit. Be famous.

Thank you,
Dscho
