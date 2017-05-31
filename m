Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7A81FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbdEaWGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:06:46 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46870 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751004AbdEaWGp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 18:06:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 80CF6280AD;
        Wed, 31 May 2017 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1496268404;
        bh=wjiRZw6eWrNpgDledd2FfP66CjsNfq9CVFRgyTTlpPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icyzJSKPyi1OMmG0/VoFymF2+2OBGuDT2s0oqhWQS3wKLAbaCVeH7jDPz/10X9w+p
         5o45faz+ddGbRu97UWhM/4qTGIlGMjK87ElE6bTBdRORg863y9iKJ2iJ8tpnQM9yY2
         5jnC4pvmuugUODDMfyrcpJq2m6G/n4PL6SOdf9VEPYGFCSYhgUI5JmuIV6AcvzPcHB
         9ERZ7GbwerUODlARv/wZK0tW4F7tqWvSBK/nqlYiQKzPscT0ZJYnxV5tS26eYXdYM2
         0ZVVya+hiibwlVAhYyMe9BPDeao9lY5mHAladYCON+1HSP2GHZe63x8jCbMuby+GD/
         GSFqudclNYkDQNbLs0uwoIBSigVKQdg/TeBkwryu55PCfFX8jtxVxxZUigoKeoinp2
         MTI17AY49AhNy6gBDJ/1ZLawJSjPJDlAlVrji+21KpG4skMBP487jcxAEcpe7aSc9T
         CU/QxRsssGzJlwa2UvlqFvwE1aahnyHb24cehXQdWCKT7trMpqI
Date:   Wed, 31 May 2017 22:06:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
Message-ID: <20170531220640.kd73vbyx6fr4ht7h@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
References: <20170530173109.54904-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fxbd5ddvndryjaua"
Content-Disposition: inline
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fxbd5ddvndryjaua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 10:30:36AM -0700, Brandon Williams wrote:
> A month or so ago I thought I would lend a hand to Brian and do a round of
> conversions from sha1 -> struct object_id.  Now that Brian's latest serie=
s has
> hit master I can finally send these patches out.
>=20
> The first couple patches are from Brian which convert some of the notes l=
ogic
> to using 'struct object_id'.  The remaining patches are to convert the gr=
ep and
> diff machinery to using 'struct object_id'.
>=20
> Brandon Williams (26):
>   grep: convert to struct object_id
>   diff: convert get_stat_data to struct object_id
>   diff: convert diff_index_show_file to struct object_id
>   diff: convert diff_addremove to struct object_id
>   diff: convert run_diff_files to struct object_id
>   diff: convert diff_change to struct object_id
>   diff: convert fill_filespec to struct object_id
>   diff: convert reuse_worktree_file to struct object_id
>   diff: finish conversion for prepare_temp_file to struct object_id
>   patch-ids: convert to struct object_id
>   diff: convert diff_flush_patch_id to struct object_id
>   combine-diff: convert diff_tree_combined to struct object_id
>   combine-diff: convert find_paths_* to struct object_id
>   tree-diff: convert diff_root_tree_sha1 to struct object_id
>   notes-merge: convert notes_merge* to struct object_id
>   notes-merge: convert merge_from_diffs to struct object_id
>   notes-merge: convert find_notes_merge_pair_ps to struct object_id
>   notes-merge: convert verify_notes_filepair to struct object_id
>   notes-merge: convert write_note_to_worktree to struct object_id
>   diff-tree: convert diff_tree_sha1 to struct object_id

I've wanted to convert this function for some time.  I'm glad you got
around to it.

Other than the issue I pointed out, the fact that I'm obviously not
qualified to review my own patches, and the issue that Stefan pointed
out with GIT_MAX_HEXSZ, this looks good to me.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--fxbd5ddvndryjaua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkvPnAACgkQv1NdgR9S
9otEPw//VPMxk9hbP4ZUb8pj8nhrQUINMO+YYdUvCVVdejNJT0u6pwepkWKIfg2s
t4nBinjM5dWjr3Q077BUs+p38Ce2V7uEAe/ccggPtRr4TS18u+u9Re7rp9L3q3Sl
fWW2mXyyB48B16/jHue5r6D8DYJ05ieOlETzHBnywZrj2eEfYuM1yrGrRZHEnmrA
HJpnt5z904RLGtvNfOZfMf/P2ThXTmW9OhC/G/AFW6ZOyurHAeogDqm2FFUVv9mS
GdUfHZhBpeN3OotcI+wvzyKOmmG7NY3K0ocmrul3KdlrU2WtGYWHxCFBHO7gqmR9
9zZy/2y5zZHsxY85shN0OJOk7DOcg0aQzRydyM5wInJAsMVQaFXLzQ7+ktLBah7P
BP53gSVdwA7GZMPXkbcwDcysGpJiGSzi4tCcBD3/R684QO2LexT1I1dNXYHYveTX
tRq6GfRbY9XVCmveuwUMntUWesyuOPuoRw7AumwGMVbs3I3uXjp5Wa3M8fk0z409
Wrhezsvxg20/UbG7Z7dy7o68rrrPcO5wTx0kBStSkxs7MdeTwjgAJCspHNuNyN/U
Br6LqVX1KMKfEE7VrOQ5PSh83l1GZ/5Jm0gmOwNX2Afa+MbHmF2hNx40LGKwNfn9
h0LjJbSZh25uZg51NkyRVdeIt6obU0v83fCWfWccfmdxd6OHqjA=
=4gHa
-----END PGP SIGNATURE-----

--fxbd5ddvndryjaua--
