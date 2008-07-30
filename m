From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 4/4] Add a second testcase for handling invalid
	strategies in git-merge
Date: Wed, 30 Jul 2008 19:27:02 +0200
Message-ID: <20080730172702.GG32057@genesis.frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org> <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org> <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org> <ee13073cd83ff4a3cffb926b21cc54583e67f869.1217372486.git.vmiklos@frugalware.org> <f8e5afe347c194013ffd104b196a19a37d762f9b.1217372486.git.vmiklos@frugalware.org> <7vhca89s02.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RbV8uPMrJ9RsytZe"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 19:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOFT4-0005j2-Ul
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 19:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbYG3R1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 13:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbYG3R1F
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 13:27:05 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37481 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbYG3R1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 13:27:03 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9F30F1B24FD;
	Wed, 30 Jul 2008 19:27:02 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CE9BA4465E;
	Wed, 30 Jul 2008 18:41:41 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 756831190A16; Wed, 30 Jul 2008 19:27:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhca89s02.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90821>


--RbV8uPMrJ9RsytZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2008 at 04:42:53PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> True, but with the old code that might blindly have executed
> git-merge-index the test would also have failed, and you would want to
> tell two cases apart, wouldn't you?

Hmm, I wonder what is the right approach to test it. Should I exit with
a different error code with the strategy is invalid?

--RbV8uPMrJ9RsytZe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiQpGYACgkQe81tAgORUJaHyACeKE+gKTcpyJ/k3qQrJZ78EwmP
rWEAoKo8k/vJLIoLRRBaXL7R+tckFI/g
=CVyi
-----END PGP SIGNATURE-----

--RbV8uPMrJ9RsytZe--
