Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A579C20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbdK0XQJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:16:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:60878 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbdK0XQI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:16:08 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7sF-1ewf3M0cCt-00oUNC; Tue, 28
 Nov 2017 00:16:03 +0100
Date:   Tue, 28 Nov 2017 00:16:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH 5/5] t3404: add test case for abbreviated commands
In-Reply-To: <20171127045514.25647-6-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711280007160.6482@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171127045514.25647-6-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:k+GH+vJYEK07FkyYvS4+b/lyF9FgTI2/tkZJawBfev8tH+nf6r3
 dSe1dFHrrc4Op2tO11oSdzzXgwq2UNrp3pG9KMgjvV72Wdusg17K1jjFqNR0psvfHe68pp6
 hAcZ/Md0qa5l76IihVwVbbl2K2EFYvzTqlXK/Bf+bCp93xPyzjnTYU+iR9/lu2OXjoFXnEC
 ly4iSKLjgAlyy6Qw26k+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xjui+Duruck=:19b7Ip0v6RyJb09tPsUw9F
 8TGRvv63MNCgVHAGNbS/LNrQMXfUUs6OIZgWyRxQm+7spuQsDB3Tjfs6jaZxbknd0YkS/Qh0+
 6lIQEoRzhnXwDy9vmWifPMGokIXRagTivS3CnbLVSTHiucAhnTG9NsEUCArq8kOSQpJNHDz4f
 cyLYh2HkMqvch9zAagqjbsH1cFU/H4hhgJG2ewJhk6LqjATzZ3AOX7GI0APnJi0K5VrNZ13xm
 C30/4iXEAzJ9RsjrV15/QCEqsmcUugzynaCq07yma5IA9On6fYhwQXYMvt1aMD0FohvWeng0Q
 kCbFpNnEcYG2UAPfV00yaIW5YzK/coa+5IYmEEj4qZe6vbv6CZ+dASELrncU5rAIli0uQR0aJ
 q8W6hQTWih12RhJPDOsQmpPANx7uN7jkMHLiIJ/fzoidmBdeEG5tWcRISS+D/XjfFecJQRHSl
 gbA80tdJ38vmQ4HbXtCl0tA5Dw170v5+t5wnYfiweu7WD1GEUW8L2uEpxKRSx+T0eoyQhk/yD
 OnmXKp1pGCb/RKcVpyTxV15Q7w93nLCCxnCiVzItL662StYHE35t3EA/Oh6sgE+obLcxaDWcK
 bukiQCR2jxoHfqPKcrDrpDzAnGtBpyrn36H2CbW6Kbvfrkv2IGsMR2VcSPbuG6jLaN7Y8tQl/
 qW5sldoED4EcdbTZwr/hq+N1M3zunjXLn69I3gfBRfpuGALgV5Yhwe7xg9bcW/9objKX7x9yi
 29HWzaK+lGkMAn6IzLC0ym9oEn4YA+B3L88Qrx6JqvFQ/hYmWj2R3Xa3N+4ExiWr4+rEZKGwt
 YAuNBVkiAIQ88Zk/8E5C2Mupce6PAWCxhVAHha+fxdOwzzO6X4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sun, 26 Nov 2017, Liam Beguin wrote:

> Make sure the todo list ends up using single-letter command
> abbreviations when the rebase.abbreviateCommands is enabled.
> This configuration options should not change anything else.

Makes sense. As to the diff:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 6a82d1ed876d..e460ebde3393 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1260,6 +1260,38 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_success 'prepare rebase.abbreviateCommands' '
> +	reset_rebase &&
> +	git checkout -b abbrevcmd master &&
> +	test_commit "first" file1.txt "first line" first &&
> +	test_commit "second" file1.txt "another line" second &&
> +	test_commit "fixup! first" file2.txt "first line again" first_fixup &&
> +	test_commit "squash! second" file1.txt "another line here" second_squash
> +'

In addition to Junio's suggestion to include the "expected" block in the
next test case, I would be in favor of combining all the new code in a
single test case.

Also, I think that the test_commit calls can be simplified to:

	test_commit first &&
	test_commit second &&
	test_commit "fixup! first" first A dummy1 &&
	test_commit "squash! second" second B dummy2 &&

> +cat >expected <<EOF &&
> +p $(git rev-list --abbrev-commit -1 first) first

Maybe $(git rev-parse --short HEAD~3)?

> +f $(git rev-list --abbrev-commit -1 first_fixup) fixup! first
> +x git show HEAD
> +p $(git rev-list --abbrev-commit -1 second) second
> +s $(git rev-list --abbrev-commit -1 second_squash) squash! second
> +x git show HEAD
> +EOF
> +
> +test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
> +	test_when_finished "
> +		git checkout master &&
> +		test_might_fail git branch -D abbrevcmd &&
> +		test_might_fail git rebase --abort
> +	" &&
> +	git checkout abbrevcmd &&
> +	set_cat_todo_editor &&
> +	test_config rebase.abbreviateCommands true &&
> +	test_must_fail git rebase -i --exec "git show HEAD" \
> +		--autosquash master >actual &&
> +	test_cmp expected actual
> +'

Otherwise, it looks good!

Thank you for staying on the ball and getting this patch series updated.

Ciao,
Dscho
