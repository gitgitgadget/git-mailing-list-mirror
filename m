From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary mode.
Date: Tue, 11 Dec 2007 10:34:01 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111032530.555@xanadu.home>
References: <20071207093439.GA21896@elte.hu>
 <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu>
 <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201>
 <20071211115914.GJ30948@artemis.madism.org>
 <20071211122539.GA13945@sigill.intra.peff.net>
 <20071211140508.GA12204@elte.hu> <20071211144351.GA15448@artemis.madism.org>
 <20071211145709.GB19427@elte.hu> <20071211152412.GB15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_InAbLwTnUiExWTTjUG+NZw)"
Cc: Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J277y-0004JW-SR
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbXLKPeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbXLKPeK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:34:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54238 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbXLKPeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:34:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW005NH5WPVI10@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 10:34:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071211152412.GB15448@artemis.madism.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67873>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_InAbLwTnUiExWTTjUG+NZw)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Tue, 11 Dec 2007, Pierre Habouzit wrote:

> On Tue, Dec 11, 2007 at 02:57:09PM +0000, Ingo Molnar wrote:
> > 
> > * Pierre Habouzit <madcoder@debian.org> wrote:
> > 
> > >     Agreed, here is the patch that does that, and a sample output is:
> > > 
> > >         $ git shortlog -n -s -e HEAD -- builtin-commit.c
> > >             11	Junio C Hamano <gitster@pobox.com>
> > >              6	Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > >              6	Kristian Høgsberg <krh@redhat.com>
> > >              2	Jeff King <peff@peff.net>
> > >              1	Alex Riesen <raa.lkml@gmail.com>
> > >              1	Pierre Habouzit <madcoder@debian.org>
> > >              1	Shawn Bohrer <shawn.bohrer@gmail.com>
> > >              1	Wincent Colaiuta <win@wincent.com>
> > 
> > great - this looks really neat!
> > 
> > btw., stupid question: why are the git-shortlog command line arguments 
> > different from git-log? I got used to things like:
> > 
> >   git-log kernel/
> > 
> > so for me it would be natural to just do:
> > 
> >   git-shortlog -n -s kernel/
> > 
> > but this currently produces this output:
> > 
> >   $ git-shortlog -n -s kernel/
> >   (reading log to summarize from standard input)
> > 
> > which is quite a bit confusing to someone who'd like to keep as few 
> > details of command line arguments in his head as possible :-)
> 
> Because git-shortlog insists on you passing a reference first, HEAD is
> not implicit if you pass something that looks like a path first. This is
> arguably wrong. What you meant here is:
> 
> $ git-shortlog -n -s HEAD kernel/
> 
> The reason IIRC is that git-shortlog once only read things on stdin, and
> this keeps backward compatbility to `git-shortlog` without any
> arguments.
> 
> Sometimes history hurts :) I don't think there is much we can do on a
> short timescale. Maybe the old way can be slowly deprecated, and then
> git-shortlog will be able to act like git-log.

At least, HEAD could be assumed by default when stdin is a tty.


Nicolas

--Boundary_(ID_InAbLwTnUiExWTTjUG+NZw)--
