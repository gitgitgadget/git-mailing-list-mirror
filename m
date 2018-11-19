Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844A01F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeKSWwc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 17:52:32 -0500
Received: from mout.web.de ([212.227.17.12]:54091 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbeKSWwb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 17:52:31 -0500
Received: from macce.fritz.box ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6PP-1gK4691ISB-005LDD; Mon, 19
 Nov 2018 13:28:46 +0100
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive
 filesystems
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, git@jeffhostetler.com, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
References: <20180817161645.28249-1-pclouds@gmail.com>
 <20181119082015.77553-1-carenas@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
Date:   Mon, 19 Nov 2018 13:28:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181119082015.77553-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bvh2nGeSmuBPwWvzTZCwfv5p8L5ax9evd3IHt+uuuFbgeZEF8EE
 lFOwAgsDaLnCuqnTyFjI7VCDnfM9WHmKDZT54+mGM0ZevFYz2uevko1q8K8YPEOvKc/Wsup
 nHk6LmWTbQpX7wnnl7qhP/yYUmd47fqCihv/705KNmPTSMI+HYOLoW4jBVZw01ra24wNZ9V
 XQS8E5pEVQXRHC90JAfWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lCMfFqjBaQI=:NIAnNv/fIh1HojbpWhOsW6
 wTLDY0hKn8JNpeYR4Z7K64wtlxlbPBEGe8JygI+h2PsgVaXGgCWcliNNFoGTAzVJ50UGvpUMS
 RoHvJx+4zTIM71JeqLtw/0SoFlFy6rDiNCRwYQfQWyEC+Lto63LpUh0mvhf5GTka2j9IacrKl
 z+5HTzkVVWcAs4Q6BYIWZSElIMhvkifd4q7oaJw3U2/QV+68SgV/glcHIdBkswR5eGvpZh9aI
 VUiREO0dvBWjU7WldLQYIRMKidZvB+47EdFSyz1JYKYICZ7GRBob3RJlg+FDu9l84Hb7En999
 raN/bsgah4zINBjP8w8HPC/O4OSpGiC94DKAU2lpa2jVQaTLhPaw63fJmnAJhTTkC5ieE+u1g
 TxoZZDElONJCht/IhoL5MC6RWDz9pKFyv8vnEn7pvpQ+9S/32fJ+I9JyqU1kcpRQg9asitAZb
 TfCuhhmJhsh1MtQvBfzykCi76+al5ot1aq7PlJxn01hlp23NuaY+5YH78qxDkKl4J7Mz6FHFQ
 v+Jr6vn1owfhVUqG6AgQ89GoeB9oo6GOMKhq2HiJGR6/Yd+Nw4M8g0b187Vcg4r0KmiUGyfq3
 3mEuqo9QjP8snth9OBmX3wWnDfEJY5GOw29/7Mah2xkjlsmSfBekZ8Sn5rLP3IZO9r3O0WTDD
 kw6+wR4KY6ony9tDDMktJveYRdMOLS/NXfeqTrh69wXbVfuT5dKo0ynU7T0n5SuNf+rrf8c8D
 H47wJyAKWYL+ME1M8Eygfuk+/SQotehl5I+1ouLxJbM2CusgiJa+X8iT9RUH702d1K/MGP74M
 UeClTpsvFfnSUbUI6rJtOoQds/GMeciZp0yfnqzG73B1yyyL8J+n19pzmu9VCt6atLlivrNLZ
 coJ03Jpg7XhgW7RvE5QhZShIHlLflXhgZZEp7Lxus1561rPlNd9zlM+FgSUA8l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-11-19 09:20, Carlo Marcelo Arenas Belón wrote:
> While I don't have an HFS+ volume to test, I suspect this patch should be
> needed for both, even if I have to say thay even the broken output was
> better than the current state.
> 
> Travis seems to be using a case sensitive filesystem so wouldn't catch this.
> 
> Was windows/cygwin tested?
> 
> Carlo
> -- >8 --
> Subject: [PATCH] entry: fix t5061 on macOS
> 
> b878579ae7 ("clone: report duplicate entries on case-insensitive filesystems",
> 2018-08-17) was tested on Linux with an excemption for Windows that needs
> to be expanded for macOS (using APFS), which then would show :
> 
> $ git clone git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> warning: the following paths have collided (e.g. case-sensitive paths
> on a case-insensitive filesystem) and only one from the same
> colliding group is in the working tree:
> 
>   'man2/_Exit.2'
>   'man2/_exit.2'
>   'man3/NAN.3'
>   'man3/nan.3'
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  entry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/entry.c b/entry.c
> index 5d136c5d55..3845f570f7 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -404,7 +404,7 @@ static void mark_colliding_entries(const struct checkout *state,
>  {
>  	int i, trust_ino = check_stat;
>  
> -#if defined(GIT_WINDOWS_NATIVE)
> +#if defined(GIT_WINDOWS_NATIVE) || defined(__APPLE__)
>  	trust_ino = 0;
>  #endif
>  
> 

Sorry,
but I can't reproduce your problem here.

Did you test it on Mac ?
If I run t5601 on a case sensitive files system
(Mac, mounted NFS, exported from Linux)
I get:
ok 99 # skip colliding file detection (missing CASE_INSENSITIVE_FS of
!MINGW,!CYGWIN,CASE_INSENSITIVE_FS)

And if I run it on a case-insensitive HFS+,
I get
ok 99 - colliding file detection

So what exactly are you trying to fix ?

