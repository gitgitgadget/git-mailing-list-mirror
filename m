Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CFE1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 21:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfGZVI1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 17:08:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57124 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfGZVI1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jul 2019 17:08:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:2120:88a3:41cd:c920])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E99686049B;
        Fri, 26 Jul 2019 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564175305;
        bh=1aHWtOuKMVbRV0O6xgk+li9j/Iqu1MF3KyLCcwZUotw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A5XJMyFfb8vDr0/wIv3+57eXJbbjJi4j8HaJ3OKrdps9Bh5Efi2pniztAHsBsdWKT
         4ePAFLZezIDz9wGwH/YdEGMZNxf6kLVjrS92VQ5fHDIaPBI9u8mGRzF9IxyE7liqWD
         /BoioBYU6pFolWV8sn+dCaJ5BTCdzogjE96hBAD7ns6hEBY4b+VIJggTceigL1NCAB
         pMF13X+rSIR/ZXFTOE/WuknzP1oJW1+9MzXoqn6JY9Vd2VMTFGimqA6d+MADOEk75O
         T5PG0AFgMJp0M3wCHUUAeKmpANuxXRyamNOKNhoaDpGC7JJkD81Ac8aIrfkq8zwGPO
         LNQrDb4vXqfb9jgFkJZV81+F2s6W3/26qVfQjZnp2Eoq6/aKVi2AvyMBBf3Bjg/Hlu
         NPxNfn6vvbituR3Rw3seD9nRYOF9VzVu3JxDz/0lOQDradsG/K1IUUYgtFlWTEGqPH
         VSuN9o45JEn8M4YnO3/6ohJZNcYRTZgg2m9tS7dwh+BeH7bqrqG
Date:   Fri, 26 Jul 2019 21:08:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/12] t/lib-rebase: prepare for testing `git rebase
 --rebase-merges`
Message-ID: <20190726210820.GF9319@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.294.git.gitgitgadget@gmail.com>
 <ae9e72b73bf2da0de3a5369748ebd358656588d9.1564049474.git.gitgitgadget@gmail.com>
 <20190726074317.GD9319@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1907261555410.21907@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907261555410.21907@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.0.0-trunk-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-26 at 14:01:03, Johannes Schindelin wrote:
> Actually, the part that uses it is not shown in the patch (one of the
> many, many reasons why I try to discourage patch review and encourage
> code review instead). The relevant section currently looks somewhat like
> this:

I feel like I may have communicated poorly earlier, so let me retry
asking this in a different way.

> -- snip --
> set_fake_editor () {
> 	write_script fake-editor.sh <<-\EOF
> 	case "$1" in
> 	*/COMMIT_EDITMSG)
> 		test -z "$EXPECT_HEADER_COUNT" ||
> 			test "$EXPECT_HEADER_COUNT" =3D "$(sed -n '1s/^# This is a combination=
 of \(.*\) commits\./\1/p' < "$1")" ||
> 			test "# # GETTEXT POISON #" =3D "$(sed -n '1p' < "$1")" ||
> 			exit
> 		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
> 		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
> 		exit
> 		;;
> 	esac
> 	test -z "$EXPECT_COUNT" ||
> 		test "$EXPECT_COUNT" =3D $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
> 		exit
> 	test -z "$FAKE_LINES" && exit
> 	grep -v '^#' < "$1" > "$1".tmp
> 	rm -f "$1"
> 	echo 'rebase -i script before editing:'
> 	cat "$1".tmp
> 	action=3Dpick

I believe you changed this line to "action=3D\&".

> 	for line in $FAKE_LINES; do
> 		case $line in
> 		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
> 			action=3D"$line";;
> 		exec_*|x_*|break|b)
> 			echo "$line" | sed 's/_/ /g' >> "$1";;
> 		"#")
> 			echo '# comment' >> "$1";;
> 		">")
> 			echo >> "$1";;
> 		bad)
> 			action=3D"badcmd";;
> 		fakesha)
> 			echo "$action XXXXXXX False commit" >> "$1"

And my question was about this line.

> 			action=3Dpick;;
> 		*)
> 			sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
> 			action=3Dpick;;
> 		esac
> 	done
> 	echo 'rebase -i script after editing:'
> 	cat "$1"
> 	EOF
>=20
> 	test_set_editor "$(pwd)/fake-editor.sh"
> }
> -- snap --
>=20
> Most importantly, `action` is used here:
>=20
>                         sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "=
$1"
>=20
> and I changed it to
>=20
> 			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
>=20
> In other words, rather than expecting the lines that are used by the
> fake editor to start with `pick`, after this patch, the tests expect the
> todo lists to start with a command consisting of lower-case ASCII
> letters (which catches `pick`, of course, but also `label`, `reset` and
> `merge`).
>=20
> After this patch, the fake editor also does not try to replace whatever
> command it finds by `pick`, but it keeps it as-is instead.

Right, that's how I read it, and that part I agree with. I think my
question is this: in what case do we execute the "fakesha" case? Are we
guaranteed that when we do, action isn't "&"? "&" seems fine for the
right-hand side of a sed s-statement, but not as the beginning of a
typical line in a sequencer file.

I ask because if we're testing a failure case, we want it to fail for
the right reason (e.g., the commit doesn't exist), and not because we're
producing invalid data. If the answer in this case is, "Well, we'll
always have something else before it which will set $action properly,"
then that's fine. This is test code, so it need not be bulletproof, but
I did want to ask.

If I'm still misunderstanding something, I apologize.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl07a8QACgkQv1NdgR9S
9otv2RAAy8JEvehDKOKAW++S66A3Or952ivwTv8eaBOBvPtRPT2q/s8kjXf55vxC
jPUnm85euqxNZInMG24Ek5HGrrErpJtf+Q8lSRkZfo379mJVtnsCBcvpOUo3isKA
nYeZQycjaVvlwXGVROwvfss+TXivbF4DGvWxRqe+1UpmtV+jGgO2sIzAz6hc31lr
3yQfQe47lC9wAaPULHuIOsdRiWMwGydAGDdpbdibpG5F97EQraboldYM62KX0yT3
AmdbQzGyaJULxqBIjsMErSQGA6fh2O7FhwbVeHac/8zcllcM8X9snQYt8DiYFntC
ByMsbusOzsXYFLfoq/07n00pk5dERsMqWO+iK+euzRGgbv5KlC/FhxVVuamUEIzi
zCCtxJyWliCdRBJgMlSdN8dboPAfQ16gScEgol0Qtpn/TyNNKMmqbzJwFzypcDhs
ipyYA8d/Tg4yzdYfAHXIsPaYpg0dWE7vgds4WTVn2ewYBKLGNIZzBd4OfAUlAud1
amqAj/FaafyRRcDb713vkibu1HAruZwurtrIWO8YIWVzcJOOjk1kqG212hNEKj5j
V7HiCnFRcHh7N8LBKrSfqKdJoq2c2zL+X/7BoSElOvJSsDbL0N77BDDCDZZd8Anu
9cmiC0+xzgaLxgGyHBQu6H6ifGJQUdWWukwmVhCLCADhrcx0LlA=
=OqKV
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
