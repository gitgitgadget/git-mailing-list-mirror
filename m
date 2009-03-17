From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Tests: use test_cmp instead of diff where possible
Date: Tue, 17 Mar 2009 14:21:50 +0100
Message-ID: <20090317132150.GW3817@genesis.frugalware.org>
References: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org> <1b46aba20903170602j79735631uf20e0a729e69c4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 14:23:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjZGN-00083g-IG
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 14:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538AbZCQNVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 09:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbZCQNVx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 09:21:53 -0400
Received: from virgo.iok.hu ([212.40.97.103]:34930 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbZCQNVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 09:21:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C3C7E580DD;
	Tue, 17 Mar 2009 14:21:50 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8B54A44783;
	Tue, 17 Mar 2009 14:21:50 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D81D9153C003; Tue, 17 Mar 2009 14:21:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b46aba20903170602j79735631uf20e0a729e69c4b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113468>


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2009 at 02:02:37PM +0100, Carlos Rica <jasampler@gmail.com> wrote:
> What about the current other calls to cmp? I don't know if they should
> be changed too. Are they just the subject of another future change or
> have a different purpose? I recently used test_cmp in a test full of
> cmp calls (t1300-repo-config.sh).

I think that would be the next step, my patch only converts diff calls
to test_cmp.

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm/o+4ACgkQe81tAgORUJbnFQCgjPUOsg8JJyG3LTKFcOK04Dy8
gXwAoKFHrbHlATVmqiCXpB/CX/yFT7+r
=1WCG
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--
