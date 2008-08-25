From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support (was Re:
	limiting relationship of git dir and worktree)
Date: Mon, 25 Aug 2008 04:00:54 +0200
Message-ID: <20080825020054.GP23800@genesis.frugalware.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu> <7vsksw92nh.fsf@gitster.siamese.dyndns.org> <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <20080824235124.GA28248@coredump.intra.peff.net> <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9MdG657QzbOEWl1C"
Cc: Jeff King <peff@peff.net>, Karl Chen <quarl@cs.berkeley.edu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 04:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXRPT-000674-BR
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 04:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbYHYCA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 22:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753422AbYHYCA7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 22:00:59 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52794 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417AbYHYCA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 22:00:58 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5EA231B2525;
	Mon, 25 Aug 2008 04:00:57 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C793C4465E;
	Mon, 25 Aug 2008 03:01:58 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A0EDA1788129; Mon, 25 Aug 2008 04:00:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93585>


--9MdG657QzbOEWl1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 24, 2008 at 05:30:54PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Heh, if we are to do the attention-getter, let's do so more strongly ;-)

Does this include removing of --work-tree as well?

The git backend of Pootle (http://translate.sourceforge.net/wiki/) uses
it.

Also, here is a question:

$ git --git-dir git/.git --work-tree git diff --stat|tail -n 1
 1443 files changed, 0 insertions(+), 299668 deletions(-)

So, it's like it thinks every file is removed.

But then:

$ cd git
$ git diff --stat|wc -l
0

is this a bug, or a user error?

Thanks.

--9MdG657QzbOEWl1C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiyElYACgkQe81tAgORUJaxPwCgpC4BwKypwnn4M5oRMRb5yhmZ
/CgAn1qZ588JsN7d01uHmKulcrcgAE1F
=kInn
-----END PGP SIGNATURE-----

--9MdG657QzbOEWl1C--
