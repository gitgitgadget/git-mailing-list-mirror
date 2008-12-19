From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-rm -n leaves .git/index.lock if not allowed to finish
Date: Fri, 19 Dec 2008 04:47:57 +0100
Message-ID: <20081219034757.GC21154@genesis.frugalware.org>
References: <87prjptfo7.fsf@jidanni.org> <20081219002524.GB21154@genesis.frugalware.org> <7v63lhf1cl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 04:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDWMZ-0000kg-1x
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYLSDsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 22:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYLSDsA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 22:48:00 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35909 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbYLSDr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 22:47:59 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 396205809F;
	Fri, 19 Dec 2008 04:47:58 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C86FE4465E;
	Fri, 19 Dec 2008 04:47:57 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B68AB11B862F; Fri, 19 Dec 2008 04:47:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v63lhf1cl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103539>


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2008 at 04:35:54PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> I think you need to have tons of files to cause the pipe buffer to fill up
> with the "rm 'frotz'" output, triggering a SIGPIPE to kill the upstream
> process of the pipe.

Ah, you are right. I did exactly what is in the lockfile.c part of your
patch, but I did not think about "if I don't get a SIGPIPE for 2 lines,
I may get one for 1000 lines". ;-)

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklLGW0ACgkQe81tAgORUJbdCwCbB7sPmD/o8riumc5LMmAHpWVg
4boAn0j1j0LUVhhizRQd3KGXFDvOxOwE
=R2yv
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
