From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 20:01:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 20:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNAYo-0005S9-OX
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 20:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586AbYG0SAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757580AbYG0SAe
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 14:00:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:34907 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757576AbYG0SAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 14:00:34 -0400
Received: (qmail invoked by alias); 27 Jul 2008 18:00:32 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp005) with SMTP; 27 Jul 2008 20:00:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zcm4mnxIzAgokSfiNHPj1KA51AZIziALPWBMbPj
	rk2y+Z/uOuln29
X-X-Sender: user@eeepc-johanness
In-Reply-To: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90350>

Hi,

On Sun, 27 Jul 2008, Jon Smirl wrote:

> I was playing around with git log for the kernel and observed that there 
> is a lot of noise when trying to do statistics on the number of commits.
> 
> For example:
> 
> Author: Greg K-H <gregkh@suse.de>
> Author: Greg KH <gregkh@suse.de>
> Author: Greg KH <greg@kroah.com>
> Author: Greg KH <greg@press.(none)>
> Author: gregkh@suse.de <gregkh@suse.de>
> Author: Greg Kroah-Hartman <gregkh@suse>
> Author: Greg Kroah-Hartman <gregkh@suse.de>
> Author: Greg Kroah-Hartman <greg@kroah.com>
> 
> I don't see an obvious way to do this with git, but it would be neat
> to have a 'clean' option on git log that would take each email address
> (author, signed-off, acked, etc) and map it through a table which
> would convert old email addresses in to the current one and also
> standardize the formatting of the names.

Something like .mailmap?

And to show the mapped author name instead of the committed one, you would 
use "--pretty=format:%aN"?  (Needs 1.6.0-rc0 at least, IIRC)

Ciao,
Dscho
