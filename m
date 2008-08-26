From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 18:38:07 +0100
Message-ID: <80fxorekxs.fsf@tiny.isode.net>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
            <1219664940.9583.42.camel@pmac.infradead.org>
            <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
            <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
            <20080826145719.GB5046@coredump.intra.peff.net>
            <1219764860.4471.13.camel@gaara.bos.redhat.com>
            <1219766398.7107.87.camel@pmac.infradead.org>
            <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
            <80myizelcw.fsf@tiny.isode.net>
            <20080826173512.GS10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Kristian H?gsberg <krh@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Xh-00076l-BT
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759470AbYHZRip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759110AbYHZRio
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:38:44 -0400
Received: from rufus.isode.com ([62.3.217.251]:48537 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759461AbYHZRin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:38:43 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SLQ=fwBnexgS@rufus.isode.com>; Tue, 26 Aug 2008 18:38:07 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 26 Aug 2008 18:38:07 +0100
X-Hashcash: 1:20:080826:pasky@suse.cz::7gSAJPISSEIJbeFE:00002pI9
X-Hashcash: 1:20:080826:torvalds@linux-foundation.org::J0pYXXtYR6dDX2GP:000000000000000000000000000000000cLi
X-Hashcash: 1:20:080826:dwmw2@infradead.org::7mmHF+x5C/lPxlIw:0000000000000000000000000000000000000000002P9F
X-Hashcash: 1:20:080826:krh@redhat.com::ig2BLYyUg/Uaw7Ac:000GlGw
X-Hashcash: 1:20:080826:peff@peff.net::mI1rWuN/iHlAD5xi:00008sFq
X-Hashcash: 1:20:080826:git@vger.kernel.org::RONHkhU17R3UDMDf:0000000000000000000000000000000000000000003KGk
X-Hashcash: 1:20:080826:johannes.schindelin@gmx.de::jyZ3fQ8psV5x8El2:00000000000000000000000000000000000JjZl
X-Hashcash: 1:20:080826:gitster@pobox.com::TGLsT8ec8DuUaCJv:000000000000000000000000000000000000000000002B08
X-Hashcash: 1:20:080826:users@kernel.org::XL8FV5EWiS17Bm8e:00UuB
In-Reply-To: <20080826173512.GS10544@machine.or.cz> (Petr Baudis's message of "Tue\, 26 Aug 2008 19\:35\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93780>

Petr Baudis <pasky@suse.cz> writes:

[...]

> I actually checked, and my msysgit installation does hardlinking (or at
> least pretends to do, and ls -l shows high linkcounts). And somewhat
> amusingly, it doesn't appear that 1.6.0 will be released for Windows
> anytime soon, though that's of course not relevant from long term
> perspective.

IIRC git.exe knows how to run Tcl scripts (maybe perl and
shell-scripts), and on Windows you need to use "git gui" and things
because "git-gui" won't work.
