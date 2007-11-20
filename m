From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Tue, 20 Nov 2007 07:50:21 +0100
Message-ID: <20071120065021.GA4172@steel.home>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com> <20071118182901.GA5939@steel.home> <20071120041620.GA23566@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 07:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuMwc-0001Bx-3H
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 07:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbXKTGu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 01:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbXKTGu3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 01:50:29 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16345 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbXKTGu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 01:50:28 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAck9IE=
Received: from tigra.home (Fc9e9.f.strato-dslnet.de [195.4.201.233])
	by post.webmailer.de (mrclete mo24) (RZmta 14.3)
	with ESMTP id v04d0cjAJNtjEz ; Tue, 20 Nov 2007 07:50:23 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 46154277AE;
	Tue, 20 Nov 2007 07:50:22 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A87FC56D22; Tue, 20 Nov 2007 07:50:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071120041620.GA23566@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65530>

Jeff King, Tue, Nov 20, 2007 05:16:20 +0100:
> On Sun, Nov 18, 2007 at 07:29:01PM +0100, Alex Riesen wrote:
> 
> > > jonsmirl@terra:~/ds$ git push digispeaker
> > > To ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git
> > >  ! [rejected]        master -> master (non-fast forward)
> > > error: failed to push to
> > 
> > the branch you are pushing does not fast-forward to the one on
> > digispeaker. IOW, the master on digispeaker has changed since you made
> > changes on your local master.
> 
> Alex, are you going to rework your "consolidate nonff errors and print a
> more extended message" patch on top of what's in next (I think it should
> be much simpler now).

Do you mean that "Beautify the output of send-pack a bit", Message-ID:
<20071112221140.GD2918@steel.home>?

If so, I'm confused. Didn't you already do that in your recent
"send-pack:" patch series? It looked to me as if you did (except for
the hint regarding non-ff branches to be updated everything is there).
