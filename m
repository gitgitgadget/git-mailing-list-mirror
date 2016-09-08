Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524E81F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 06:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbcIHGg4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 02:36:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49589 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbcIHGgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 02:36:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u886aRRs028774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 8 Sep 2016 08:36:27 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u886aRbW015987;
        Thu, 8 Sep 2016 08:36:28 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     vascomalmeida@sapo.pt, gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 5/5] unpack-trees: do not capitalize "working"
References: <20160908043453.6044-1-alexhenrie24@gmail.com>
Date:   Thu, 08 Sep 2016 08:36:27 +0200
In-Reply-To: <20160908043453.6044-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 7 Sep 2016 22:34:53 -0600")
Message-ID: <vpqa8fiaoes.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 08 Sep 2016 08:36:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u886aRRs028774
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1473921392.30056@Y13ugGUU0sfTE/SZxjX4+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> In English, only proper nouns are capitalized.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  unpack-trees.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 11c37fb..c87a90a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -123,9 +123,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
>  		_("Cannot update sparse checkout: the following entries are not up-to-date:\n%s");
>  	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
> -		_("The following Working tree files would be overwritten by sparse checkout update:\n%s");
> +		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
>  	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
> -		_("The following Working tree files would be removed by sparse checkout update:\n%s");
> +		_("The following working tree files would be removed by sparse checkout update:\n%s");

Probably a leftover from an old sentence starting with Working? In any
case, obviously correct too, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
