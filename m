From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: resurrect "gc --auto" at the end
Date: Wed, 14 May 2008 19:40:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141939470.30431@racer>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org> <7vr6drsl47.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0804021538220.4008@racer.site>
 <alpine.DEB.1.00.0805141607210.30431@racer> <7vlk2coist.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:41:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLuK-00039Z-4C
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405AbYENSkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbYENSkD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:40:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:39435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754851AbYENSkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:40:01 -0400
Received: (qmail invoked by alias); 14 May 2008 18:40:00 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp033) with SMTP; 14 May 2008 20:40:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GnAZ634FG0BxRjpsN6pYD+2ThIR+mtn9JZD9Ie/
	diN4sW86KmxMrF
X-X-Sender: gene099@racer
In-Reply-To: <7vlk2coist.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82130>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 2 Apr 2008, Johannes Schindelin wrote:
> >
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> 
> >> As the scripted version of git-commit did, we now call gc --auto just 
> >> before the post-commit hook.
> >> 
> >> Any errors of gc --auto should be non-fatal, so we do not catch those; the 
> >> user should see them anyway.
> >> 
> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> ---
> >> 
> >> 	Junio wrote:
> >> 	>
> >> 	>  * "git commit" used to have one [call to 'gc --auto'] at the 
> >> 	>    end in the scripted version, but seems to have lost it in C
> >> 	>    rewrite.
> >> 
> >> 	How about this?
> >
> > Any news on this?
> 
> I had an impression that we accepted the hook which made "gc --auto" 
> more expensive by forcing it to check the hook (and possibly execute it 
> every time) after vetting am, svn and friends to make sure nobody 
> triggered "gc --auto" once per every commit, and during that vetting 
> process we noticed that "git commit" lost the "gc --auto" at the end.

Ah yes, completely forgot.  Thanks.

Ciao,
Dscho
