From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 23:05:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101312238170.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
 <20110131231210.GD14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311903320.8580@xanadu.home>
 <20110201014807.GA2722@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 05:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk7Uu-0005Dq-5b
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 05:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab1BAEFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 23:05:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9579 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab1BAEFi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 23:05:38 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFX006MJ7DCBRV0@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 23:05:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110201014807.GA2722@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165791>

On Mon, 31 Jan 2011, Jeff King wrote:

> On Mon, Jan 31, 2011 at 07:29:54PM -0500, Nicolas Pitre wrote:
> 
> > This is no excuse not to do proper source tree reorganization.
> 
> I think this is the crux of our disagreement. I don't agree that your
> proposal is any way more "proper" than what is there now. Leaving the
> rename issue aside (i.e., if we were starting a new project), I would
> still be slightly against a src/ directory. I find them annoying.

Let's agree to disagree then.  What I see in the root of the Git source 
tree is a huge clutter of source files, binary files, scripts, and 
subdirectories all mixed together.  If you know by hart where things are 
because you've been hacking on them for the last 5 years then of course 
you might not see the point.  But since I didn't work much on Git 
lately, things are not as obvious to me as they used to be.  Looking 
back at it now with some distance, this tree looks like a mess and it is 
really annoying to work with.

> But I don't care _that_ much, and I would rather not waste either of our
> time debating it more. I would much rather you spend your time on
> pack v4. :)

I wish... I wish.  But I have a plan which might involve taking some 
vacation from $day_job in the Caribbeans with $wife and no kids, where 
$wife is going to do scuba diving with her club mates while I'll be 
alone with a laptop and no net connection and therefore nothing else to 
do for a week.  I've been craving for such free time for quite a while 
now.


Nicolas
