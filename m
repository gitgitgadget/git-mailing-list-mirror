Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FEDB1F461
	for <e@80x24.org>; Wed, 15 May 2019 08:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEOIqi (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:46:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:54003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfEOIqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557909995;
        bh=QE8+iyvQgzOsHFr+wezadUdKHqUYH9tdEM1/dahzhJo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ys9D9ez9BN7wP8RDvlBPKF2mBjZsSAfbsIKMbXDjrbS/tnxdt8CN/RsSXeDBAqRqH
         gAEP5UpD8GWaV8ULZndJPzP60FLt5KllOkdpz6WGtENLlaP1REf5jNnnaaH2vfid7T
         Pl8MHg4SkARrb1BVcnCPj6CCQjLgfJObInBsgYa8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Md31i-1h8cBN1ZiM-00I9wW; Wed, 15
 May 2019 10:46:35 +0200
Date:   Wed, 15 May 2019 10:46:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
In-Reply-To: <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1905151040240.44@tvgsbejvaqbjf.bet>
References: <cover.1557868134.git.jonathantanmy@google.com> <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HSPVl9Cp5o2dMVTJ3pvD5EBzGX7qujIIUjlly6flFR/ESw9PxB4
 FCFO1+ecFM5JZ1bqiEaCOI+IUDYFB95+HqUeyS7hTm5KtEvY3MBh+s+NhMtihSGx5W4Vi3H
 DcIVc5NjoNjNpfRoQu8DvStO9KBirkqfsHo+esbMuJaE5X6pAOPF4iFvgiYYI+NdKdi2aog
 VUwlqqErsbt1pEVBc1uBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PRG1ZUCD8As=:vfUxLGppLsJitqx56YdRWo
 q/DP2aMUOnKHUQ0EHH2TF8/6V66RCpZsrcxW/pv7YMxEok/NB6SzAP+icuSl4wOFXDjI75uzs
 40OFHeHzIZZ01UjIlSNhK9N3zcNTBR8AG0iVORbWdWveZJePS8v/i+WG4h4epsJU8X67+7TZd
 iOzBKwrq+29CHUXL2YQ982RVsFbNKRb/ndxNwtluoBi/l//8pAirto10xfJSFx4pfY1CVuryR
 OvuQkbdBeK6k6lUi7dvMNJhftHktOZwdsn+l/OUVFWIT50sz3FVlIcyGLh0i8Qm2kF1tEpcDZ
 Qe0gQ1R97M2roJ/1v4b56HPHIEPhbyUimJyTy2LbfgeAFwnjqnUOLrnnM3Ue3nSm8QUSZiJGe
 xcQSjeaBsdnkLTP2ml6Rmdq3VJ85VsovDdttOWR9apPAu0FlhsQq9+M2i4FkF94KkmoSOCdYs
 8BNU/YcddksMoXDjhinYBsnqcQLw+ZSFQ7KL57DX4Xz0g6nvJCQcdt5xq77ZpmGoWbt7jz2o1
 Czc76tQiG/ubImMikCbhag3NFAZbU8tW/Xg2eTQconGmKdyyUMDb7sr4VM5ZPVA8XEOrhb0Dj
 lJ957NXHrBy0hJ0A7Xh20YDNmtN/aPVODvj+kFb2LPJ+o/PQSIhHoTudCL8Swy39r53KLzL21
 sjMdGx2eiDYhlQLuOBgadBhCH3zKH83n3CKzcAuy9DD3MAFbIpRpUlo6rMQFT0LciismW9ccn
 3n/23JnfrRmEgn2nB+8F9QYvD4iOJpYWrjdq2obypSVI+ZiBrA7E52NlbDgdgpKd29amK3Psa
 so2LSavMejRi4P6tcYB99Tb1fzQbWMD84FlNXlLJnIGkzM7D5Rt+DAZLHIcj++exWBBrps9j9
 YVoLMfikKiDVoE0ogovhZL9YFXzVVQZw70ce7/5WpUMoYS0Ftvnl1dWuGfYS2PXOOY8syKA2g
 6dZJn8wl1qQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 14 May 2019, Jonathan Tan wrote:

> When fetching, the client sends "have" commit IDs indicating that the
> server does not need to send any object referenced by those commits,
> reducing network I/O. When the client is a partial clone, the client
> still sends "have"s in this way, even if it does not have every object
> referenced by a commit it sent as "have".
>
> If a server omits such an object, it is fine: the client could lazily
> fetch that object before this fetch, and it can still do so after.
>
> The issue is when the server sends a thin pack containing an object that
> is a REF_DELTA against such a missing object: index-pack fails to fix
> the thin pack. When support for lazily fetching missing objects was
> added in 8b4c0103a9 ("sha1_file: support lazily fetching missing
> objects", 2017-12-08), support in index-pack was turned off in the
> belief that it accesses the repo only to do hash collision checks.
> However, this is not true: it also needs to access the repo to resolve
> REF_DELTA bases.
>
> Support for lazy fetching should still generally be turned off in
> index-pack because it is used as part of the lazy fetching process
> itself (if not, infinite loops may occur), but we do need to fetch the
> REF_DELTA bases. (When fetching REF_DELTA bases, it is unlikely that
> those are REF_DELTA themselves, because we do not send "have" when
> making such fetches.)
>
> To resolve this, prefetch all missing REF_DELTA bases before attempting
> to resolve them. This both ensures that all bases are attempted to be
> fetched, and ensures that we make only one request per index-pack
> invocation, and not one request per missing object.

Hmm. I wonder whether this can lead to *really* undesirable behavior, e.g.
with deep delta chains. The client would possibly have to fetch the
REF_DELTA object, but that would also be delivered in a thin pack with
*another* REF_DELTA object, and the same over and over again, with plenty
of round trips that kill performance really well.

Wouldn't it make more sense to introduce a new term like `promised`
(instead of `have`)? Both client and server will have to know about this,
and it would be a new capability, of course, but that way the server could
know that it has to send the entire delta chain.

Of course, this would be quite a bit more involved than the current patch
:-(

Ciao,
Dscho

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c     | 26 +++++++++++++++--
>  t/t5616-partial-clone.sh | 61 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index ccf4eb7e9b..0d55f73b0b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -14,6 +14,7 @@
>  #include "thread-utils.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "fetch-object.h"
>
>  static const char index_pack_usage[] =3D
>  "git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>] [--ver=
ify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
> @@ -1351,6 +1352,25 @@ static void fix_unresolved_deltas(struct hashfile=
 *f)
>  		sorted_by_pos[i] =3D &ref_deltas[i];
>  	QSORT(sorted_by_pos, nr_ref_deltas, delta_pos_compare);
>
> +	if (repository_format_partial_clone) {
> +		/*
> +		 * Prefetch the delta bases.
> +		 */
> +		struct oid_array to_fetch =3D OID_ARRAY_INIT;
> +		for (i =3D 0; i < nr_ref_deltas; i++) {
> +			struct ref_delta_entry *d =3D sorted_by_pos[i];
> +			if (!oid_object_info_extended(the_repository, &d->oid,
> +						      NULL,
> +						      OBJECT_INFO_FOR_PREFETCH))
> +				continue;
> +			oid_array_append(&to_fetch, &d->oid);
> +		}
> +		if (to_fetch.nr)
> +			fetch_objects(repository_format_partial_clone,
> +				      to_fetch.oid, to_fetch.nr);
> +		oid_array_clear(&to_fetch);
> +	}
> +
>  	for (i =3D 0; i < nr_ref_deltas; i++) {
>  		struct ref_delta_entry *d =3D sorted_by_pos[i];
>  		enum object_type type;
> @@ -1650,8 +1670,10 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
>  	int report_end_of_input =3D 0;
>
>  	/*
> -	 * index-pack never needs to fetch missing objects, since it only
> -	 * accesses the repo to do hash collision checks
> +	 * index-pack never needs to fetch missing objects except when
> +	 * REF_DELTA bases are missing (which are explicitly handled). It only
> +	 * accesses the repo to do hash collision checks and to check which
> +	 * REF_DELTA bases need to be fetched.
>  	 */
>  	fetch_if_missing =3D 0;
>
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 7cc0c71556..f1baf83502 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -339,4 +339,65 @@ test_expect_success 'when partial cloning, tolerate=
 server not sending target of
>  	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
>  '
>
> +test_expect_success 'tolerate server sending REF_DELTA against missing =
promisor objects' '
> +	SERVER=3D"$HTTPD_DOCUMENT_ROOT_PATH/server" &&
> +	rm -rf "$SERVER" repo &&
> +	test_create_repo "$SERVER" &&
> +	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
> +	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
> +
> +	# Create a commit with a blob to be used as a delta base.
> +	for i in $(test_seq 10)
> +	do
> +		echo "this is a line" >>"$SERVER/foo.txt"
> +	done &&
> +	git -C "$SERVER" add foo.txt &&
> +	git -C "$SERVER" commit -m bar &&
> +	git -C "$SERVER" rev-parse HEAD:foo.txt >deltabase &&
> +
> +	git -c protocol.version=3D2 clone --no-checkout \
> +		--filter=3Dblob:none $HTTPD_URL/one_time_sed/server repo &&
> +
> +	# Sanity check to ensure that the client does not have that blob.
> +	git -C repo rev-list --objects --exclude-promisor-objects \
> +		-- $(cat deltabase) >objlist &&
> +	test_line_count =3D 0 objlist &&
> +
> +	# Another commit. This commit will be fetched by the client.
> +	echo "abcdefghijklmnopqrstuvwxyz" >>"$SERVER/foo.txt" &&
> +	git -C "$SERVER" add foo.txt &&
> +	git -C "$SERVER" commit -m baz &&
> +
> +	# Pack a thin pack containing, among other things, HEAD:foo.txt
> +	# delta-ed against HEAD^:foo.txt.
> +	printf "%s\n--not\n%s\n" \
> +		$(git -C "$SERVER" rev-parse HEAD) \
> +		$(git -C "$SERVER" rev-parse HEAD^) |
> +		git -C "$SERVER" pack-objects --thin --stdout >thin.pack &&
> +
> +	# Ensure that the pack contains one delta against HEAD^:foo.txt. Since
> +	# the delta contains at least 26 novel characters, the size cannot be
> +	# contained in 4 bits, so the object header will take up 2 bytes. The
> +	# most significant nybble of the first byte is 0b1111 (0b1 to indicate
> +	# that the header continues, and 0b111 to indicate REF_DELTA), followe=
d
> +	# by any 3 nybbles, then the OID of the delta base.
> +	git -C "$SERVER" rev-parse HEAD^:foo.txt >deltabase &&
> +	printf "f.,..%s" $(intersperse "," <deltabase) >want &&
> +	hex_unpack <thin.pack | intersperse "," >have &&
> +	grep $(cat want) have &&
> +
> +	replace_packfile thin.pack &&
> +
> +	# Use protocol v2 because the sed command looks for the "packfile"
> +	# section header.
> +	test_config -C "$SERVER" protocol.version 2 &&
> +
> +	# Fetch the thin pack and ensure that index-pack is able to handle the
> +	# REF_DELTA object with a missing promisor delta base.
> +	git -C repo -c protocol.version=3D2 fetch &&
> +
> +	# Ensure that the one-time-sed script was used.
> +	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
> +'
> +
>  test_done
> --
> 2.21.0.1020.gf2820cf01a-goog
>
>
