From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GitTogether topics status (4th of October)
Date: Tue, 7 Oct 2008 07:38:59 -0700
Message-ID: <20081007143859.GJ8203@spearce.org>
References: <200810041816.41026.chriscool@tuxfamily.org> <20081007031509.GA6031@coredump.intra.peff.net> <alpine.LFD.2.00.0810062343000.3045@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Petr Baudis <pasky@suse.cz>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDjQ-0002UV-BM
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbYJGOjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYJGOjB
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:39:01 -0400
Received: from george.spearce.org ([209.20.77.23]:52191 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbYJGOjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:39:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1120638360; Tue,  7 Oct 2008 14:38:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810062343000.3045@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97710>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 6 Oct 2008, Jeff King wrote:
> 
> >   2. What needs refactoring?
> > 
> >      I occasionally run up against parts of the code that just make my
> >      eyes bleed everytime I touch them. I think we've made significant
> >      progress in maintanability and bug-avoidance with things like the
> >      strbuf library, refactoring of remote and transport handling, etc.
> >      What areas might still benefit from such refactoring?
> 
> Tree object walking and commit object parsing. This is what's holding 
> pack v4 performances back. But I think that Shawn will cover this 
> already (I won't be there but I sent my thoughts about this to him).

Yup.  A huge part of the pack v4 talk is going to be the parsing
code.  Maybe 10 minutes of it will give the high level overview
of how pack v4 is organized, to explain why the parsing code is
a problem.  :)

-- 
Shawn.
