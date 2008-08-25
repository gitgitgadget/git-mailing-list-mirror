From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support
Date: Mon, 25 Aug 2008 23:37:48 +0200
Message-ID: <20080825213748.GJ23800@genesis.frugalware.org>
References: <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <20080824235124.GA28248@coredump.intra.peff.net> <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org> <20080825020054.GP23800@genesis.frugalware.org> <7v1w0dkd5s.fsf@gitster.siamese.dyndns.org> <20080825125205.GB23800@genesis.frugalware.org> <7vk5e4g58t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2gmp4rkCNM7tuNW"
Cc: Jeff King <peff@peff.net>, Karl Chen <quarl@cs.berkeley.edu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjmP-0004Uw-CG
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYHYVhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYHYVhz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:37:55 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55160 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753243AbYHYVhy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 17:37:54 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2637B1B2503;
	Mon, 25 Aug 2008 23:37:53 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 269984465E;
	Mon, 25 Aug 2008 22:38:26 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A87431788129; Mon, 25 Aug 2008 23:37:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5e4g58t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93685>


--J2gmp4rkCNM7tuNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 25, 2008 at 02:21:54PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> The real question was about if/why that git repository _has to be_ outside
> of /usr/lib/*/Pootle/.  Is that because --work-tree, if worked properly,
> would have allowed it to be, or is that because for some external reason
> you are not allowed to have .git under /usr/lib/*/Pootle/ directory?

I'm not 100% sure, but I think the reason is that Pootle runs as the
user 'pootle' which has write access to some /var/pootle or /home/pootle
dir, but has no write access to /usr/lib/*/Pootle/.

> If the latter, that shows the real requirement to keep supporting it as a
> feature, and issues around it need to be fixed.  Otherwise, i.e. if it
> does not require use of --work-tree but it uses it only because it could,
> that gives us less incentive to keep --work-tree as a feature.

I think this is the latter, though as I mentioned previously - it can be
still worked around by a "cd /other/path; git <command>; cd -" (speaking
in shell commands), so it is not a "must", it would be just ugly IMHO.

--J2gmp4rkCNM7tuNW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkizJiwACgkQe81tAgORUJY4QACaAxuINcqW6kCyFZ3LP6hpdpAJ
GQMAnAxF8tSot1D7cooK9HyZ0iLjdOQW
=mXsk
-----END PGP SIGNATURE-----

--J2gmp4rkCNM7tuNW--
