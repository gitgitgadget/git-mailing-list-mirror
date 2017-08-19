Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F8A1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdHSQyA (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 12:54:00 -0400
Received: from mout.web.de ([212.227.15.3]:60727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbdHSQx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 12:53:59 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Md4V8-1e1C7E3y5q-00ICuy; Sat, 19
 Aug 2017 18:53:31 +0200
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
To:     git@vger.kernel.org
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
 <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
Date:   Sat, 19 Aug 2017 18:53:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:s9+646KWxfF0XRJXVs7eSPYGRYiNbU0OR9dLEwaJDWxZqbkiVzG
 Yh24ZUByRifqK5KnWpEgexcfRQZSloCOUOsnOXU0JHIVQY8T+48/kBsBIGCRfviXltP4Vc3
 Rlpi8MklWkTPcYt7n0GQyFQxHdY9mIfQWq/q/WIhtz4wgX3RTFuWpmYNejkrzmL6hgsIqpJ
 F4d2ZMb2kgL7Ie5XQTMiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qTCAYpPZF+8=:sMHErqqmQbPp14EftVxRvK
 HQirTo6K/fsAnsmbDnMPYfHgm5Lnzd95w2YvF3fhpyS7UqNf/D4xpc8smvjVKa76FitZWeH0f
 qOQaLmbhRIEbiV1LSZzVsffdXAVXdeHkw38D5eER3k1ID6ew6ug3f+6tJmCezR8DowbFh3Mj/
 2DjoUwzFK2GHnSFJ5T27LtNU+HsYnXFOVJmi+Q1L6a1+TO7++WqgR6Fdu5rVkSsfbGNJi94WM
 kx8Ekh/XsNh0d3WeEN5xORpa3xyI2rf4QXmKWnzzO+GluPzRCHjT/xKqCyNs4HvrQhp0vxj4s
 Wy84Wlfff/aJ4gfW0YVg9F9Ep8Gh2I7ZfTMaGFeYVhMaP2pXEtugrCoHPFUTv++2mkBtXW2oZ
 +fbSfTSkZjplVNDM4UkUe+Yyc5UEDDtiITMpy0ZV4o34Aescn4CvSsywWHnmaWIm6HL46is0K
 5w5NIUfpeBR1luSaGQE/QF78vuABYJpz0xmshw/EQKsbtK2uGM6qe9W7YfbYQXTcAipvfbOKM
 gSNW7Ivd1uxdeUw7IaahU7sKYblBBUcO4As7Tqd0pZcLv8cosYPzzm3T83/zwt+M6Z6h+SOHh
 6JBwAL3X4SwTvBdy3YuM/D+AKOePayL/ldAEkWSX1wQhGf7vxnXFvPTvyAMFdpnYtBGpqQKPX
 GeUEZH/IQipDk8dH+aUfk3hmxmgkn9Bx8pvUAF5gscfjmCqPfm7BR3ZLAbOmWIdpBsvGlgEtF
 QUTKCxZaE/ygvp8e1yMyKc00jJ7XD6NrZNr9gUdf1HWOV6ZWzBMhonBxnWf6Fr/yEltHpcdU7
 z/UT5Z3kj52SrdR3lGtMY6jaYdBpyymzWx/Nrwm3tkirKrxOQA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.08.2017 um 07:33 schrieb René Scharfe:
> When read_tree_recursive() encounters a directory excluded by a pathspec
> then it enters it anyway because it might contain included entries.  It
> calls the callback function before it is able to decide if the directory
> is actually needed.
> 
> For that reason git archive adds directories to a queue and writes
> entries for them only when it encounters the first child item -- but
> only if pathspecs with wildcards are used.  Do the same for literal
> pathspecs as well, as the reasoning above applies to them, too.  This
> prevents git archive from writing entries for excluded directories.

This breaks the test "archive empty subtree with no pathspec" in t5004 by
omitting the empty directory from the archive.  Sorry for missing that!

This is kind of a bonus patch, so please discard it for now; the first
three are OK IMHO.

A better version of this patch would at least update t5004 as well, but
there might be a better way.

> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>   archive.c               | 2 +-
>   t/t5001-archive-attr.sh | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/archive.c b/archive.c
> index 1ab8d3a1d7..174c0555b6 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -123,7 +123,7 @@ static int check_attr_export_subst(const struct attr_check *check)
>   
>   static int should_queue_directories(const struct archiver_args *args)
>   {
> -	return args->pathspec.has_wildcard;
> +	return args->pathspec.nr;
>   }
>   
>   static int write_archive_entry(const unsigned char *sha1, const char *base,
> diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
> index 897f6f06d5..e9aa97117a 100755
> --- a/t/t5001-archive-attr.sh
> +++ b/t/t5001-archive-attr.sh
> @@ -73,7 +73,7 @@ test_expect_missing	archive-pathspec/ignored-by-tree
>   test_expect_missing	archive-pathspec/ignored-by-tree.d
>   test_expect_missing	archive-pathspec/ignored-by-tree.d/file
>   test_expect_exists	archive-pathspec/ignored-by-worktree
> -test_expect_missing	archive-pathspec/excluded-by-pathspec.d failure
> +test_expect_missing	archive-pathspec/excluded-by-pathspec.d
>   test_expect_missing	archive-pathspec/excluded-by-pathspec.d/file
>   
>   test_expect_success 'git archive with wildcard pathspec' '
> 
