From: Jamie Evans <jamie@pixelrebel.com>
Subject: Re: GPG public keys
Date: Wed, 9 Dec 2015 09:03:47 -0800
Message-ID: <3860CB92-AD83-4372-AE7C-BBA8BF2D8F67@pixelrebel.com>
References: <9E65FDC7-B4F6-45DC-9B0E-F017B904C868@pixelrebel.com> <xmqqtwnsie6h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 18:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6i9n-0001Hx-2j
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 18:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbbLIRDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2015 12:03:54 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:47123 "EHLO
	homiemail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751874AbbLIRDx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2015 12:03:53 -0500
X-Greylist: delayed 78785 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2015 12:03:53 EST
Received: from homiemail-a8.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a8.g.dreamhost.com (Postfix) with ESMTP id 36403D22074;
	Wed,  9 Dec 2015 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pixelrebel.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=
	pixelrebel.com; bh=iWIeRBHKKh+UfOUtGdryhoBEmX0=; b=HpeSPzrGUtphV
	vmKu2ubAIvdZ3npbTFFvNA/r49uwfxe5mtGT8AdwofjyAI92F3Wvn1wFHodXmkJy
	Q1hOksJYgGJjcqAU98SltfghsJIQLBBW5eNFYW9c0Z/rYzaAX44hf1l1acG9ZW/h
	DHuhWuYZb+gZ6m85eYMX0scb+k/8oA=
Received: from jamiembp.jge.me (cpe-23-243-10-214.socal.res.rr.com [23.243.10.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jamie@pixelrebel.com)
	by homiemail-a8.g.dreamhost.com (Postfix) with ESMTPSA id F2853D22070;
	Wed,  9 Dec 2015 09:03:52 -0800 (PST)
In-Reply-To: <xmqqtwnsie6h.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282194>

Thanks, Junio, for the tutorial!  I had tried to lookup the key, but fa=
iled to put the =E2=80=980x=E2=80=99 at the head. =20

I was actually verifying the signature on a tarball release.  Just curi=
ous, how do I know the key in the database really belongs to you?  It=E2=
=80=99s has your name and email, but what=E2=80=99s to keep an imposter=
 from creating a key with your name on it and posting it to the databas=
e?  I guess all the signatories on your key are others vouching for you=
r key?

Thanks again for the reply.  Oh, and thanks for git!=20

Cheers,
Jamie




> On Dec 8, 2015, at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jamie Evans <jamie@pixelrebel.com> writes:
>=20
>> Can you please point me to the public GPG keys used for source code =
signing?
>=20
> I suspect that you are asking about our project, but instead of
> throwing you a fish, I'll show you how to catch one yourself.
>=20
> In a copy of linux kernel repository I have lying around from a
> random past, I did this:
>=20
>    $ git log --show-signature
>=20
> and saw something like this:
>=20
>    commit c6fa8e6de3dc420cba092bf155b2ed25bcd537f7
>    merged tag 'arm64-fixes'
>    gpg: Signature made Wed 07 Oct 2015 03:10:34 AM PDT using RSA key =
ID 84C16334
>    gpg: Can't check signature: public key not found
>    Merge: e82fa92 62c6c61
>    Author: Linus Torvalds <torvalds@linux-foundation.org>
>    Date:   Wed Oct 7 18:17:46 2015 +0100
>=20
>        Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/li...
>=20
> I do not have the public key with key ID 84C16334, but I can ask
> public keyservers.  Put 0x84C16334 in "Search String" in pgp.mit.edu
> and click "Do the search!"--it would result in the key that was used
> to sign the merge request that resulted in this merge.
>=20
> I also can do this:
>=20
>    $ git tag -v v3.0
>=20
> and I would see something like:
>=20
>    object 02f8c6aee8df3cdc935e9bdd4f2d020306035dbe
>    type commit
>    tag v3.0
>    tagger Linus Torvalds <torvalds@linux-foundation.org> 1311301049 -=
0700
>=20
>    Linux 3.0
>=20
>    w00t!
>    gpg: Signature made Thu 21 Jul 2011 07:17:44 PM PDT using DSA key =
ID 76E21CBB
>    gpg: Good signature from "Linus Torvalds (tag signing key) <torval=
ds@osdl.org>"
>    ...
>=20
> to find that Linus's tag signing key has ID 0x76E21CBB (I do have
> his key in my keyring, so this does not say "Can't check").
>=20
> Perhaps you can do the same to whatever project you are interested
> in.  For example, here is a starting point to do the same for our
> recent v2.6.4 tag:
>=20
>    $ git tag -v v2.6.4
>    gpg: Signature made Tue 08 Dec 2015 02:12:50 PM PST using RSA key =
ID 96AFE6CB
>    gpg: Can't check signature: public key not found
>    error: could not verify the tag 'v2.6.4'
>=20
