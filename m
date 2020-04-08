Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A16C2BB54
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 02:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207CD20748
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 02:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oy/EGyue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDHCNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:13:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbgDHCNh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Apr 2020 22:13:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0D0C96042C;
        Wed,  8 Apr 2020 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586312016;
        bh=IzmXmhFjd2eAN0d8M5vzVNnmqJLJrc0mQ7bD/Awjl94=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oy/EGyueoXQIgNJY+Knx6Ld0YZ4PxZpUoH1R6uBZnl+yoZtge8CWhfR24sBM7gaiH
         /97SfFsM4FnnF94vO5O+T78I+AxzQ5knIOr3DJHy2HMKW2k936ZLJYj3SYJuCp6eMp
         0k7sixe3CS+lbGanIOSC1lANX+ChORJjN0IPU906kSHanVU7o7ak/BGRTWIx8yCZS/
         6w9PScvfrsfBXwHYfrIY+1Enq8zKdm5u1Q3wsEfTNMvTc7b+yjsAAjX/adUEzUFR37
         WdgbhIP4MG4XaymS2Wj4w1HMSbyrquAw6O06uaa22SzmgQbOzIS5ZKb+ANtrNk6qDS
         0KlsiDeqdWtQ6agnkJZYByCRcaUO0yEDJg8jCfUIJ9jxb6rIow5bpAKM883MYY9ad/
         rOgRjqDfPI6mSGpX7f1iYLEhshrr5y0wFMqQgCmmbKMjrAsjbHFD4ztPZVKPDe8SwY
         orIVF1Bv1pn/QNJm4SGlDZlLFfpwdJE9kpKKLUUFFcDFTbnkFuL
Date:   Wed, 8 Apr 2020 02:13:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
Message-ID: <20200408021330.GB6549@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-08 at 01:22:03, Derrick Stolee via GitGitGadget wrote:
> The --simplify-merges option was introduced to remove these extra
> merge commits. By noticing that the rewritten parents are reachable
> from their first parents, those edges can be simplified away. Finally,
> the commits now look like single-parent commits that are TREESAME to
> their "only" parent. Thus, they are removed and this issue does not
> cause issues anymore. However, this also ends up removing the commit
> M from the history view! Even worse, the --simplify-merges option
> requires walking the entire history before returning a single result.

I was not aware --simplify-merges required walking the entire history.
Now I know why my alias using it performs so poorly on $HUGE_REPOSITORY
with thousands of extra backmerges at $DAYJOB.

Thanks for teaching me something.

> Many Git users are using Git alongside a Git service that provides
> code storage alongside a code review tool commonly called "Pull
> Requests" or "Merge Requests" against a target branch.  When these
> requests are accepted and merged, they typically create a merge
> commit whose first parent is the previous branch tip and the second
> parent is the tip of the topic branch used for the request. This
> presents a valuable order to the parents, but also makes that merge
> commit slightly special. Users may want to see not only which
> commits changed a file, but which pull requests merged those commits
> into their branch. In the previous example, this would mean the
> users want to see the merge commit "M" in addition to the single-
> parent commit "C".

I should not hesitate to point out that this history is also true of the
Git Project's repository, although of course the merges may be of less
interest here.

> In some sense, users are asking for the "first" merge commit to
> bring in the change to their branch. As long as the parent order is
> consistent, this can be handled with the following rule:
>=20
>   Include a merge commit if it is not TREESAME to its first
>   parent, but is TREESAME to a later parent.
>=20
> I call such merge commits "diversions" because they divert the
> history walk away from the first-parent history. As such, this
> change adds the "--include-diversions" option to rev-list and log.
> To test these options, extend the standard test example to include
> a merge commit that is not TREESAME to its first parent. It is
> surprising that that option was not already in the example, as it
> is instructive.
>=20
> In particular, this extension demonstrates a common issue with file
> history simplification. When a user resolves a merge conflict using
> "-Xours" or otherwise ignoring one side of the conflict, they create
> a TREESAME edge that probably should not be TREESAME. This leads
> users to become frustrated and complain that "my change disappeared!"
> In my experience, showing them history with --full-history and
> --simplify-merges quickly reveals the problematic merge. As mentioned,
> this option is expensive to compute. The --include-diversions option
> _might_ show the merge commit (usually titled "resolving conflicts")
> more quickly. Of course, this depends on the user having the correct
> parent order, which is backwards when using "git pull".

I can't comment on the contents of the patch, since I'm really not at
all familiar with the revision machinery, but I do think this change is a
good idea.  I see this as a very common use case, and I think this
commit message explains the rationale well.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     Add a new history mode
>=20
>     This --include-diversions option could use a better name.

As we all know, I'm terrible at naming things, so I have no suggestions
here.  I'm happy with the name as it stands, but am of course open to
other ideas.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-=
options.txt
> index bfd02ade991..0c878be94a9 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -342,6 +342,12 @@ Default mode::
>  	branches if the end result is the same (i.e. merging branches
>  	with the same content)
>=20
> +--include-diversions::
> +	Include all commits from the default mode, but also any merge
> +	commits that are not TREESAME to the first parent but are
> +	TREESAME to a later parent. This mode is helpful for showing
> +	the merge commits that "first introduced" a change to a branch.

I wasn't sure if this use of "TREESAME" would be confusing, but it looks
like we already use it extensively throughout the documentation, so it's
probably fine.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXo0zSgAKCRB8DEliiIei
gXSmAPsHTJ8Qjp21P9/PS0UXMdpM6hAt0aAfHtPZok22GpTQ3gEA3u6SSKTetMc1
SmjSEZT/4bmbgTHF3u2Qp8xM5gVWAQY=
=hxOO
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
