Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148A420A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 12:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLKMbQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 07:31:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:44887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKMbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 07:31:16 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDzGN-1gfjsu0wUJ-00HNPa; Tue, 11
 Dec 2018 13:31:03 +0100
Date:   Tue, 11 Dec 2018 13:31:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH] run-command: report exec failure
In-Reply-To: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet>
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k0x0YHfoPOSUq/wiX0oH5tLIHTFkou396Mgy0p8XWqJOh1xkcr0
 D9aEdZhgkjNBZ82HyhaVMyHSvDGidewXKrA7U8Eo1ohmsC4c26rjlTa1IxjRqei+B6CkDDe
 Uq8WQoXsD6IKUHCv6wz8nOMvwRb33SW/wQOjlmaVU7RygvcmyS0cUEPC0SwDYTpTQt5Q/i4
 TyxWQkrAGSY5t8U93jIKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JKtxPCFb9k=:Pkw3N2RLDAVIhNMHpT1ue5
 UF5PZcnTIKGl3amxudcVsCKPpUgxpjRo/Q5XV7OeSdyajBuEEkN0DxwXkhE8TpRh7vvkZd4bL
 rPgnAGSnYYD1RX8tq1u3h2pmiOn8Vwep4zOmJM64uND9Drv3RzUqIf/VZZZdb9p1QbPf7wvaZ
 lw8slvTnuPeAe6KD9LgeUpTNNDuBjm1cnrz4ygYqJKas3rNkmn4ti5KS6QGdXP2BZY5qpy6pc
 TeIUZdzgA79MTxUi0QWkn9srICUxiicOsdAGVS10XwWXb9sL4Llmpss9knEbUtjwyx2/bF269
 s2B5r7oKtP1EcrYMgCcbjO6qByRfMkj3TqpTTYqrmnG9WiiLZiJ7kl9hymK2t+Uk0dAR9EFfQ
 LwUrfppfOTSL6agArD/4nrWDAG7HKqoLmrqzk5FAcXdnYjiMAyKYwzosBzq5jdTvvC8SJuwwU
 k4LpgEE32DZloDkIR04KdGHvMiITx0cjqtpNKzo/V0CQNAvY6BKNpL5BSYHEvAxiVitKgzL+L
 kHGDoDaHAsWhEMtVQMRSnp5Aj1Ox8d1oqebqQJyW6JhJGE5S7fjyEgvdryLZ8AmM16zgH7Aid
 YKEM88+Qd08GNNf9VF4JaGK5FSGMmXERODQ5H/ER3DjzT7pzdZsY1DSKzKeSN5rxvo1mv4+ff
 n7O0K74hLSBikuApwfRZ5YAbVUhCXBnINA0UoDULzEgGAZmnB6sc0r6cV1ZGoqIg/Dpi+ou4P
 2BMnTbI49i4ArghFKi6WeSZokgBcJUK8t3RwbwAHoBkwa/v7g1+bu7xT3MzZoS81bXeXMifCE
 w9ybOXFO3mrym3RmyRcrcgCKlUNZMYSPgIAv0dBUOU91zCbmYxRYEFMhcUQUMBT4DdqrO1QC5
 8yAKWf6nhTK88KUGSpTbzDAzMIYqc8ocdPYprP5QZAmEJbfZXqFfIAwnbHaBaifdc5sjmcMZU
 /mhPHucUTtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Dec 2018, Junio C Hamano wrote:

> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index cf932c8514..9c83d44d9c 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -13,11 +13,13 @@ cat >hello-script <<-EOF
>  EOF
>  
>  test_expect_success 'start_command reports ENOENT (slash)' '
> -	test-tool run-command start-command-ENOENT ./does-not-exist
> +	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
> +	test_i18ngrep "cannot run" err

This breaks on Windows (on Windows, the error message says "cannot spawn", see
https://dev.azure.com/git-for-windows/git/_build/results?buildId=26917):

-- snipsnap --
[...]
2018-12-11T11:13:59.9924183Z ++ grep 'cannot run' err
2018-12-11T11:14:00.0092569Z ++ echo 'error: '\''grep cannot run' 'err'\'' didn'\''t find a match in:'
2018-12-11T11:14:00.0099500Z error: 'grep cannot run err' didn't find a match in:
2018-12-11T11:14:00.0100663Z ++ test -s err
2018-12-11T11:14:00.0101058Z ++ cat err
2018-12-11T11:14:00.0239691Z error: cannot spawn ./does-not-exist: No such file or directory
2018-12-11T11:14:00.0254289Z ++ return 1
2018-12-11T11:14:00.0254489Z not ok 1 - start_command reports ENOENT (slash)
2018-12-11T11:14:00.0258844Z error: last command exited with $?=1
2018-12-11T11:14:00.0472195Z #	
2018-12-11T11:14:00.0473619Z #		test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
2018-12-11T11:14:00.0473874Z #		test_i18ngrep "cannot run" err
2018-12-11T11:14:00.0474098Z #	
