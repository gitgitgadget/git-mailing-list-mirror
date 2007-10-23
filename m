From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 21:21:40 -0400
Message-ID: <20071023012140.GC22997@thunk.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 03:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik8TA-0004Y5-IZ
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 03:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXJWBV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 21:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbXJWBV4
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 21:21:56 -0400
Received: from THUNK.ORG ([69.25.196.29]:55847 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbXJWBVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 21:21:55 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ik8cq-0000dV-Bp; Mon, 22 Oct 2007 21:32:08 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Ik8Si-00070o-IX; Mon, 22 Oct 2007 21:21:40 -0400
Content-Disposition: inline
In-Reply-To: <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62066>

On Mon, Oct 22, 2007 at 06:15:09PM -0700, Junio C Hamano wrote:
> >
> > I've recently started trying to use some of the scripts in "todo" to
> > send similar "What's cooking" messages, and started wondering if they
> > were what Junio actually used in production to send his notes.  For
> > example, the scripts don't work particularly well if the refs have
> > been packed.  So I had to make changes such as these so they would
> > work for me.
> 
> Sorry, WI is for "what's in", WC is for "what's cooking".  I
> should remove PU and RB from there.
> 

I assume PU is what you used to build your proposed-update branch?
I'm actually trying to use it, and it is useful, although it hasn't
been working for me completely perfectly.  I've still been trying to
figure out if the reason why it hasn't been working quite right is due
to my not understanding how to use it correctly, or whether you don't
use it these days.

One question which I have had about the WC script is that if I
manually add a commit to the next branch, it ends up showing up in all
of the topic branches as a commit that was part of that topic branch
which is in next.  So I can manually edit the output of WC to remove
the spurious commit, or I could make it be a rule that all new commits
either must go against the master branch, or be put in a topic branch
based off of master, and then merged into next.  Or maybe I'm not
understanding how to make the WC and git-topic.perl script work and
sing for me perfectly?

					- Ted
