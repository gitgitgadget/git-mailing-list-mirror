Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31AEA20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbdK0UJm (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:09:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56200 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751953AbdK0UJl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2017 15:09:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 447886046D;
        Mon, 27 Nov 2017 20:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1511813378;
        bh=RyF7CJktBavWjNhvLJplbJjRzWIychZkJdz9ui8VbE0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qsxK1/+KXmffsAZL9vXb4fc3t0RJRoiihGb8HrH+Kju97rzOT5S70NQmyL9iiuOzb
         +7C9vgTgffEZHxtBNmsOZ9+KLnoETUhdR6JP0rclA9e3HKZQ0hcmUwGIoJ39pt6Z/V
         gyjOjca8j941u/by70XqWGm01Hr17CPcM+AeK/6p7KAgMCcH3s3fzk8iRE2nKMNnG9
         MKniSZCM6vrGpyl1vyvsqRyrTg/W3wOrgnSm+u8GKhmPUyQgJpw2IOOYFKRNMeyJak
         8CDAOGOtuOiJPo+tUBbCR6s4Nkq9i7/Pa3bigH6UiVDeRpON4fdO/m7xaMKthYlpAo
         +aif1agQisO0KnWxt02/TUr/kC+gy0i2fUlE01e0y6Hq6cwRURK6uj+LFGmFDQfSXX
         uLvrXa5DqT0Dm8LiCHaJg8fXOKVAa4TGqvHE/squtZPz0WsDOi/hcgJbhzSIY2aaI2
         IjcaunLPzNrh9cMAhWR29/HbyNus6rIdPLMjSTxI9JSNGe67kn9
Date:   Mon, 27 Nov 2017 20:09:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171127200932.GA558049@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        lars.schneider@autodesk.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171127134716.69471-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20171127134716.69471-1-lars.schneider@autodesk.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 02:47:16PM +0100, lars.schneider@autodesk.com wrote:
> From: Junio C Hamano <gitster@pobox.com>
>=20
> When a graphical GIT_EDITOR is spawned by a Git command that opens
> and waits for user input (e.g. "git rebase -i"), then the editor window
> might be obscured by other windows. The user may be left staring at the
> original Git terminal window without even realizing that s/he needs to
> interact with another window before Git can proceed. To this user Git
> appears hanging.
>=20
> Show a message in the original terminal and get rid of it when the
> editor returns.
> diff --git a/editor.c b/editor.c
> index 7519edecdc..4251ae9d7a 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -40,6 +40,35 @@ int launch_editor(const char *path, struct strbuf *buf=
fer, const char *const *en
>  		const char *args[] =3D { editor, real_path(path), NULL };
>  		struct child_process p =3D CHILD_PROCESS_INIT;
>  		int ret, sig;
> +		static const char *close_notice =3D NULL;
> +
> +		if (isatty(2) && !close_notice) {

Sorry for coming to the topic so late, but it occurred to me that we
might want to conditionalize this on an advice.* flag.  I expect there
are some people who will never want to see this, and letting them turn
it off would be good.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloccPwACgkQv1NdgR9S
9oslbhAAu4NNF6E+/QxDea0gTDquAuH7K5TmdnGYxlmimWQl2b9kylPdZxzj0Gaf
byarx7KpIbG0x4ZYXJTTpKf8+6w2xmwB5JqUWVIXWFUfWMJywgUASAh/r+u3sgYX
AqK8ZXj5ki7nRgjKP67kb0ghXBzcUlecPgXT27f9v8TUSF81VoInC960/zzER87+
u1j6eyD7yvwD7u5xO05dN0luS5SWoYZvcd1zCfpTbXdVLKFImgyLWgYaHgDgc74C
UWJF0bEIms7VUaIMf8GRYfw0KpKVP4CjsUTyxX5x8VSgTTwc2WNgYZitssnJla1H
bnDqCtmog3bL1EpuJYvmcmvPvB2LINPN4lNYnflX2HrCK6o0Yhakj71dxKQCBFar
nyegbcPKAGk55KYpzfBzM3Fm+YNzut1O76/+uOmaKdT2a527tEVpI/SxH3TfTqQx
UyRPpoHusXv+uuh11K7EwutWMStXW9zQMv08x9Hz6Rfjuvh5TngFlyUlI1GxAVml
3SArRXUehKW+KKT+phWW5D5ourqM5U6atWLMAgJXdLXcudXDfXWq5WYQdGJkig6k
4LOj+wDDw3qjAaN0cymEijeuOZdbKHBk4PX1Tu8gT3oOpbVKWENY7ekzQXZhBxZQ
hMIYoEDKoWR2r/9RYo4pLL3DLb+bgF7/G90XFmrl897z6WPmDEk=
=jqZ4
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
