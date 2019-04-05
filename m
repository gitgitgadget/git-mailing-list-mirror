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
	by dcvr.yhbt.net (Postfix) with ESMTP id E484820248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDEUQM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:16:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:39151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDEUQM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 16:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554495369;
        bh=G+JSLWIbyBmZSRxWgsx9fM/VAKUcN0ohnTAmV+rjY/0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QhBk4yp7TR+uzI0mqMypEeFcsR5761kQ3I0a9FH5QKeFEv2LsSX/hUMAvh/uOn0/f
         a+7rKNbMXENwA4ZPRDkR92EQKyqOiZSai33YuZwfpwU6w0Znq7pHnhxNASGV2yONjD
         q5xctxppDd76ua9UGKA2E8Kjbc0WcaDnaXIvyJAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSY2q-1hKEW43KsO-00Rcfy; Fri, 05
 Apr 2019 22:16:08 +0200
Date:   Fri, 5 Apr 2019 22:16:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] fixup! diff: batch fetching of missing blobs
In-Reply-To: <20190405170934.20441-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1904052214280.41@tvgsbejvaqbjf.bet>
References: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com> <20190405170934.20441-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qdY/KduAaapa0ptZB9Ah380vi7NDbjb09mZf4MPa4N9UccbaFqT
 6bpkc0CAwGVF4B334knd0AvshMdZSRPR8vpkpuNKcgcHaw3cvcA3T+Q4agBZGTe7hfYimzs
 9IVdH98PPTjcL8eL2wxVcGoMfmp+1XCh4JWaH1/N7KrlVldfzaCAOqYHMsbFfGdmqKmt411
 rLhTv8SmCQ0lbDzI7rQNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4prFadERBig=:T08/yLYt8BmdGJUtIq7cAi
 ShS+hGppxaZMSX+XLs1vuU7cyqFEx6OpAkw/4ECaeYFsYBkAG4WQ/E1SKJcGl9q8X2XD+99Hn
 inh8NIPg9HhmwMNODu3ekM8ZRSdzHrmmYAjt6MQm1N412RgpfowkkZyGRoFLxnGC65gkIptk3
 fYnHWUsujdP+b/eQjgm3QSrquhY0zTJXWdPJuzoQAenCOS9IQ2qYuWXRGZafKTQq270FoZ/jM
 KDrwrjr8wV8Y14c35DIhrA3mwxcEkGPUntykXaGpztb1ppWawdexyOQUy+uKKIFvccWgaxf8X
 UHo6JFR50tHOwoHz4aHTQ35IH4+aGEgMgC6RdKi7pC3XAoLgB3/9O6M2T3o7lrcwL/JXdxe+Z
 6MOj0yNsxVQwwqmmbZNWAmgLSsXfVNtYvdEeAd75Ggm9cSfAgF0INuwmOmHjcrZodX6tbq70s
 tqpr8RjS/mWy2IKqopCTbNICkPwuK2W8ECiBl+hodq3ZV6+JHYvra8HNWabs7qhMng/9f1Kfw
 I+OVjhzvLhpQUE1wIG3+JB8SxKJkKKt/d4bv9cadEODtHx3qIHamBP7UaaW2qpH4ztWFR49WG
 M+Ahv1NuQCIxbJbB/diN52QBA6w1bgez2QghuYcwpiVfcJJNg4V+TfUne6bw48YiWAYSIkn3i
 WsF6oUc2uJ0ofLh7Kq0Ms5Q8aJ6tvmBJu1uR4TQin+e45g2bu9BrIrwzmoONwGSa+brxMinM1
 X6AfY5LNmEJev352s6yNQLAKRzESuRMCqTo7NvOSW17Mw73zuCVSkFRNMwIl9hsn6MSfWAMxx
 GUaop2W9K6Hewg1WfQSZc5GEoxE58o3b5wPvETTuyyxHU8tCAiUEIhyX/8KtbTRuLs91a75Xh
 q+6aZfLM4ikxBObQAO5rTlHxuS4SytM74yq8KoAWGVFHsRCJLs/QwWIqFDZxO2AwzSYEna51J
 KIQ8+DTUyAA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 5 Apr 2019, Jonathan Tan wrote:

> This is a fixup on the tip of jt/batch-fetch-blobs-in-diff (571debe1d9).
>
> I don't know if Junio has already merged this branch to next (he marked
> this as "Will merge to 'next'" in the "What's Cooking" email, but when I
> fetched, it hasn't been merged yet). If he has, we can use this commit
> message:
>
> diff: propagate options->repo to add_if_missing
>
> Avoid a usage of the_repository by propagating the configured repository
> to add_if_missing(). Also, prefetch only if the repository being diffed
> is the_repository (because we do not support lazy fetching for any other
> repository anyway).

True, and the introduction of `has_promisor_remotes()` should probably
help that, by introducing a parameter of type `struct repository *r`.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

The patch and the commit message look good!

Thanks,
Dscho

> diff --git a/diff.c b/diff.c
> index 1eccefb4ef..811afbdfb1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6367,18 +6367,19 @@ void diffcore_fix_diff_index(void)
>  	QSORT(q->queue, q->nr, diffnamecmp);
>  }
>
> -static void add_if_missing(struct oid_array *to_fetch,
> +static void add_if_missing(struct oid_array *to_fetch, struct repositor=
y *r,
>  			   const struct diff_filespec *filespec)
>  {
>  	if (filespec && filespec->oid_valid &&
> -	    oid_object_info_extended(the_repository, &filespec->oid, NULL,
> +	    oid_object_info_extended(r, &filespec->oid, NULL,
>  				     OBJECT_INFO_FOR_PREFETCH))
>  		oid_array_append(to_fetch, &filespec->oid);
>  }
>
>  void diffcore_std(struct diff_options *options)
>  {
> -	if (repository_format_partial_clone) {
> +	if (options->repo =3D=3D the_repository &&
> +	    repository_format_partial_clone) {
>  		/*
>  		 * Prefetch the diff pairs that are about to be flushed.
>  		 */
> @@ -6388,8 +6389,8 @@ void diffcore_std(struct diff_options *options)
>
>  		for (i =3D 0; i < q->nr; i++) {
>  			struct diff_filepair *p =3D q->queue[i];
> -			add_if_missing(&to_fetch, p->one);
> -			add_if_missing(&to_fetch, p->two);
> +			add_if_missing(&to_fetch, options->repo, p->one);
> +			add_if_missing(&to_fetch, options->repo, p->two);
>  		}
>  		if (to_fetch.nr)
>  			/*
> --
> 2.21.0.392.gf8f6787159e-goog
>
>
