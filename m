Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B156120756
	for <e@80x24.org>; Mon, 16 Jan 2017 11:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdAPL3T (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 06:29:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:61949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdAPL3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 06:29:18 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV30j-1bvIt62Lc5-00YUGs; Mon, 16
 Jan 2017 12:28:53 +0100
Date:   Mon, 16 Jan 2017 12:28:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
In-Reply-To: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701161226090.3469@virtualbox>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QjuVnujiUxk6/oVtYONbSpL0U0ubdz5wqWxdVVokk3GCfDoYfQm
 r+5RZtcHuG9Kgj7myOejJEfTN8H2WJYRSc9omu0cbrTbGRiRye4cghsi/yMl88AT5NqL1Yw
 nH5FMnWg34gpmUlHZbwgDV4cyRr0zlLqlJPA37ExZzXDehH5W6c3ctTVi8DiZJjLUvbWR58
 /Q8V3btRWN4ADQfEI1YLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5aLETMahgZw=:mICs1LKtVJxQotubVZ8e3Q
 sDsKQfwav11VT8irE4TD//H0t3cPH+KMHpnvAERSbddd8IuVzadu8ff0V82kMOJ8X80wZHltd
 OiwhCF9N1J/X3Zd/M0j5ySM0Zdab50+ucRa0czs9Nkd7SdhzGOe4cl/2YSppENt/XuCQKqp3p
 b4dzylRnvuoWTg1HDId7GUm495vtPfgOSC7Kjk/tEQy+Q9n7HWF01jvrc+nU0qCyrE4uC4na4
 YxWrCxiADLO0XDuW7ask6qcW/Ofel3nSGi4qrblaU4kJC2D9XQyfTPnOV/47vw3jRUekXAaCs
 FyI0VKlXYLipXPeeelx6k2EU1Sa9IB5fQ5gVEjNMFcF9l4VOte32hXpZBNq+XsSO+pcBQbFsW
 /49apVt/0qv43tG7y/mmkzhsmnFx7F9l342CAr+mb8IKak3USO/vE70dAUw1vUsv1lfPXtGXp
 nvC6wQdd2pf8j7p8o2c7tkw2fK1rb12aCSQE0zgtQk/IhqMF5Ly36oORpgrz3hDzlKjsyTi/+
 l2ouK4UR4SZqMBnejMSppeMKjbHUPvaS9dhpZS5sz8MLHdYLAanE5YWdgnYF2G+x7zOFi7+Ib
 xUdQKmvTELpgipXSxqx1pL+HF8d/4ex5cnxrVAE+jnbG0s4Q+Lwy4mADALQuBKSyZd1u1AD3Z
 /coWcYblYoXu1YZf4wswPKeWrM0OXzpCmt0xyF0K9yRY5nnMQT7z2vGUjkjCUHiq2OY8U1TFH
 pdAE2suLMd45n+vcVsK3gW8Zt9TmmsVCg0xFkYK//0iiv1XSegRv+jaODTwiotU51zmgx5n8Y
 ak0sd1Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 15 Jan 2017, Junio C Hamano wrote:

> * js/prepare-sequencer-more (2017-01-09) 38 commits

I think that it adds confusion rather than value to specifically use a
different branch name than I indicated in my submission, unless there is a
really good reason to do so (which I fail to see here).

>  - sequencer (rebase -i): write out the final message
>  - sequencer (rebase -i): write the progress into files
>  - sequencer (rebase -i): show the progress
>  - sequencer (rebase -i): suggest --edit-todo upon unknown command
>  - sequencer (rebase -i): show only failed cherry-picks' output
>  - sequencer (rebase -i): show only failed `git commit`'s output
>  - sequencer: use run_command() directly
>  - sequencer: make reading author-script more elegant
>  - sequencer (rebase -i): differentiate between comments and 'noop'
>  - sequencer (rebase -i): implement the 'drop' command
>  - sequencer (rebase -i): allow rescheduling commands
>  - sequencer (rebase -i): respect strategy/strategy_opts settings
>  - sequencer (rebase -i): respect the rebase.autostash setting
>  - sequencer (rebase -i): run the post-rewrite hook, if needed
>  - sequencer (rebase -i): record interrupted commits in rewritten, too
>  - sequencer (rebase -i): copy commit notes at end
>  - sequencer (rebase -i): set the reflog message consistently
>  - sequencer (rebase -i): refactor setting the reflog message
>  - sequencer (rebase -i): allow fast-forwarding for edit/reword
>  - sequencer (rebase -i): implement the 'reword' command
>  - sequencer (rebase -i): leave a patch upon error
>  - sequencer (rebase -i): update refs after a successful rebase
>  - sequencer (rebase -i): the todo can be empty when continuing
>  - sequencer (rebase -i): skip some revert/cherry-pick specific code path
>  - sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
>  - sequencer (rebase -i): allow continuing with staged changes
>  - sequencer (rebase -i): write an author-script file
>  - sequencer (rebase -i): implement the short commands
>  - sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
>  - sequencer (rebase -i): write the 'done' file
>  - sequencer (rebase -i): learn about the 'verbose' mode
>  - sequencer (rebase -i): implement the 'exec' command
>  - sequencer (rebase -i): implement the 'edit' command
>  - sequencer (rebase -i): implement the 'noop' command
>  - sequencer: support a new action: 'interactive rebase'
>  - sequencer: use a helper to find the commit message
>  - sequencer: move "else" keyword onto the same line as preceding brace
>  - sequencer: avoid unnecessary curly braces
> 
>  The sequencer has further been extended in preparation to act as a
>  back-end for "rebase -i".
> 
>  Waiting for review comments to be addressed.

The only outstanding review comments I know about are your objection to
the name of the read_env_script() function (which I shot down as bogus),
and the rather real bug fix I sent out as a fixup! which you may want to
squash in (in the alternative, I can mailbomb v4 of the entire sequencer-i
patch series, that is your choice).

Ciao,
Johannes
