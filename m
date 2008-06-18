From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 00:38:21 +0200
Message-ID: <20080618223821.GJ29404@genesis.frugalware.org>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nTlbyE9hfvXv7wAq"
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:39:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96JH-0006OT-LY
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbYFRWi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbYFRWi2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:38:28 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34416 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbYFRWi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 18:38:27 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1C3D91B250E;
	Thu, 19 Jun 2008 00:38:26 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2628E44668;
	Thu, 19 Jun 2008 00:16:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7D18D1778015; Thu, 19 Jun 2008 00:38:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m33anao11u.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85419>


--nTlbyE9hfvXv7wAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2008 at 03:01:24PM -0700, Jakub Narebski <jnareb@gmail.com> wrote:
> As a part of patch series introducing new fast-forward strategies
> (--ff=never, --ff=only) there was patch which did merge reduction
> before selecting merge strategy, by Sverre Hvammen Johansen
>   "[PATCH 4/5] Head reduction before selecting merge strategy"
>   http://thread.gmane.org/gmane.comp.version-control.git/80288/focus=80335
> (I'm not sure if the link above is to nevest version of patch series).

Side note: builtin-merge does not have problem with merging 25+ refs
even in case every ref contains "new" commits.

The patch by Sverre Hvammen Johansen is useful if some of the refs has
no "new" commits, so it will help here, but I think it does not help in
all cases.

--nTlbyE9hfvXv7wAq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhZjl0ACgkQe81tAgORUJbBOACdFLoip8IaScyVjLw/chnms83l
w7kAn3xLK6jNXAAjyQbD0pm0eUuz6wyD
=NPQM
-----END PGP SIGNATURE-----

--nTlbyE9hfvXv7wAq--
