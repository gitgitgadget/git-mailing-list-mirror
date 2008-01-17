From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Thu, 17 Jan 2008 09:49:14 -0500
Message-ID: <20080117144914.GA2816@coredump.intra.peff.net>
References: <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org> <alpine.LNX.1.00.0801152256480.13593@iabervon.org> <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org> <7v1w8hploy.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801161524390.13593@iabervon.org> <7vprw1mfpr.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170108440.17650@racer.site> <7vabn5mdz7.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170147350.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 15:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFW3v-00050l-Ci
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 15:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYAQOtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 09:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYAQOtS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 09:49:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1310 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbYAQOtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 09:49:17 -0500
Received: (qmail 3726 invoked by uid 111); 17 Jan 2008 14:49:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 17 Jan 2008 09:49:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2008 09:49:14 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801170147350.17650@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70863>

On Thu, Jan 17, 2008 at 01:48:54AM +0000, Johannes Schindelin wrote:

> > While we are discussing about diff, there is one thing that has been 
> > bugging me occasionally, but the annoyance factor has not motivated me 
> > enough to look into it myself, because I do not use it often: 
> > --color-words.  It appears that it shows lines that do not have any word 
> > differences in bold (whatever diff.color.meta is configured) and I think 
> > it should use plain color instead.
> > 
> > Was this intentional, or just a simple plain bug?
> 
> Plain bug.  I even meant to implement your suggestion of having a variable 
> set of non-word characters, but never came around to work on it.  

Hmm. I happen to set my "meta" color to something a little less
attention-grabbing (magenta), and I find the alternate coloring to be a
nice visual indicator of "nothing happened on this line". I can see how
bold would be very distracting, though. Perhaps there should be a
color.diff.unimportant?

-Peff
