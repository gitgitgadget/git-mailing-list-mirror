Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC621F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeIECzO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:55:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:35931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIECzO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:55:14 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuJDv-1fmpQ02CaF-011gRq; Wed, 05
 Sep 2018 00:27:59 +0200
Date:   Wed, 5 Sep 2018 00:27:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re*: [PATCH 1/2] rebase -i --autosquash: demonstrate a problem
 skipping the last squash
In-Reply-To: <xmqqd0tt9j0s.fsf_-_@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1809050025480.71@tvgsbejvaqbjf.bet>
References: <pull.30.git.gitgitgadget@gmail.com> <8753c4e5fba5bb9cc42fdf438f4a69e702261a15.1535759099.git.gitgitgadget@gmail.com> <xmqqd0tt9j0s.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mTDGfElO+JmrSuvYT0VI1uvB5nMi7TkheLkg5PmFW4F/9LTyJzn
 YNpZaZCYAqpILWanObsaLVerlW/UbHpaglbbVBMS8862QgXjXtGePxryxghILuPB4UTzftW
 Ae+4+F8TCMUDWGsm6kvjz1UZj0wIgRXma07OL4/Tu1hSGx6pnlpMSxptekLxZ0V8Xr+TM/O
 3dhX2Shga6cfmrQcwT8Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jy59HwtdrMk=:6PdPEtmh/RW0ToGbANAtEl
 ZxT+Jmmq7nDi5swLxdNWFtujBHEP4X7g5EFrbeFt7X09NQCugr37gcZre5jAg2pLdy1/AOW2E
 AZmRly+a0fxxOyGzhfnQRE6NHdLOctvC9wW1BWmI4TobqU1l+lKMU1bQtLmW0gvV5F8SAGEgM
 tDQnbC9H9B5iFQJezNJYvXIqnDlqE0JdAn8+pCWr661c1UU6echNzI7iQqDZ4Vgz5G4BBzOXH
 4c2dL7Q0f1eYBB+IrRPDFc8OmQeGftnA8R2SeKmHgI1djdg1GtLluldU4oWrFk95O/r0zKMtQ
 g3wRCnt0C1jyZTmtBzTxurZetmaVg4q3SuHHxlrUi2rDeMqtT72PIyJ2cb3HEmaA2l4fUwamD
 8bkTWihFmY5Lq/W8wXZydGCCWh5QVNV2gDXbx8LC+n9HQNCCCEo4nX/1McvARprT9ckn6h887
 w9njUwalD6E9XIYWu1L43RxHk+BAFF7hjFgoOBrb4lhitq53D2tKzPnVfgVyCcO0OsZHdVrCK
 iD6p9DbGyCt4aJv/VT+rwXr2rOBvtaGbeyYphygw3KpBNPbttnPKNlahwH1pLsmp7kis6o1HK
 wJXzodr+Z9YwwTGqeJsqHUXMVG9tI5pDMoAA+60bv60L8tspsWZDnpT06LYdSZe7XfNkMB8A2
 p5qAnWoFk8YO/ksPZb4M1OzeyiaKfYKseAGhGaDfaQAh8sN9r+J5Sgv2gAfYV7tcGWI7VHsDy
 D1KOq7zbuKnqdQ/Sz8Lko5mo1rNiUuxsUR0OM3F/CIiInakcCmT1wEeJiwQhFiZ6hin10upV1
 IyGaVLx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 4 Sep 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > +	test_must_fail git -c core.editor="grep -q ^pick" \
> > +		rebase -ki --autosquash HEAD~4 &&
> 
> When merged to 'pu', this reveals that "git rebase" rewritten in C
> knows "--keep-empty" but not "-k".

I had already reported this:

https://public-inbox.org/git/nycvar.QRO.7.76.6.1808241803100.73@tvgsbejvaqbjf.bet/

> 
> I did a quick eyeballing between master:git-rebase.sh and
> pu:builtin/rebase.c and I think that it is the only one that is
> missed, but somebody may want to lend us a second set of eyes.
> 
> -- >8 --
> Subject: rebase: re-add forgotten -k that stands for --keep-empty
> 
> 630a70ea ("builtin rebase: support `keep-empty` option", 2018-08-08)
> forgot that the option comes with a short-and-sweet -k synonym.  Add
> it back.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Since this is not in `next` yet, let's do it the correct way. I had a
fixup! sitting in my wip-rebase branch all the time, I just needed to find
the time and motivation to figure out how to let GitGitGadget send a v2
when v1 was not sent via GitGitGadget.

Ciao,
Dscho

> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 87590047b3..b26f9c10cf 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -847,7 +847,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			 &options.allow_rerere_autoupdate,
>  			 N_("allow rerere to update index  with resolved "
>  			    "conflict")),
> -		OPT_BOOL(0, "keep-empty", &options.keep_empty,
> +		OPT_BOOL('k', "keep-empty", &options.keep_empty,
>  			 N_("preserve empty commits during rebase")),
>  		OPT_BOOL(0, "autosquash", &options.autosquash,
>  			 N_("move commits that begin with "
> 
> 
