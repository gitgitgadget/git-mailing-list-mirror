From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Recording merges after repo conversion
Date: Tue, 9 Oct 2007 09:19:28 +0200
Message-ID: <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-1006287934"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 09 09:20:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If9O9-0000g6-1W
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 09:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbXJIHUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 03:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbXJIHUJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 03:20:09 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:46223 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbXJIHUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 03:20:07 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1If9Np-0001z2-4b; Tue, 09 Oct 2007 09:20:01 +0200
In-Reply-To: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60366>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-1006287934
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 9, 2007, at 9:09 AM, Peter Karlsson wrote:

> Hi!
>
> I have a couple of repositories converted from CVS to Git using
> parsecvs. Some are just converted, some I've continued to develop  
> after
> the conversion (and cloned a couple of times).
>
> Since parsecvs gave me all the CVS branches, I would like to record  
> the
> merge points in the Git history, if possible. I have commited merges
> with comments like "merged <branchname>", so I can probably find them
> quite easily, and I do have the imported CVS branches available. Can I
> record the merge information so git knows about them?
>
> Is it safe to do so on a repository that has already been cloned (i.e,
> will a later push/pull work)?

I think you can use grafts do achieve this.

 From Documentation/repository-layout.txt:
info/grafts::
         This file records fake commit ancestry information, to
         pretend the set of parents a commit has is different
         from how the commit was actually created.  One record
         per line describes a commit and its fake parents by
         listing their 40-byte hexadecimal object names separated
         by a space and terminated by a newline.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-1-1006287934
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHCyuBwwE67wC8PUkRAkoFAKCmP4Lr3X5GQco6o6UwENdGNWUE8QCfdtFZ
h+787+UVKr/Gh1nAU6c9MSU=
=CY0Y
-----END PGP SIGNATURE-----

--Apple-Mail-1-1006287934--
