Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC333C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjEHVjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEHVjx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:39:53 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFEDC
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:39:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0380B5A1A8;
        Mon,  8 May 2023 21:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1683581938;
        bh=OwA0QwkZyhzNEr4qCStgSGf94LznSgcuK6jZtUawjfI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TvKno8Az5YiL0PjDFgCNfW8dFkhrGjQloktRaUfNOIja4AEBHmcLKLkxHjZ5pVvCA
         Cwpl0yDt6ifKnVRx4mc5k4QUli8FvO1n61AC2Gq/EMj/IhlgRpuYnJq4B+v7RWc/k4
         xkA+/UI9avpf1gB4FWCoqqqIMaCqu/uWJzyr3htTxX6VdZSGveoA7hxlylZiXUieLL
         +aeGoFy7Jf09m8knrkTyB7hEHViUZf7GxsL5O4D1COVeF6ouGiyNtnD3esweF2bZHP
         pmIvZAdpavIyDH3TMn8n+ef+wOnbTcEaQvmeUd0p+aIjP1bBWGDSNcyYGG1HPVqYuQ
         dJ8g8tTgAw+HH6T/PfvGb1TX+0xLm7I/OREtg6/7iut9ZkExcjhBJVV+4SF0BrZFyE
         evtojtnBYB9LxkxQh4OocCb24ycTq2i9JguGh1Fi2H59UpVMIxZXDXT2O5xST4osTc
         131Vty6rVE5uLxR3og3BbMoQT3xnB7SFRpO37equEaPy9JXRk/K
Date:   Mon, 8 May 2023 21:38:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Message-ID: <ZFlr8PWOPRuLuP6E@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
 <ZFLmGYXgvyydLB5E@tapette.crustytoothpaste.net>
 <645857d8e8fd7_4e6129477@chronos.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PheK1QiAc8Q94/aK"
Content-Disposition: inline
In-Reply-To: <645857d8e8fd7_4e6129477@chronos.notmuch>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PheK1QiAc8Q94/aK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-08 at 02:00:56, Felipe Contreras wrote:
> brian m. carlson wrote:
> > On 2023-05-02 at 23:46:02, Felipe Contreras wrote:
> > > In my view one repository should be able to have part SHA-1 history,
> > > part SHA3-256 history, and part BLAKE2b history.
> >=20
> > That is practically very difficult and it means that it's hard to have
> > confidence in the later history because SHA-1 is weak and you have to
> > rely on it to verify the SHA-256 history later.
>=20
> Why would I have to rely on SHA-1 to verify the SHA-256 history later
> on?

If your history contains mixed and matched hash algorithms, you'll need
to be able to verify those commits to the root to have any confidence in
a signed commit or tag, which means trusting SHA-1 if you have any SHA-1
commits in the repository.

> > Since attacks always get better, SHA-1 will eventually be so weak that
> > collisions can be computed in the amount of time we now take for MD4
> > or MD5 collisions (i.e., seconds), and with your plan, we'd have to
> > retain that history forever with the resulting lack of confidence in
> > part of the history.
>=20
> We have to do the same with your plan as well.
>=20
> Your plan relies on SHA-256 being interchangeable with SHA-1, so if the
> Git project decided to switch *today* to SHA-256, we would have two
> object ids:
>=20
>  1. 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
>  2. 2b4ebdace10518280172449c012af17b51e9d46e023a91a5d3dd3a8ad9e4a116
>=20
> This object would refer to a tree and a parent object with SHA-1 ids,
> which would be OK, because they would be interchangeable with some
> corresponding SHA-256 ids.
>=20
> Isn't that your plan?

For a period of time, yes.  At some point, people will abandon SHA-1 and
won't use it anymore for a particular repository, and then its security
doesn't matter.

> Therefore the SHA-1 of the parent of the commit, and the tree of the
> commit would be trusted and retained forever.

Nope.  At some point, we just turn off SHA-1.

> > This also doesn't work with various structures like trees, the index,
> > and pack and index formats, which have no indication of the algorithm
> > used and simply rely on fixed-size, often 4-byte aligned object IDs
> > without any metadata.
>=20
> So? The index and pack objects can be regenerated, so at any point in
> time they could be regenerated for SHA-1 or SHA-256.

Right, and that point you've basically converted the repository over.

> The tree object is a no-brainer. For an object of type "commit:256" you
> require a tree of type "tree:256". Easy.

That doesn't work with the pack format because there are only seven
valid types of objects, and five of them are used.

> > Also, we've already decided on the current design a long time ago with
> > the transition plan after extensive, thoughtful discussion by many
> > people.
>=20
> Who is "we"?

The list members.

> I've participated in many discussions in the git mailing list where the
> consensus is that 99% of people decide to do something, and that
> something never happens.
>=20
> The fact that "we" have decided something doesn't carry as much weight
> as you seem to think it does.

Jonathan Nieder decided to propose an approach for how we'd go about
this, and it was discussed extensively on the list and the parts that
I've implemented have almost completely conformed to that documentation.

I think his approach was very thoughtful and addressed many questions
about how the project was to proceed, and I appreciate that he sent it
and that others contributed in a helpful way.

The project wouldn't have been possible unless we had a clear decision
on how to implement things.  There was an opportunity at the time to
comment on the approach and propose alternatives, and we didn't choose
to adopt any.

> Moreover, haven't "we" decided that this transitioning plan is
> *tentantive*, and the SHA-256 feature is *experimental*?

We've documented that it's experimental because it's not seeing wide
use.  I expect that will change, at which point it will no longer be
experimental.  The design is not tentative and there are no plans to
change it.

> > Very few people other than me have worked on sending patches to
> > work on the hash function transition, and that work up to now has all
> > been done on my personal time, without compensation of any sort, out of
> > a desire to improve the project.
>=20
> Which seems to suggest if there is a need, it's not very pressing.
>=20
> Doesn't it?

No, I don't agree.  An approach to continue to use SHA-1 indefinitely
means that Git will not be viable at many major organizations and
in many major governments which have restrictions on using insecure
cryptography.

I think this ends the point at which I'd like to respond to your
proposal further.  I continue to feel that it's argumentative,
unproductive, and not in the best interests of the project, and I don't
think continuing here is going to shed any more light on the topic.

Ultimately, I feel that my previous statement that we're not going to
see eye to eye on most things continues to be correct.  I also don't
think arguing with you is a productive use of my time or a positive
contribution to the community, and in general, I'm going to avoid
commenting on your patches or proposals because I can't see a way that
we can interact in a useful and helpful way on the list or elsewhere. As
a result, I'll kindly ask you to refrain from CCing me on further emails
to the list or otherwise emailing me for the indefinite future, and I'll
do the same for you after this email.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--PheK1QiAc8Q94/aK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZFlr7wAKCRB8DEliiIei
gTUQAP4s3LlWFnMVmnBL8cAtHvDvhj63Rom5/1SKC2BBtzXIrQD+PQKkYG50vCo9
TGrXKTG2j/mTx4/p1jSaQbIvzG9D0g4=
=YbIA
-----END PGP SIGNATURE-----

--PheK1QiAc8Q94/aK--
