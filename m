From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] diff: add custom regular expressions for function
 names
Date: Wed, 4 Jul 2007 19:45:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041944520.4071@racer.site>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 20:45:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I69r8-0000wQ-T5
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 20:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbXGDSph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 14:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755723AbXGDSpg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 14:45:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:48007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755488AbXGDSpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 14:45:36 -0400
Received: (qmail invoked by alias); 04 Jul 2007 18:45:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 04 Jul 2007 20:45:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2bhNHhXP27mwYZox/yvJ+w2fOQh2UZ98vQQiJNd
	/ZcUk0CePllVX8
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51633>

Hi,

On Wed, 4 Jul 2007, Linus Torvalds wrote:

> On Wed, 4 Jul 2007, Johannes Schindelin wrote:
> > 
> > This patch introduces a config variable diff.functionNameRegexp
> > which replaces the default heuristics.  If the pattern contains
> > a group, the match of this group is used for the hunk header
> > instead of the whole match.
> 
> Umm. Shouldn't it be a path-name based attribute instead?

>From my original mail:

        Yes, I know. .gitattributes integration would be nice. But for now
        I am done with it. I invested way too much time into this.

Ciao,
Dscho
