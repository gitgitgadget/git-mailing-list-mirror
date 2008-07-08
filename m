From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Tue, 8 Jul 2008 03:47:34 +0200
Message-ID: <20080708014734.GE6726@leksak.fem-net>
References: <200807080227.43515.jnareb@gmail.com> <20080708010050.GD6726@leksak.fem-net> <7vmyktxjlq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG2Jr-0001qd-8X
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbYGHBrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbYGHBrm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:47:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:58396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755042AbYGHBrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:47:41 -0400
Received: (qmail invoked by alias); 08 Jul 2008 01:47:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp034) with SMTP; 08 Jul 2008 03:47:39 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19JfkBDllhJ8rQDFMr5sg8TCQKDcEqQxEuAvdacWu
	x5PU6ov76ikaHU
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KG2Io-0008Po-Lr; Tue, 08 Jul 2008 03:47:34 +0200
Content-Disposition: inline
In-Reply-To: <7vmyktxjlq.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87685>

Hi,

Junio C Hamano <gitster@pobox.com> wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> > (Well, I think the
> >    http://thread.gmane.org/gmane.comp.version-control.git/86985
> > thread died in the last days, but I hope some responses will come and
> > also that Junio's patch for cherry-picking root commits will be
> > included. I try to be patient...) ;-)
> 
> Please don't be patient but actively re-review what you sent out.
> 
> I _really_ wanted to merge the basic bits and rewrite of "am" at least to
> pu tonight, but I had to drop them after noticing that it does not seem to
> handle --rebasing at all (it parses to set $rebasing but after that where
> does that bit go?

Yes, you are right that am --rebasing is a no-op.
That option was a little mystery to me, because it seemed to do nothing
special, but I'll check again (bash-completion etc) and do appropriate
changes.

> About the "rewrite rebase to use sequencer" bits, because we've dropped
> the older rebase-i change, I do not want your series to depend on it.

Yes, I made the mistake that I started developing on "next" and I did
not expect that js/rebase-i-sequencer could be dropped. (I somehow
expected the opposite, that it would be migrated to master some day.)

Then I wanted to make it work on master, and thought this is simply
done by removing the "additional features" (-f and -p option using extended
todo list), but then I noticed that master also has a -p which works
entirely different and I wanted to see that stuff on the list before
July 1st and I had no idea what the status of js/rebase-i-sequencer is.
So I just tried and sent that last patch to the list in that way.

But now I have a clear statement.

So I'm going to send a new patchset (also with an EXAMPLES section in 
the docs) to the list in a few days.

Big thanks for the feedback,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
