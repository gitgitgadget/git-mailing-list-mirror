Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE35A1FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 10:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeCOK2O (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 06:28:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:60107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbeCOK2N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 06:28:13 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ln8gj-1eQwqK34m5-00hMBO; Thu, 15
 Mar 2018 11:28:09 +0100
Date:   Thu, 15 Mar 2018 11:28:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] rebase --root -k: fix when root commit is empty
In-Reply-To: <20180314111127.14217-2-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803151118490.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180314111127.14217-1-phillip.wood@talktalk.net> <20180314111127.14217-2-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:alwowedleYKh2zycvocqAMM+PmNpvzDQDueQ9CmBnPmsywNpHJp
 k0auZcjh+vmd3JgGPhK+WbNGcsYh8RP/gBUS6f0JxuDTm9lOJtqn7o46zvRwSoVNlqsAHdW
 NJJdrzpRpy1fnr00usgHh+ZqBxSRaLF1OvCcaGMlXNhn7DJ19xLDJ7S+bPHsK8/BmmMp37Y
 +muYNS3dZs+q128MjAapw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:arUBiSDmUkM=:1UKLXJbEzfgIkbOLHkYBlt
 3pz3cUyfmbwEkTU2OeJn9Ob9f4WPu50VkrG3dTwstKxEcbfKzHzJa0Of5+hrMLh8X56UiWxam
 Ag2s9zpdGCYSDbni1WkWLXFvHGaq6aE9FoL+K13zXAT+ON5a0Tk3PdKDWKNLVU8lcnU3+ooKT
 6QirMz2oopsf4tEWrAuW2TcxMYXbkKXMyxOq8o9O/t/Nd0pJ3R/9AVFzlRxciabU3fvXEOCRb
 oLuwkApym0Ux01Pn1Hmmx61uDlRvV/mFSSL/apDiovCt7epnmeBI+2qrrWBTq6tPDC0RdTU6B
 RG01GU8dXOA5Gy3qR6G+4wJ7f1FIZLeVAIkpOT1Fn8VjV2J4gLiW5ApXHSnUd4hLj0x7LlkSo
 bBvd617AVD7uN+cddlAMBXgzYDcVbdOInwczPFfj2UC6CRLVgyk34rLDg2Gf2MoIbOM5CUANg
 Vdlmxqemz/Cz+4ftmGpdzHZOPwMjE/bfYKNsxlXHUz6J6aYtE51HyQ3UNoUziDl4jSyu8QSCr
 ZXksV4jp/kO9ma6O5Qi5GzAfHN4VzaKz2E43NTkjabw/M3TR93LB9yNrq05OejpWIzjNZBsJx
 wHGrPrWyq9/SIrysxSSLsuNgjfMWvPEtiIQ2GVmHsVmRvT1+h986rdrL0sNaU+VAIASu6kEg9
 1nZfwIwcOYqlOjw/079pzogzdWiQ0pTTApMeStLk0M1sYtgcS0XQXuIqeAgZfPe4kYjLu9V7Q
 JcRIquWfsTDANPvHinvnVGqVF/2AsYRP4x+QobfkOyGgQBe2w4GOvnGPZfcuvkgG6QewxJXnG
 UXmnLJDBS8/Iwdv0OvlIGqVBXasZDFv8GomzIDjATXeM+O9QEw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 14 Mar 2018, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When the root commit was empty it was being pruned by the
> --cherry-pick option passed to rev-parse. This is because when --onto
> is omitted rebase creates an empty commit (which it later amends) for
> the new root commit.

This will have ramifications on the upcoming patches on top of my
--recreate-merges patches that introduce support for running -i --root
directly through the sequencer. But from your patch, it looks as if things
should Just Work.

FWIW the patch in question is currently here (will be rebased frequently):
https://github.com/dscho/git/commit/147e8f3c2bf5f07708d76efd9da51cbd0eb5958c

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 4ea54fc1c4..3ad74fc57c 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -894,7 +894,12 @@ then
>  	revisions=$upstream...$orig_head
>  	shortrevisions=$shortupstream..$shorthead
>  else
> -	revisions=$onto...$orig_head
> +	if test -n "$squash_onto"
> +	then
> +		revisions=$orig_head
> +	else
> +		revisions=$onto...$orig_head
> +	fi

Before anybody else can post the suggestion: this could be written more
compactly as

	revisions=${squash_onto:+$onto...}$orig_head

As it would not only be more compact, but also a lot less readable, I
would *also* like to point out that I prefer your version.

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 40301756be..30b8eaf489 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -61,6 +61,7 @@ $(gettext 'Resolve all conflicts manually, mark them as resolved with
>  You can instead skip this commit: run "git rebase --skip".
>  To abort and get back to the state before "git rebase", run "git rebase --abort".')
>  "
> +squash_onto=
>  unset onto
>  unset restrict_revision
>  cmd=

This is a bug fix. Maybe we can pull it out into its own commit? Commit
message would be something like this:

	rebase --root: stop assuming that squash_onto is unset

	When the user set the environment variable `squash_onto`, the
	`rebase` command would erroneously assume that the user passed the
	option `--root`.

> diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
> index 2ff7f534e3..90ca6636d5 100755
> --- a/t/t3428-rebase-signoff.sh
> +++ b/t/t3428-rebase-signoff.sh
> @@ -59,7 +59,7 @@ test_expect_success 'rebase --exec --signoff adds a sign-off line' '
>  	test_cmp expected-signed actual
>  '
>  
> -test_expect_failure 'rebase --root --signoff adds a sign-off line' '
> +test_expect_success 'rebase --root --signoff adds a sign-off line' '
>  	git commit --amend -m "first" &&
>  	git rebase --root --keep-empty --signoff &&
>  	git cat-file commit HEAD^ | sed -e "1,/^\$/d" >actual &&

Hehe... I guess this fixes that test case for a surprising reason: it is
not that all of a sudden, rebase --root respects --signoff. The reason it
works now is that an "empty" root commit is now rebased correctly.

The test case is simple enough to pass my "can a regression be debugged
easily, even by somebody else than the original author" test, so I do not
mind at all lumping the two issues (--root respects --signoff, and --root
respects empty root commits) into one test case, as that will make the
test suite run faster.

Please note that I do not feel all that strongly about my suggested
modifications to pull out changes from 1/2 and 2/2 into their own
respective commits. If you have the time, and if you feel that there is
merit to my suggestions, please do it. Otherwise, please feel free not to
do it ;-)

So: ACK from me.

Ciao,
Dscho
