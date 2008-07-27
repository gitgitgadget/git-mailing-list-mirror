From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 22:44:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807272241220.5526@eeepc-johanness>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness> <7vljzn2o51.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 22:44:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KND64-0003AL-0M
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 22:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739AbYG0UnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 16:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758162AbYG0UnA
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 16:43:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:60407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757739AbYG0Um7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 16:42:59 -0400
Received: (qmail invoked by alias); 27 Jul 2008 20:42:58 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp004) with SMTP; 27 Jul 2008 22:42:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N3ccfWTUNtcR31CEyqxGPJcw5KntNGpDNwQ9KdB
	DWv2fLjC8q9QQT
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vljzn2o51.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90368>

Hi,

On Sun, 27 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > BTW I seem to recall that get_merge_bases_many() was _not_ the same as 
> > get_merge_octopus().  Could you please remind me what _many() does?
> 
> I explained what merge-bases-many gives in a separate message last night 
> with pictures.

I missed that, alright.

> get_merge_octopus() is a more or less useless function.  It is there 
> only because the protocol between "merge" and strategies requires that 
> the former have to pass _some_ bases to the latter.

Does it?  I thought that e.g. merge-recursive accepts an empty set of 
merge bases?  AFAIR that was the reason why gitk could be merged so well.

> In fact, the octopus strategy implementation completely ignores the 
> heads given by "merge"; a single set of merge base given from outside is 
> not even useful when you build octopus by repeatedly running pairwise 
> three-way merges.
> 
> With Christian's git-merge-base enhancement, the big comment at the end 
> of git-merge-octopus's main loop can go with a much improved "next" 
> merge base computation.

Okay.

Ciao,
Dscho
