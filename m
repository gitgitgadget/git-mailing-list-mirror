Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDE220248
	for <e@80x24.org>; Wed, 27 Mar 2019 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfC0WCI (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 18:02:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:57591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0WCH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 18:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553724123;
        bh=67dl17XfOgMSHuYS6iweKEPS+kB9aZEa7XTRT0IiMhs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ku1MdauCIr9zkzffJkoW4lUGL7qJyG/lPQZm8EspxcvUtG40kNtMiDZHLvDEi1VD5
         Yg816ypQxPGR8d9Ncqhosu53CrqiSQuySLo9LWAe/hn0cekDunSUEfs6xNJt1jmx6t
         DrCofaylrAhDqlAPFt5V5F3RvYXOmIBbNvRzL5wQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkgAG-1gb2GV1uya-00aVK7; Wed, 27
 Mar 2019 23:02:03 +0100
Date:   Wed, 27 Mar 2019 23:02:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: batch fetching of missing blobs
In-Reply-To: <20190326220906.111879-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1903272300020.41@tvgsbejvaqbjf.bet>
References: <20190326220906.111879-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/fBcT8uwDUZvkjkrGbNtAkCErUh+r/UC3Y0HOulkFpicA2jFAYb
 4rM+G7s9fcTsgQihF1etJpPft/aj2Z+M6c0Y3cj8GtREa5IGguQ+OHVMM+lk8fKFAiSfzhm
 aaB6pxSzz+jbwrsIAv+J81BfeIO1IbvoulERLVosczMR+BTU5A9p/BxNMDhE0mCsvR1CXbh
 M53Jr6FMH8VQouAlq5h/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jNFBCh2kKwU=:t/21ZJgbuQux/S8p/CoeiW
 qpFRhvEPk5JAPwJCDd697RhkVqYY9Kwe69A2Slj43DWQKiCF4EwbieO1H5pdv5RkgGZfM/N3Q
 ptt/c/vJno/6lHmHgJmmisKHvdKmt9v1xMHAv2G4zyv+dG/ePZP47Mzo0d0hrdlWhfuF4W7vk
 s1vAuOTp2YE2Y2drcAZIKRTZDg+rAARGI6/8ktbcBYCCdSPymJhwPvRzgRitiCy3Z853QrBOn
 pgvwIWPgIm47oFlK5uErdbtRV/0QXS/mP7tbmnDyvjnG/wq9jJN5wdShUQhdPQzZe0yp2xInc
 05G05Nn6z91ET11OgQjPxCtBmCO1OhiNxDjhNz4QcpJD9foL52qjMtgQfwgO26fmVGi/X4O0r
 Q37WA1uwV5Dp9m+U0McqLU0T45cFsAYVtAuBID7NotlmQ/unFZki8S5BY++sR0tcyMWhZDoYw
 9z6NQ2ddAPLXdJjwfEOTEYOzI4cuVr+y/vaT+1KyT2oDPpZEuY50NTB54lpBnmlOm33BQv1+p
 Nkf70fouGzIdgVcYgiaxz7Kj8UzopBWHoeqqIVWysv6oAP/sHmeTvyTVvNXcDysC9LeBvorVd
 XwHOJreWI/I0QMAVjYADHrw7iJJOW4VeIeHfxufQ0w7moiafAFasL8QseOdTKxo9vz2awlZPQ
 GJtFMfLRgSlB9JeQYYP4XgPLTcwa2zuxAsdobbI1onYpEneNdNteYuAyDy3RUMYniRWbXbmu7
 Um8Umrf7jhvh9poUTcVRRE7iNY3uit06wX7TbL1QDdmXqkl//ESi9qNrCYENkOPUPtnLgtCHW
 Y3kY4K4lHxHB5FRgomb8US4hCwHtMvcyx5PDUuSp0BouOllE0ZclQhqe6vVNg4mNF5XnmHGew
 OOKp8+UfsV0Ek6EPPLcIEmj34Oti67J904JRNaRcWhwW31EqGbFQqEO+6Jlm86VogEelCEYqW
 WC3XDMldP1Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 26 Mar 2019, Jonathan Tan wrote:

> When running a command like "git show" or "git diff" in a partial clone,
> batch all missing blobs to be fetched as one request.
>
> This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
> blobs", 2017-12-08), but for another command.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Here's an improvement for those having partial clones.
>
> I couldn't find a good place to place the test (a place that checks how
> diff interfaces with the object store would be ideal), so I created a
> new one. Let me know if there's a better place to put it.

My 2c: that's fine.

> diff --git a/diff.c b/diff.c
> index ec5c095199..0e08d05b14 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -25,6 +25,7 @@
>  #include "packfile.h"
>  #include "parse-options.h"
>  #include "help.h"
> +#include "fetch-object.h"
>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -6067,6 +6068,32 @@ static void diff_flush_patch_all_file_pairs(struc=
t diff_options *o)
>  	if (o->color_moved)
>  		o->emitted_symbols =3D &esm;
>
> +	if (repository_format_partial_clone) {
> +		/*
> +		 * Prefetch the diff pairs that are about to be flushed.
> +		 */
> +		struct oid_array to_fetch =3D OID_ARRAY_INIT;
> +		int fetch_if_missing_store =3D fetch_if_missing;
> +
> +		fetch_if_missing =3D 0;
> +		for (i =3D 0; i < q->nr; i++) {
> +			struct diff_filepair *p =3D q->queue[i];
> +			if (!check_pair_status(p))
> +				continue;
> +			if (p->one && p->one->oid_valid &&
> +			    !has_object_file(&p->one->oid))
> +				oid_array_append(&to_fetch, &p->one->oid);
> +			if (p->two && p->two->oid_valid &&
> +			    !has_object_file(&p->two->oid))
> +				oid_array_append(&to_fetch, &p->two->oid);
> +		}
> +		if (to_fetch.nr)
> +			fetch_objects(repository_format_partial_clone,
> +				      to_fetch.oid, to_fetch.nr);
> +		fetch_if_missing =3D fetch_if_missing_store;

I am slightly uneasy about the fact that this is totally *not*
multi-thread safe. If only we had a way to pass the `fetch_if_missing`
information as a parameter to `has_object_file()`...

Do you think that would be easy to do? If so, I think now would be as fine
an opportunity as ever to introduce that.

Otherwise the patch looks just fine to me.

Thanks,
Dscho

> +		oid_array_clear(&to_fetch);
> +	}
> +
>  	for (i =3D 0; i < q->nr; i++) {
>  		struct diff_filepair *p =3D q->queue[i];
>  		if (check_pair_status(p))
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.=
sh
> new file mode 100755
> index 0000000000..38f03be114
> --- /dev/null
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +
> +test_description=3D'behavior of diff when reading objects in a partial =
clone'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git show batches blobs' '
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" clie=
nt &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client show HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count =3D 1 done_lines
> +'
> +
> +test_expect_success 'diff batches blobs' '
> +	rm -rf server client trace &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo c >server/c &&
> +	echo d >server/d &&
> +	git -C server add c d &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" clie=
nt &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count =3D 1 done_lines
> +'
> +
> +test_expect_success 'diff skips same-OID blobs' '
> +	rm -rf server client trace &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo another-a >server/a &&
> +	git -C server add a &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" clie=
nt &&
> +
> +	echo a | git hash-object --stdin >hash-old-a &&
> +	echo another-a | git hash-object --stdin >hash-new-a &&
> +	echo b | git hash-object --stdin >hash-b &&
> +
> +	# Ensure that only a and another-a are fetched.
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "want $(cat hash-old-a)" trace &&
> +	grep "want $(cat hash-new-a)" trace &&
> +	! grep "want $(cat hash-b)" trace
> +'
> +
> +test_done
> --
> 2.21.0.155.ge902e9bcae.dirty
>
>
