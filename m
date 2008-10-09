From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH maint] builtin-merge.c: fix memory under-allocation
Date: Thu, 9 Oct 2008 16:49:57 +0200
Message-ID: <20081009144957.GT536@genesis.frugalware.org>
References: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil> <20081009001727.GP536@genesis.frugalware.org> <0LPLRUZaEHuEZTri_v38ySJHqYAhrfOpOkyUviUH9eOrx8IXBEAzYA@cipher.nrlssc.navy.mil> <7vmyheowcr.fsf@gitster.siamese.dyndns.org> <rKU9r5196P_JTKZZkb10yo7uwH_n_7KAuyX6RMOa9jc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="51uid+Ur/3ko9cBW"
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 16:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnwrE-0001Nv-4m
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 16:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbYJIOuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 10:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbYJIOuC
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 10:50:02 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34136 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbYJIOuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 10:50:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1B382580B6;
	Thu,  9 Oct 2008 16:49:59 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A5FB64465E;
	Thu,  9 Oct 2008 16:49:58 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F30FD11901A1; Thu,  9 Oct 2008 16:49:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <rKU9r5196P_JTKZZkb10yo7uwH_n_7KAuyX6RMOa9jc@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97855>


--51uid+Ur/3ko9cBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2008 at 09:15:02AM -0500, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Fix two memory allocation errors which allocate space for a pointer rather
> than enough space for the structure itself.

Aah, I see it now. I thought first that it was just a variable->type
change.

Acked-by: Miklos Vajna <vmiklos@frugalware.org>

--51uid+Ur/3ko9cBW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjuGhUACgkQe81tAgORUJZpfQCcDBux32okPd3S/epMTlX6l567
q/EAn1wQ4wMghlRYFTlYAuM8H3NGnSpt
=gs2f
-----END PGP SIGNATURE-----

--51uid+Ur/3ko9cBW--
