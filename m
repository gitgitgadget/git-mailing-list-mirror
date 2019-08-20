Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715981F461
	for <e@80x24.org>; Tue, 20 Aug 2019 02:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfHTCpO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 22:45:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58122 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbfHTCpO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Aug 2019 22:45:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4857B60425;
        Tue, 20 Aug 2019 02:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566269110;
        bh=uOl6ZjFZ1bYJ5cl9quBqlbSxaSuykByPaaRW5z3h8iA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qlU4RtEQabsYJuu8a2cvK0KzNDdDBGWWBWK8Ty5hSntDxlozzQKrrOC9nncmO9Pvt
         Cmihlp3Lv7tedmBbuyFUelEghRk9uU/XKymq8jmycXM57ymhR1L+J3IbnEUYGbb32C
         gMLirIII4kJ5PP7uRwHAI6aMCETa7y659kUOOjv7gsKkQ0UVcmBAkdmeIcMXz6db6N
         pUSDUFSTUU4W0xg1GHxJgom2cOFvLELZXUdIoIuwEnocLSBN/Df8TK8R/CAs6ofVih
         xhtdvaUCLcjxT19kctkCKepLp9OxFilXgIw31acWqMQ/Zj/LV8nRnTmlLTXhKgjLPX
         5Jf/sbjlicw5Rb6H+Dzt0mW3N3ECADHppjGU7FLNqLhK0yvekekEpOVbherNJWGd3d
         b9x4/LF31iL0cLacImtB2tyjAHLQYmZEghMLOYd9J/zkXsUqlDRJylizBj9V5pB2tc
         WZCwF5ENBKxfUJgBds7Ma3OXAGQ4IgXvpNM3a4ikL3zmIjfw+QB
Date:   Tue, 20 Aug 2019 02:45:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
Message-ID: <20190820024505.GH365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-3-sandals@crustytoothpaste.net>
 <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline
In-Reply-To: <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-19 at 09:41:42, Phillip Wood wrote:
> Hi Brian
>=20
> On 18/08/2019 19:44, brian m. carlson wrote:
> > When applying multiple patches with git am, or when rebasing using the
> > am backend, it's possible that one of our patches has updated a
> > gitattributes file. Currently, we cache this information, so if a
> > file in a subsequent patch has attributes applied, the file will be
> > written out with the attributes in place as of the time we started the
> > rebase or am operation, not with the attributes applied by the previous
> > patch. This problem does not occur when using the -m or -i flags to
> > rebase.
>=20
> Do you know why -m and -i aren't affected?

I had to look, but I believe the answer is because they use the
sequencer, and the sequencer calls git merge-recursive as a separate
process, and so the writing of the tree is only done in a subprocess,
which can't persist state.

Should we move the merge-recursive code into the main process, we'll
likely have the same problem there.

> > diff --git a/apply.c b/apply.c
> > index cde95369bb..d57bc635e4 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -4643,6 +4643,7 @@ static int apply_patch(struct apply_state *state,
> >   	struct patch *list =3D NULL, **listp =3D &list;
> >   	int skipped_patch =3D 0;
> >   	int res =3D 0;
> > +	int flush_attributes =3D 0;
> >   	state->patch_input_file =3D filename;
> >   	if (read_patch_file(&buf, fd) < 0)
> > @@ -4670,6 +4671,10 @@ static int apply_patch(struct apply_state *state,
> >   			patch_stats(state, patch);
> >   			*listp =3D patch;
> >   			listp =3D &patch->next;
> > +
> > +			if ((patch->new_name && ends_with_path_components(patch->new_name, =
GITATTRIBUTES_FILE)) ||
> > +			    (patch->old_name && ends_with_path_components(patch->old_name, =
GITATTRIBUTES_FILE)))
> > +				flush_attributes =3D 1;
>=20
> style nit - these lines are very long compared to 80 characters

They are.  They aren't two different from other lines in the file, and I
thought that leaving them that way would preserve the similarities, but
I can also wrap them.  I'll send out a v5 with wrapped lines.

> > diff --git a/convert.c b/convert.c
> > index 94ff837649..030e9b81b9 100644
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -1293,10 +1293,11 @@ struct conv_attrs {
> >   	const char *working_tree_encoding; /* Supported encoding or default =
encoding if NULL */
> >   };
> > +static struct attr_check *check;
>=20
> I was concerned about the impact adding a file global if we ever want to
> multi-thread this for submodules, but looking through the file there are a
> couple of others already so this isn't creating a new problem.
> > +
> >   static void convert_attrs(const struct index_state *istate,
> >   			  struct conv_attrs *ca, const char *path)
> >   {
> > -	static struct attr_check *check;
> >   	struct attr_check_item *ccheck =3D NULL;
> >   	if (!check) {
> > @@ -1339,6 +1340,12 @@ static void convert_attrs(const struct index_sta=
te *istate,
> >   		ca->crlf_action =3D CRLF_AUTO_INPUT;
> >   }

The portion I've included above demonstrates that this was already a
static variable, just one hidden in a function.  So yeah, this is no
worse than it already was.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1bXrEACgkQv1NdgR9S
9ovJMw//dBPmYqNtuF3adJoGOHKJeWQZpHJt9C+pHZg1295qlCzdUeCoF9pFvm+g
o0CERLs+wdXldu3TS6KKKje7uvvRIQCSTYrSPWkfsvy9PKmi0SipgQcJcXmKsMNC
lm1VmPAnWRM96728DqkJYgaidrDu3BFGPDh2EN4q8+81KNigTBbF4+zRCh9PIODz
8CCuIUu+mXX4JAR/snU7KhHUZ+z9oD6f/HXHeDscrp67QnZfTIanGXUga9qF1beL
0T54+pXZ02PIwK4s6NMSC9K9eDAEdhINB1GCsDrTToBZIHiKHzBBnEI5iez7k1AL
s0RlraARpv6hUOh3jm7QMm8oseX8OEKsMu/8JGzUpjjBcvlMj0uIIhIoD6rClnz9
6PA7kO8HFu2Em6vpWRxgl4fwYOvbP4Mrxe0Rv8kfMy4+EHwSFG7DBQgkj+ywEFbY
dP6H0B5r7gHdWZNBYEuiIPL5U9MDDf/XfPXQr/cy9//wp3neYqCmgTXWigQRAX9v
z9iuBJ8pEvAg9Ns5himotzfSoq0pbAaiY3N6m6i+73TtLhdPp4a9J1zN3uAeUHZ5
gFhyy9f0Kq4199hmNNQ5rhlRmI0DLrAfFTBL4Bs4FMn3si02bSCVdLDBw8OsPfeX
hwB9Y+0F81PWmvIUNxnuDhUG8X/hpHoVA1838UaFpKam4KO7U1c=
=5eCP
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--
