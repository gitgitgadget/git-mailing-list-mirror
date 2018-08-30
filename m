Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E411F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeH3SD4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 14:03:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:41511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbeH3SD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 14:03:56 -0400
Received: from MININT-6BKU6QN.europe.corp.microsoft.com ([167.220.196.38]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MVayZ-1gQKW02lqx-00YvSV; Thu, 30 Aug 2018 16:01:35 +0200
Date:   Thu, 30 Aug 2018 16:01:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: es/format-patch-{inter,range}diff, was Re: What's cooking in git.git
 (Aug 2018, #06; Wed, 29)
In-Reply-To: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808301548560.71@tvgsbejvaqbjf.bet>
References: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dD0vgex7MIuu8boMMxlbx2calIOVyazsIRfuWteTLtYtfwUvtn+
 uYA812Ha1e1A3DlFXTn7tKuF20ouhuic94poCIEmUGIWxJmYdC3Jy9Qax3MvsLX7FjhoUTI
 4ss7WsTQvw/LCjUSNn0H0oXQmPKzHW5soxEmHAQtgeIVeWLons4gjlDxUL/trODXQvLCuR9
 CpjVYn3vIqGBOd/VmNkPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SEbnEFH5BRw=:sIu5ZjTOXvMk88P2p+1NpZ
 kwG38RnWZDVc1YcKqvRObajvlmWH4pQBYU92ALepZ/yHzm2nbgFuE0m2VKRHtWB8MbgazyBn4
 au6NPrsrhDjATEAvay91n8KeX/BbAjYiD2CFm6/NrVc047TgK2XifDFpyL355kYVZ3ygrPFqS
 4+YbGGGwp1LsN2MEhBsQJ1H7gDD4n5aeq1jfsLlrxGyrfW7eyM25AIk5e9Hge21Y9hOXXag+B
 v1j9cCmoy0D5HDXrrYHMw/RzyhE5Vms5FIMXFeRA7SU6qqfQy39zFlkNJPvm1oQLtOsGc1Lko
 epRBP19aIBbk+FwLbKzs8eUXDV3o/RMikQH5cG+8G4t8Cf8BbVFjfc8pRrfduNqFtZlAWDeQS
 6IvHmrHzqZNhuZW07DQAJZgXuTWSR66VhIG4LE339YEb+7eQRkLmW3jRKgzuk+k7EFANyCMuH
 CMD9F/UENmXtMb9d+oOw8ItnXcsXptZ+PFbRtq0R8LjB/s8A91A2D8uvfhN1hfg5o2MygwsjI
 rXt5zbatYg7xYrT7CLTvivbI9y+uxVVkFqmAFbUlEkJ9oBxy9kvoGEcgL+XITCCgigVgh0bQp
 U69+I6d42Tjz1TQz9tpkyv2w6m+81EEcrMEXs0cmrwXnCZThlYwEE+DKWDQO4gvraFuYNjKL6
 3cYuLxcCvkI1oP2zfSMgMHlcMpOUZXYhzWqgF4t6M89Mvw5yO238U0lYkiQtv2+PR+vqIDPau
 4C2ZMEhU5Gd9X4OjTVaChHaqDqpUWcS1WmX9KOUOQjNfy4n68IIli2pPjYWLrr349vnd94LuJ
 7ZZHjhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Aug 2018, Junio C Hamano wrote:

> * es/format-patch-interdiff (2018-07-23) 6 commits
>  - format-patch: allow --interdiff to apply to a lone-patch
>  - log-tree: show_log: make commentary block delimiting reusable
>  - interdiff: teach show_interdiff() to indent interdiff
>  - format-patch: teach --interdiff to respect -v/--reroll-count
>  - format-patch: add --interdiff option to embed diff in cover letter
>  - format-patch: allow additional generated content in make_cover_letter()
>  (this branch is used by es/format-patch-rangediff.)
> 
>  "git format-patch" learned a new "--interdiff" option to explain
>  the difference between this version and the previous atttempt in
>  the cover letter (or after the tree-dashes as a comment).
> 
>  What's the doneness of this one?
>  cf. <CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com>

I looked over the changes online, and I think they are good.

The only slightly iffy thing I found was using the function parameter
`rerolled` as printf-style format in
https://github.com/gitgitgadget/git/compare/es/format-patch-interdiff~6...es/format-patch-interdiff#diff-71d4a6bddc3e479f9abf11900878a0b2R1430:

	static const char *diff_title(struct strbuf *sb, int reroll_count,
			       const char *generic, const char *rerolled)
	{
		if (reroll_count <= 0)
			strbuf_addstr(sb, generic);
		else /* RFC may be v0, so allow -v1 to diff against v0 */
			strbuf_addf(sb, rerolled, reroll_count - 1);
		return sb->buf;
	}

I guess that's okay, though. (I would have done it differently, but that
would have meant playing sentence lego with the "Interdiff against v%d:"
string.)

> * es/format-patch-rangediff (2018-08-14) 10 commits
>  - format-patch: allow --range-diff to apply to a lone-patch
>  - format-patch: add --creation-factor tweak for --range-diff
>  - format-patch: teach --range-diff to respect -v/--reroll-count
>  - format-patch: extend --range-diff to accept revision range
>  - format-patch: add --range-diff option to embed diff in cover letter
>  - range-diff: relieve callers of low-level configuration burden
>  - range-diff: publish default creation factor
>  - range-diff: respect diff_option.file rather than assuming 'stdout'
>  - Merge branch 'es/format-patch-interdiff' into es/format-patch-rangediff
>  - Merge branch 'js/range-diff' into es/format-patch-rangediff
>  (this branch uses es/format-patch-interdiff.)
> 
>  "git format-patch" learned a new "--range-diff" option to explain
>  the difference between this version and the previous atttempt in
>  the cover letter (or after the tree-dashes as a comment).
> 
>  What's the doneness of this one?

I just had a look at the diff online, and I think this is ready for next.

Personally, I would have put the infer_range_diff_ranges() function
(https://github.com/gitgitgadget/git/compare/es/format-patch-rangediff~8...es/format-patch-rangediff#diff-71d4a6bddc3e479f9abf11900878a0b2R1448)
into `range-diff.c`, but it is too minor a thing to ask for a new patch
series iteration.

It also looks slightly murky to me that `show_range_diff()` is now using
a copy of the `diffopts` (see
https://github.com/gitgitgadget/git/compare/es/format-patch-rangediff~8...es/format-patch-rangediff#diff-ab6f5eca48b8e84edf999acbe3fe7553R435),
but I have no idea how to do this in a more elegant manner, either.

In short: from my point of view, both topics are ready for `next`.

Ciao,
Dscho
