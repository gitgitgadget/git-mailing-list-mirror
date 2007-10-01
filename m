From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn merge helper
Date: Mon, 1 Oct 2007 09:56:21 +0200
Message-ID: <0D8A7A3C-8F51-482D-9229-29ADC9585760@lrde.epita.fr>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr> <20071001025059.GA29323@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-31-317300153"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 09:57:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcG9M-0001fP-O3
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 09:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbXJAH4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 03:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbXJAH4q
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 03:56:46 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:55608 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbXJAH4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 03:56:44 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IcG8v-0006IE-Vy; Mon, 01 Oct 2007 09:56:42 +0200
In-Reply-To: <20071001025059.GA29323@atjola.homenet>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59585>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-31-317300153
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Oct 1, 2007, at 4:50 AM, Bj=F6rn Steinbrink wrote:

> On 2007.09.30 16:15:49 +0200, Benoit SIGOURE wrote:
>> On Sep 30, 2007, at 1:05 PM, Bj=F6rn Steinbrink wrote:
>>
>>> Hi,
>>>
>>> I recently discovered git-svn and absolutey love it. One thing =20
>>> that I'm
>>> missing though, is an equivalent of "svn merge" for merging =20
>>> between svn
>>> remotes, to support the SVN way of using "squashed" merges, where =20=

>>> you
>>> just note the merge meta-data in the commit message. "git merge" =20
>>> didn't
>>> work for me (and probably isn't expected to work) to merge =20
>>> between two
>>> svn branches, so I've resorted to cherry-picking the required =20
>>> commits
>>> one by one into a temporary branch and then squashing them =20
>>> together by
>>> doing a --squash merge with a second temporary branch (as in [1]).
>>
>> I fail to see why you'd want to reproduce the broken behavior of =20
>> svn merge.
>>  Anyways, git-svn is a great way to merge SVN branches, =20
>> unfortunately it
>> can't detect when merges happened on the SVN side.  I think you =20
>> can use it
>> nevertheless by manually adding a graft at the last merge point, =20
>> which
>> would help you merging the right revisions without having to =20
>> specify what
>> needs to be merged (unless someone made another merge on the SVN =20
>> side, in
>> which case you need to update your graft).
>
> Then how does that work? The manpage explicitly says that I should not
> use git-{pull,merge} on branches I want to dcommit from. And a trivial
> test immediately got the expected effect of git-svn trying to =20
> commit to
> trunk instead of the branch.

Ah, yes, you're right.  Well, this will work the day we can pass an =20
option to git-svn dcommit to tell it where the commit must be sent.

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-31-317300153
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHAKglwwE67wC8PUkRAittAJ97Tk0q2CoB0RVseEK3CtPn2owaVgCgl+VD
pnZNr3BNKBnMhTTKBVN5nLA=
=QhUq
-----END PGP SIGNATURE-----

--Apple-Mail-31-317300153--
