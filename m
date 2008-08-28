From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 12:47:56 +0200
Message-ID: <20080828104756.GR10360@machine.or.cz>
References: <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu> <20080827195019.GA9962@sigill.intra.peff.net> <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 12:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYf3n-0000pG-H4
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 12:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbYH1Kr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 06:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbYH1Kr7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 06:47:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40257 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbYH1Kr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 06:47:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6CACD3939B52; Thu, 28 Aug 2008 12:47:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm removing users@kernel.org from the Cc list since this is far beyond
relevant there.

On Thu, Aug 28, 2008 at 03:33:46AM -0700, Perry Wagle wrote:
> The PATH thing fixes the problem of typing in git-commands at the command 
> line, but not for scripts containing git<DASH> commands.  I've seen no-one 
> rebut my rebuttal.

Huh? $PATH takes effect both on command-line and in scripts. Maybe you
wanted to phrase this paragraph differently.

> Are you suggesting that I break into machines that I don't have access to 
> add a export PATH= line to copies of scripts that were written 6 months 
> ago, and worked just fine until someone decided that "upward compatibility" 
> wasn't an important concept?

No, they worked just fine until someone upgraded Git there. That
$someone needs to take care of this.

> What other upward compatibilities were broken in the past six months?  What 
> am I testing for tomorrow when I fix it before releasing an upgraded git?  
> Next month?
>
> I really don't understand this "upward compatibility doesn't matter" thing.

The deprecation has been announced several times. Yes, we might've done
better job spreading the word and the documentation still needs updates;
from that it's apparent we're lacking at resources here and help is
welcome. Ask your money back or send patches.

> In this thread the new completion thing has been clearly stated both ways.
>
> I have one, apparently very authoritative, response in this thread assuring 
> me that it will not be the case that the command completion space will be 
> restricted in the fashion you support.  I'm not sure who to believe.  It 
> might not matter: apparently, one person in the thread was forced to make 
> the change we are all responding to here.  When does that happen again?

What response is that? I can see only Andi Kleen's post, and it didn't
actually even directly claim that this is the current behaviour. Then
there's bunch of posts showing that it's not the case. Well, I can only
shrug my shoulders.

Since after all, you clearly just feel like flaming and don't actually
_care_ about this issue at all since you would just _try_ it out if this
actually mattered to you.

> I find the notion that the command completion should give partial results 
> an unpleasant concept.  I've been stuck with systems with no documentation, 
> but with command completion with that sort of thinking, and as a result, 
> and it was very frustrating.

Git has documentation.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
