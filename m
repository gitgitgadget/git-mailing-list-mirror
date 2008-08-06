From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: do without .netrc
Date: Wed, 6 Aug 2008 12:50:22 +0200
Message-ID: <20080806105022.GX32057@genesis.frugalware.org>
References: <4898DBA6.1060707@univie.ac.at> <20080806085025.GU32057@genesis.frugalware.org> <g7bq85$otb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="izz28U1oUrj4qnXN"
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Aug 06 12:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQgc6-0008CJ-EG
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 12:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbYHFKu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 06:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbYHFKuZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 06:50:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60756 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664AbYHFKuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 06:50:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C95061B2529;
	Wed,  6 Aug 2008 12:50:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4C1684465E;
	Wed,  6 Aug 2008 12:01:13 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D77CB11901AF; Wed,  6 Aug 2008 12:50:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g7bq85$otb$1@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91501>


--izz28U1oUrj4qnXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2008 at 11:17:48AM +0200, Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
> Not having the password on disk[?!]

I think you can't avoid so (we are talking about http).

There is no such thing as ssh-agent for http, and typing the password
for each pull or push is boring. (OK, this is subjective, but I think
nobody types his/her pass on every push/pull.)

You could have the password in the URL, but the it's in .git/config,
even worse.

--izz28U1oUrj4qnXN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZge4ACgkQe81tAgORUJbZtwCfWNAYAcqaxnFyVKSOVfkuG/Pr
e1kAnirNqBw6978qm0hizT8/oWHWAggY
=pdau
-----END PGP SIGNATURE-----

--izz28U1oUrj4qnXN--
