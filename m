From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Deleted file is back - how to investigate?
Date: Sun, 26 Jun 2011 12:32:18 +0200
Message-ID: <20110626103218.GQ30255@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWCTLymdFNG0vGYZ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 12:49:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qamts-0007jB-9Y
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 12:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab1FZKtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 06:49:02 -0400
Received: from virgo.iok.hu ([212.40.97.103]:58701 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167Ab1FZKtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 06:49:00 -0400
X-Greylist: delayed 999 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jun 2011 06:49:00 EDT
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 37D5258046
	for <git@vger.kernel.org>; Sun, 26 Jun 2011 12:32:19 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2608744965
	for <git@vger.kernel.org>; Sun, 26 Jun 2011 12:32:18 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 03282BAC006; Sun, 26 Jun 2011 12:32:18 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176322>


--uWCTLymdFNG0vGYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In our public development repo I removed a file in the past, and I guess
with one of the recent merges we got it back. It looks a bit strange:

$ git clone http://frugalware.org/git/pub/frugalware/frugalware-current
$ git checkout 96b33e0

The ogle-gui directory is there:

$ git ls-files|grep ogle-gui
source/xapps-extra/ogle-gui/FrugalBuild

But in case I run git log:

$ git log --full-history --name-status -- source/xapps-extra/ogle-gui

The latest listed commit is the one that deletes it. So how can I see
which commit introduced the file again? (FWIW, we're merging with the
normal recursive strategy, ideally thing special.)

Thanks.

--uWCTLymdFNG0vGYZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4HCrIACgkQe81tAgORUJZWfQCfZDuLGnpnyn1Tkl6zsYZWUeQj
/dwAn1PKUgXOAzPwsju/GMt4HHE4o8eW
=HVzi
-----END PGP SIGNATURE-----

--uWCTLymdFNG0vGYZ--
