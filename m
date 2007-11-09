From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 08:57:00 +0100
Message-ID: <6FCE17E3-9FAA-4676-B12A-369B31743DA6@lrde.epita.fr>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711090225110.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-102--608027657"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 08:57:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqOk9-000269-Vf
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 08:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbXKIH5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 02:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXKIH5S
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 02:57:18 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:54872 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbXKIH5S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 02:57:18 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IqOjm-0002i9-9i; Fri, 09 Nov 2007 08:57:10 +0100
In-Reply-To: <Pine.LNX.4.64.0711090225110.4362@racer.site>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64137>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-102--608027657
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 9, 2007, at 3:28 AM, Johannes Schindelin wrote:

> Would that not be easier to read as
>
> 		test t = "$INTERACTIVE" &&
> 			git_editor "$TODO" || die "Could not execute editor"

Hmm this will `die' if you're not running interactively.

Off topic question: why do you guys always do this instead of doing,  
say, this:

INTERACTIVE=false

case $1 in
.
.
.
   --interactive|-i)
     INTERACTIVE=:
     ... ;;
esac
.
.
.
if $INTERACTIVE; then
   git_editor "$TODO" || die ...
fi


?

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-102--608027657
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHNBLMwwE67wC8PUkRArO2AKC+UestbPWSefcWpGCgmOyAJIRs/QCfcOxD
CLzaPkzZsR4j6iEvDuvGlUg=
=I42s
-----END PGP SIGNATURE-----

--Apple-Mail-102--608027657--
