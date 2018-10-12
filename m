Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403331F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 09:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeJLRKf (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 13:10:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:36351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeJLRKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 13:10:35 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LskfZ-1fVP2045CD-012IVZ; Fri, 12
 Oct 2018 11:38:58 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LskfZ-1fVP2045CD-012IVZ; Fri, 12
 Oct 2018 11:38:58 +0200
Date:   Fri, 12 Oct 2018 11:38:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] fixup! builtin rebase: support `--gpg-sign` option
In-Reply-To: <xmqqzhvlgref.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810121138310.45@tvgsbejvaqbjf.bet>
References: <xmqqzhvlgref.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7mkjV397J7oYM3R1nK3QHbF8pbe0R2uU6W89eGYmhCf6OqHrpNc
 3FfZStBv1/DjfAcN9AMwI47RWSb+vR/gYT3vSHsj8XtAfQCF7WYFef0SpKCe6MmVrnW294i
 1oBdNjCmcld93wjq8EsXp2z9lJlZR9XYtyIIBNFZXayQ/d/dsrNQBmt4f4PqjScH3WjaHkx
 HMqIlAOSlmW9k8H+hZzwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rgQXpxHSrx8=:KU/3rDVhryKMtm//1HLS0/
 JlbYkeSG2aTW0CZTDT/kgcXtKSoVngqWyETKGIX1BZ5kk29143OrIdGaSZ3fRdfwWc3dZliNu
 xd/kw9eaKBXz0ffq1yJz9iKwbHokY8B3dA78ayincqQMM/nwgOeaR83waGP041yy6XmXXdj6b
 8WcRUpGde9BjfOjFrgPeCS+csP85+hCRsgdFsyILRAQNXa0elrnWaoQrl48LXoEgvjm6LoV2Q
 Ck+AxXisDjCF9ycFyh+PQamxlBGvyWKPCcWd4+yMOUfBf4sqAuI27jriZsmM0dcTa7bLHBgTC
 G+7w0hKl7T+/Tq4jsBWGL8ytmTyif58zloAlPm2eIG2DkjbwMqxGlriTp7dpGajDwLMQUFa0N
 J1mxpifMNjj/mNLDzbbhZ2Paq0bHr6lJGsLVIJYJVw/14e1gSAuTmKSz2Xj9q1GBj8JJYgrD4
 t0CHtxIvHhcOJKMKMZi//aD/rWf+9I4LMLOToZ4LxLeAvOSr/+j7+3yiyxpW1XgDOXqqrCU1a
 n8pzSNdKy+5PJFiZd3fNfB0fksi9mXVCxVR0NFLJMvgHG9G0509SgD+7Rj0MHENZI9VtMwTGI
 W+4Xkmp4Lo4gcQDtzjbb+h9iz3TrId3HV33KKhd66lCEXxXxkMG+Y06Yny7dyNLT32R0BtaIO
 8coHwsqkVGKHvV1EosQc1bvXFYsqWAxRa/SotB5YVsPE/10DFtf9hDQLvpPb1JBcKNFKZEd6Q
 VIgE1pqyRwBZF1TL8Lp7CJkUiw5dXSDRH1luT1pLi4CosggsUr+7pnblPNZdSHWTKyC6AGNVn
 4efvA+PTrGIPHK2O9upX3sojMC9eTqCel17fQ6brg99UMVV3Mo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Oct 2018, Junio C Hamano wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 27 Sep 2018 14:48:17 +0200
> 
> The `--gpg-sign` option takes an *optional* argument, not a mandatory
> one.
> 
> This was discovered as part of the investigation of
> https://github.com/git-for-windows/git/issues/1836.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
>  * I am sending this out as I want to mimize the number of
>    non-trivial changes that come into my tree without hitting the
>    list archive.

Thanks, *much* appreciated.

Ciao,
Dscho

> 
>  builtin/rebase.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index a28bfbd62f..43bc6f7915 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1030,8 +1030,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "autosquash", &options.autosquash,
>  			 N_("move commits that begin with "
>  			    "squash!/fixup! under -i")),
> -		OPT_STRING('S', "gpg-sign", &gpg_sign,
> -			   N_("gpg-sign?"), N_("GPG-sign commits")),
> +		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
> +			N_("GPG-sign commits"),
> +			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>  		OPT_STRING_LIST(0, "whitespace", &whitespace,
>  				N_("whitespace"), N_("passed to 'git apply'")),
>  		OPT_SET_INT('C', 0, &opt_c, N_("passed to 'git apply'"),
> -- 
> 2.19.1-328-g5a0cc8aca7
> 
> 
