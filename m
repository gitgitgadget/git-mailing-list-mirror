From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 22:34:26 -0400
Message-ID: <20071019023426.GA14735@spearce.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <47181430.2080907@vilain.net> <ee77f5c20710181924j7c538468r75f0f17968af7b01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:34:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihhN-00020j-5M
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763779AbXJSCeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763754AbXJSCeh
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:34:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43517 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763538AbXJSCeg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:34:36 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iihgi-00008z-WA; Thu, 18 Oct 2007 22:34:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C83C920FBAE; Thu, 18 Oct 2007 22:34:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <ee77f5c20710181924j7c538468r75f0f17968af7b01@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61611>

David Symonds <dsymonds@gmail.com> wrote:
> On 19/10/2007, Sam Vilain <sam@vilain.net> wrote:
> > Jeff King wrote:
> > > Boo. I _like_ "deltifying". Sure, it's probably not in the dictionary,
> > > but that's how languages change: saying "delta compressing" all the time
> > > will get awkward, so people invent a new word using existing rules to
> > > explain a common phenomenon.
> >
> > This is not very considerate to non-native speakers, though, who might
> > not grasp the neogolism.
> >
> > Perhaps just "compressing" if it gets awkward.
> 
> Forward thinking, that's probably most sensible, since git 4.7 might
> not use delta compression, but maybe wavelet compression, or other
> scheme entirely. Using deltas is an implementation detail, after all.

Heh.  I just remembered that my packv4 topic had a phase it called
"Dictifying objects".  Which ran before "Deltifying objects".  It was
just another form of compression, but it was also timeconsuming
and an entirely different loop so it got its own progress meter.

I'm leaning to making it just say "Compressing objects".  Simple,
to the point, reasonably describes the action, and most people will
understand what it means: "Oh, time to go get coffee if that number
there is reeeealy big..."  :-)

-- 
Shawn.
