From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Wed, 25 Jun 2008 17:05:35 -0400
Message-ID: <20080625210535.GA8610@mit.edu>
References: <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu> <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com> <20080625203822.GA7827@mit.edu> <7v8wwtz1c1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:07:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBcCu-00073U-Pc
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 23:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYFYVGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 17:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYFYVGM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 17:06:12 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:38866 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751386AbYFYVGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 17:06:11 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBcBO-00033T-6j; Wed, 25 Jun 2008 17:05:38 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBcBL-0002GA-RF; Wed, 25 Jun 2008 17:05:35 -0400
Content-Disposition: inline
In-Reply-To: <7v8wwtz1c1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86351>

On Wed, Jun 25, 2008 at 01:50:06PM -0700, Junio C Hamano wrote:
> I just replied to Avery about that.  -- is always the way to disambiguate
> between refs (that come before --) and paths (that come after --), not
> limited to "git checkout" but with other commands such as "git log", "git
> diff", etc.

Stupid quesiton --- where is this documented?  I don't see this
documented either in the man page for git or git-checkout.

Regards,

						- Ted
