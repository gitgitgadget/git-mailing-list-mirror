From: Barry Warsaw <barry@python.org>
Subject: Re: Git's inconsistent command line options
Date: Tue, 1 Sep 2015 10:19:24 -0400
Organization: Damn Crazy Followers of the Horn
Message-ID: <20150901101924.6c350012@anarchist.wooz.org>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
	<20150831102558.1514e5f7@anarchist.wooz.org>
	<20150901092834.GA10706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cDbSAfmUeoFF7nLfPz=IWU5"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 16:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWmXh-0006u3-MN
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 16:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbbIAO2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 10:28:03 -0400
Received: from mail.wooz.org ([216.15.33.194]:58917 "EHLO mail.wooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbbIAO2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 10:28:00 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2015 10:28:00 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.wooz.org (Postfix) with ESMTP id E7AA710803E1
	for <git@vger.kernel.org>; Tue,  1 Sep 2015 10:19:11 -0400 (EDT)
Received: from mail.wooz.org ([127.0.0.1])
	by localhost (carnies.wooz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDsK6V1qQJ-U for <git@vger.kernel.org>;
	Tue,  1 Sep 2015 10:19:07 -0400 (EDT)
Received: from anarchist.wooz.org (anarchist.wooz.org [192.168.11.111])
	by mail.wooz.org (Postfix) with ESMTPSA id 9D83110800E0
	for <git@vger.kernel.org>; Tue,  1 Sep 2015 10:19:07 -0400 (EDT)
In-Reply-To: <20150901092834.GA10706@gmail.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276980>

--Sig_/cDbSAfmUeoFF7nLfPz=IWU5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sep 01, 2015, at 02:28 AM, David Aguilar wrote:

>While a script writer could write, "git -c core.cliversion=3D1 ...",
>no one does that, no one wants to do that, and it just seems
>like a bad idea that's best left unexplored.

Sure, no one will do that from the command line, but I don't think people
generally change their preferences that often.  Much more likely is that
they'll `git config` a more permanent choice for their shell usage and then
just use straight up "git" with the new ui.  -c would be reserved for scrip=
ts
which hard code a particular ui.

>Otherwise, this entire thread seems like a big non-issue.  The existing CLI
>hasn't hurt adoption...

A significant factor driving git adoption is network effects.  That's highly
motivating to overcome discomfort or confusion with the cli.  Once you've l=
ost
your beginner's mind, you are much less aware of the cli inconsistencies and
disconnects from other vcses.  The latter might not affect new users whose
only experience with vcses is git, but it presents a steeper learning curve
for folks migrating from other tools.

>...and tossing a config option at it only makes it worse.  The best config=
 is
>no config.

git already has no shortage of configuration options. ;)

Cheers,
-Barry

--Sig_/cDbSAfmUeoFF7nLfPz=IWU5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJV5bPsAAoJEBJutWOnSwa/PXEP/j650sV46+ROVoh/Xv09q3PG
gQSBvCA96kuFTGdPXURGrxQElkhNGOjy9siyTjwwL/AOAuLoKfj1bmS2jLtT1kwe
/v3lbbOxN73O5zHMHfjFZM/6UzjtIC8puNbZcVEujXjk5iMeV9fURaQeCG2TZUSW
pwKTbvcsXRl0jcwz924GzyDOCZVcwtBfKo5LzFymFdJ5lyuO1H98Z/e+OBSNCnow
FSp0iZlFwGDNisSpUfYcrRi2zEkdIVJxxU8adFkc90dXK4cv5EsANRqkCeX/kcq0
lFNLPCdpPqcWbSt0d3z6yBZbKG+1SGlX9mN08sxFACg0n63F/G0qgElqg7Wukw4j
I2/RG88Xrn8iI/7FJAxyAfRouBCMIcVoVVTmwAGhUpfv1+YC6/H5l+5pbknfGk1t
qofT+YO/DAcecI4qU8pF2nOHHOvmBlnv+hdIsDdEFv5z9/cec7f/AUBRLIdlo0KB
hylhVF+YhRVkoTZUfxjIuSzWIzUVLFsMMgmxt5jvi//kQFomuamtqCGeWHXYh87L
mVlIeqMlrgvZPyqfkhKbwaKMKFeBeJEWprqijsMrA50RJ6CUC4GOqa/OADtY9zjE
bQa0YhO4l9PGt8bvz2WIW+sf3f4cn8ZdLSPgR9nkZIQUs5iryrZvrqgdPE+K3ENH
u2UJHscMxp7Ol+dh3Bv2
=ZCty
-----END PGP SIGNATURE-----

--Sig_/cDbSAfmUeoFF7nLfPz=IWU5--
