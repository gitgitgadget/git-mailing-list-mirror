From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git sequencer prototype
Date: Thu, 31 Jul 2008 14:40:00 +0200
Message-ID: <20080731124000.GA18106@leksak.fem-net>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261617010.26810@eeepc-johanness> <20080730121458.GB8767@leksak.fem-net> <alpine.LSU.1.00.0807301607070.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 14:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXTb-000173-QS
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 14:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYGaMkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbYGaMkH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 08:40:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:50125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754305AbYGaMkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 08:40:03 -0400
Received: (qmail invoked by alias); 31 Jul 2008 12:40:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp047) with SMTP; 31 Jul 2008 14:40:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/S1cM/tK/SrY/afiOO4ly4ghEQxhE7QsyHWVkYif
	OyB18VOPHc2EEP
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KOXRo-0004iL-HM; Thu, 31 Jul 2008 14:40:00 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0807301607070.3486@wbgn129.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90936>

Johannes Schindelin wrote:
> On Wed, 30 Jul 2008, Stephan Beyer wrote:
> > Johannes Schindelin wrote:
> > >
> > > > In the last patchset I mentioned the issue, that the prototype is 
> > > > slow as hell.  I know some bottlenecks, but I have not even tried to 
> > > > change that, because this is no issue for the builtin.
> > > 
> > > Why is it no issue for the builtin?  Is it so much different from the 
> > > prototype?
> > 
> > As Sverre pointed out and as my "experiments" tried to show: the builtin
> > is just fast ;-)
> 
> So why is it just so fast?  Does it do things completely different than 
> the shell prototype you presented?

Ah, that's the point of your question ;)

No, it's different in some minor parts, of course, but the important thing
is: it is C, not sh.  That's what makes it faster.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
