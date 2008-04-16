From: Jeff King <peff@peff.net>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 22:55:37 -0400
Message-ID: <20080416025537.GA7878@sigill.intra.peff.net>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com> <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com> <7vej97x78v.fsf@gitster.siamese.dyndns.org> <m3abjushvs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:52:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlxov-00034H-Rg
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 04:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYDPCzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 22:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbYDPCzk
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 22:55:40 -0400
Received: from [208.65.91.99] ([208.65.91.99]:4579 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbYDPCzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 22:55:40 -0400
Received: (qmail 5441 invoked by uid 111); 16 Apr 2008 02:55:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 15 Apr 2008 22:55:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Apr 2008 22:55:37 -0400
Content-Disposition: inline
In-Reply-To: <m3abjushvs.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79671>

On Tue, Apr 15, 2008 at 06:33:48PM -0700, Jakub Narebski wrote:

> Please, let's don't repeat Mercurial mistake of placing unversioned
> information (such as branch names in case of Mercurial, or branches
> descriptions in this case) in-tree, i.e. version it.  Think of what
> would happen if you reset to the state (or checkout to some branch
> with the state) which is before some branch was created, or before
> some branch got description.  Mercurial deals with this using
> "special" not lika in-tree treatment of such a file... I don't think
> it is a good idea.

I think that is a reasonable argument.

> I think it wouldb be better to put branches descriptions somewhere
> outside object repository, be it .git/info/ref_names of .git/config.

But you make a jump in logic here when you make the alternative to put
it outside the object repository. Your first point argues against
versioning meta-information _along with the rest of the state_, but
there's no reason it can't be versioned separately (e.g., in another
branch that just has such meta-info).

-Peff
