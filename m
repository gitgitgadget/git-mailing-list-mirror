From: Nicolas Pitre <nico@cam.org>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 15:34:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908171513230.6044@xanadu.home>
References: <20090817185448.30254.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: art.08.09@gmail.com, bdonlan@gmail.com, git@vger.kernel.org,
	johnflux@gmail.com, P@draigBrady.com, torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7yT-0005SX-Vd
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZHQTe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZHQTe3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:34:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31900 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbZHQTe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:34:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOJ00LAZD0Z66C0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Aug 2009 15:34:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090817185448.30254.qmail@science.horizon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126259>

On Mon, 17 Aug 2009, George Spelvin wrote:

> > I don't think this trick of making source code textually different from 
> > another work while still intimately mimicking the same structure entitles 
> > you to any copyright (or non copyright) claims over that other work.  I 
> > certainly wouldn't bet any dime for this standing up in court.  
> 
> <div type="legal digression">
> Actually, I would.  I did a lot more than text search and replace;
> I re-implemented it from FIPS 180-2 (work of U.S. government, no copyright)
> and then merged in the *ideas* from the mailing list.  
> 
> (And from elsewhere; the idea of a five-round macro is from Brian Gladman.)
> 
> Remember, to the extent that something is *functional*, it is not
> copyrightable; copyright only covers the non-functional expressive bits.
> The vast majority of that code is simply required by the standard,
> or the desired calling interface.
> 
> For a large portion of the rest, remember that standard programming
> conventions (e.g.  brace style, macro names IN CAPS, etc.) that's also
> non-copyrightable "scene a faire" material.
> 
> It's well established that paraphrasing a recipe avoids copyright;
> the proportions and treatment of the ingredients is not copyrightable.
> 
> For more details, see the extensive coverage of the NEC v. Intel decision
> (1989) regarding the firmware for NEC's 8086-clone V20 microprocessor.
> It was found non-infringing despite non-clean-room implementation and
> substantial similarities.
> </div>

Whatever.  NEC and Intel were certainly commercial competitors.  They 
were far from being friends.  So if you feel like having too many 
friends then just go ahead with that stance.

> As for politeness, that's exactly why I did post it and solicit
> objections.

You said:

|It uses Linus's and Artur's performance ideas, and some of Linus' macro 
|ideas (in the rotate implementation), but tries to be textually 
|different. Is there anything recognizable that anyone cares to clam 
|copyright to?

the "try to be textually different" in order to ask for "anything 
recognizable that anyone cares to clam copyright to" is what I find 
dubious.

> The purpose of the rewrite is to avoid having to make
> pessimistic assumptions about people who don't respond.
> 
> I suppose I should have made that request clearer:
> Is there anyone who claims copyright on anything here?
> Or would just like credit?
> If so, are you willing to donate it to the public domain?

I think this is much nicer to everyone involved.

As far as I'm concerned, I'm OK with giving any small copyright I might 
have in this SHA1 implementation, if any, to the public domain.  
Credits are always nice.


Nicolas
