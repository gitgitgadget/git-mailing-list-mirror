From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git show documentation: no longer refer to
	git-diff-tree options
Date: Tue, 13 May 2008 11:11:26 +0200
Message-ID: <20080513091126.GZ27724@genesis.frugalware.org>
References: <1210545443-12665-1-git-send-email-vmiklos@frugalware.org> <7vzlqvw23y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MzUyxqdXrKJm2YZW"
Cc: git@vger.kernel.org, nanako3@bluebottle.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 11:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvqYX-000813-QL
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 11:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985AbYEMJLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 05:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756934AbYEMJLc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 05:11:32 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52102 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756822AbYEMJLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 05:11:31 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 12B721B2501;
	Tue, 13 May 2008 11:11:30 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 361454465E;
	Tue, 13 May 2008 11:03:25 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CC87E1778001; Tue, 13 May 2008 11:11:26 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	nanako3@bluebottle.com
Content-Disposition: inline
In-Reply-To: <7vzlqvw23y.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82006>


--MzUyxqdXrKJm2YZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 12, 2008 at 04:10:09PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm.  The symbol git-diff-core is defined for git-show and we say --raw is
> the default for git-show because of it?

Ouch, somehow I read infdef: as ifdef: so I intenionally did not add
git-show, but it was a mistake.

> How about doing it this way instead?

Sure, I like the idea of introducing the git-diff-p-stat-is-default
define.

--MzUyxqdXrKJm2YZW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgpWz4ACgkQe81tAgORUJawwgCeKRPFcMiupGH0C6trZe2O0xGb
JJYAoIVq7fAw/pZAvO9jwDh9P8Wncfmp
=SdzA
-----END PGP SIGNATURE-----

--MzUyxqdXrKJm2YZW--
