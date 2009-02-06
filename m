From: Jeff King <peff@peff.net>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Feb 2009 14:25:05 -0500
Message-ID: <20090206192505.GE19494@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de> <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain> <buobptg6tek.fsf@dhlpc061.dev.necel.com> <7vfxis86tp.fsf@gitster.siamese.dyndns.org> <buor62c3yin.fsf@dhlpc061.dev.necel.com> <7vprhw6l1i.fsf@gitster.siamese.dyndns.org> <buoab8z52te.fsf@dhlpc061.dev.necel.com> <7vd4dv7tb3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miles Bader <miles@gnu.org>, gyles19@visi.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVWLY-0008E5-95
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZBFTZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbZBFTZK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:25:10 -0500
Received: from peff.net ([208.65.91.99]:56900 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbZBFTZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:25:08 -0500
Received: (qmail 24278 invoked by uid 107); 6 Feb 2009 19:25:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 14:25:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 14:25:05 -0500
Content-Disposition: inline
In-Reply-To: <7vd4dv7tb3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108776>

On Fri, Feb 06, 2009 at 02:28:48AM -0800, Junio C Hamano wrote:

> > Er ... I was not doing so.  I was saying that if one is going to use
> > autoconf with git, one should use a non-ancient version.
> 
> That is nice but the statement is only half-truth, and should be followed
> by ", but why bother?  You do not even need to use configure to build
> git, and insn is all here...".

I can think of one obvious reason why one might bother with autoconf: he
knows that git builds using the configuration detected by autoconf, but
it does not without. So yes, he _can_ tweak the Makefile manually to get
git to build, but he doesn't necessarily know which knobs to tweak. And
autoconf does.

Now, in this case, it was only one tweak and other responders have
already pointed him in the right direction. So just making that tweak
manually is probably the sane thing to do in this situation.

But I wanted to point out that autoconf is not totally without value
here.  There are people who may want to build git from a clone but who
_don't_ want to spend time learning about every tweakable build knob or
about how much their platform sucks.

-Peff
