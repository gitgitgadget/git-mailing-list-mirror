Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EA720248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfCMWpu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:45:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:49041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfCMWpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:45:50 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Ee8-1gkKMg04JU-00tBtE; Wed, 13
 Mar 2019 23:45:42 +0100
Date:   Wed, 13 Mar 2019 23:45:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] cherry-pick --continue: remember options
In-Reply-To: <20190313182615.7351-3-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet>
References: <20190313182615.7351-1-phillip.wood123@gmail.com> <20190313182615.7351-3-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ntjiy4w73j7zCLypE25gjtg3wTxNERIqxVYTOso2tH9o6tNxI6a
 QV+2wOCuKrdv3NgdLADFI0yRZSYzm3f8qScGpmPzKw8Jm9HWL0R5nnpwL/kd3ND2PdTvsUG
 I9aShXjjXxEohL9yy2gIwo6RnDA/LV8L2R0sAcz3oa42Wz2+imjmRN2SZgbm2dsb3wV6bxz
 n4cC80UEkmSD5liipykKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6YgzpnFFSxk=:k83vRV+sbF6HVz5Jb2U+d1
 UWUjmZWW3V+EhzhWlK3WS0Ud5VoZORlmrzRDCUOwlyPdpfBG6R15u13XtyFKp0rCh3P4mEUGw
 P6zycfre7b7Tw2gbDcygB4XjpZs/OiiWrpB/0qKwJibhL0PtXSawJRiWsDzxutFDf1LOeIQOJ
 7Pg5ehBNyLL02Z1F75RCLn4eYLRjbyqz8J01LoD+//ihqEjF3QRDacoqTmXMdmrl5ngTEDYv+
 6vvOuqWGHwOYogn6kEDUISbz5DCEHPtoHia8zoAkF94Sz3GuTyueyPE3kzP0gSLTl5277EqOY
 w72fqe9caRFAf90W8Nxnc4jFfb2wEil8dlyyfoaGzajySA9JWivZDIAZU1ad8h9YdAfcWXICf
 I9ojdHIzt86SIe3rDQ+eAO8g52g1Cg7N1a6w3a/Zg0bd5D87dU0DhlIxMRQg0ZTmMxtzVbvNC
 S/wcVIAN4/9lMiHLp/of1We/zX3oH8ehgaWvTQy0lTK5nAA9C35uNKx5j3/jxyTL4Z/aXCPuM
 2QHOveMOolBMtKpFlbT5KQO6xaLA23rtgERTkkoOE4yma4i2g3EsjiNT4xvPYAi8clPeGiz5q
 6BZztcF9TWpCJ3B7eEaMHGOhZ0wjvfsCeos5l1tAmlc5Cu08JoG3Pn9a+itvOUcTL6tMZChLm
 c5ywts9fAsA8ACpXlW3gFQkd+Ai5sRecODDHHlWt5hHuFrhNkrEXeHPtFVWSltY490gwQM87C
 fPUXB/1eSMk/6XLcNF00p116kDjx3zdjA8sXT+j1YHcMx8ZGc/CJLT7vSgC/CGOOe+S7wEJrX
 uUnIFU01mgcsczqxxOPk74K+1xDEL+7ZhOofnKISzPBNCqv1hFLxly2yNYtZ4cfW0SKPeNn+a
 HFdAJNEkLD8FNr7Ti2GQ09dntwrHe54BqY8by4lnGP54s5ezNb8Unij+w4AJbr/L9IHfdLVUo
 NgSYToqfYPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 13 Mar 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Remember --allow-empty, --allow-empty-message and
> --keep-redundant-commits when cherry-pick stops for a conflict
> resolution.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

This whole patch series makes sense to me.

And it is especially nice that you make it easy to verify that there is a
bug in the first place, by separating the concern of demonstrating it from
the concern to fix it.

Thanks,
Dscho

> ---
>  sequencer.c                     | 18 ++++++++++++++++++
>  t/t3507-cherry-pick-conflict.sh |  4 ++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 5e19b22f8f..1ad51aa498 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2307,6 +2307,15 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.edit"))
>  		opts->edit = git_config_bool_or_int(key, value, &error_flag);
> +	else if (!strcmp(key, "options.allow-empty"))
> +		opts->allow_empty =
> +			git_config_bool_or_int(key, value, &error_flag);
> +	else if (!strcmp(key, "options.allow-empty-message"))
> +		opts->allow_empty_message =
> +			git_config_bool_or_int(key, value, &error_flag);
> +	else if (!strcmp(key, "options.keep-redundant-commits"))
> +		opts->keep_redundant_commits =
> +			git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.signoff"))
>  		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.record-origin"))
> @@ -2705,6 +2714,15 @@ static int save_opts(struct replay_opts *opts)
>  	if (opts->edit)
>  		res |= git_config_set_in_file_gently(opts_file,
>  					"options.edit", "true");
> +	if (opts->allow_empty)
> +		res |= git_config_set_in_file_gently(opts_file,
> +					"options.allow-empty", "true");
> +	if (opts->allow_empty_message)
> +		res |= git_config_set_in_file_gently(opts_file,
> +				"options.allow-empty-message", "true");
> +	if (opts->keep_redundant_commits)
> +		res |= git_config_set_in_file_gently(opts_file,
> +				"options.keep-redundant-commits", "true");
>  	if (opts->signoff)
>  		res |= git_config_set_in_file_gently(opts_file,
>  					"options.signoff", "true");
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 79e994cffa..1ef8e9d534 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -410,7 +410,7 @@ test_expect_success 'cherry-pick preserves sparse-checkout' '
>  	test_i18ngrep ! "Changes not staged for commit:" actual
>  '
>  
> -test_expect_failure 'cherry-pick --continue remembers --keep-redundant-commits' '
> +test_expect_success 'cherry-pick --continue remembers --keep-redundant-commits' '
>  	test_when_finished "git cherry-pick --abort || :" &&
>  	pristine_detach initial &&
>  	test_must_fail git cherry-pick --keep-redundant-commits picked redundant &&
> @@ -419,7 +419,7 @@ test_expect_failure 'cherry-pick --continue remembers --keep-redundant-commits'
>  	git cherry-pick --continue
>  '
>  
> -test_expect_failure 'cherry-pick --continue remembers --allow-empty and --allow-empty-message' '
> +test_expect_success 'cherry-pick --continue remembers --allow-empty and --allow-empty-message' '
>  	test_when_finished "git cherry-pick --abort || :" &&
>  	pristine_detach initial &&
>  	test_must_fail git cherry-pick --allow-empty --allow-empty-message \
> -- 
> 2.21.0
> 
> 
