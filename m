Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC73A1F42D
	for <e@80x24.org>; Mon, 28 May 2018 12:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939006AbeE1M46 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 08:56:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:42145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932996AbeE1M4y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 08:56:54 -0400
Received: from MININT-8E55E86.fareast.corp.microsoft.com ([37.201.195.106]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MAQXq-1fTIGE2SS2-00Bbpj; Mon, 28 May 2018 14:56:52 +0200
Date:   Mon, 28 May 2018 14:56:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Orgad Shaneh <orgads@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] git-rebase--interactive: fix copy-paste mistake
In-Reply-To: <CAGHpTBLGmApTGsjeP2d93CWH=OWBXmbPdRrGxaobFRcSjUiuYw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805281455210.82@tvgsbejvaqbjf.bet>
References: <CAGHpTBLGmApTGsjeP2d93CWH=OWBXmbPdRrGxaobFRcSjUiuYw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tyRg526HleBTkw4pvGXeA/ldVIidiCJ9Rk7kDeODp73Ga3vpQOk
 hdonOZ5SelUcObl1Yy5RRjOI6UYhUl6LKOdYy06H2Pcdxm00dTIlfR89A0QY2EuiQfgGrdI
 YBYQRxpRRvLnMEU7PPzOxHEi1gQkKcUanpXlEgyO16aeBWcUJmnDX1gYHgpmj3Mrzp7npcM
 17Gm1dhFeFPCkRW2eUv2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YwyG62l1x2E=:tF9IsQ6sUfaMb5OTVsWOtv
 +fFecpG/39o1Rb88VqYefmu8zrYV+39+Nmju3Ply5MUZ8kZNPcrC0HlZAjfQJdxOGm84ZbD1d
 IwUcpzrhhZe7rCd+429Lqg5pM6vKibUt32eHpMGzSkUTMT8lLiu3+l7kzNh5EMvFrE0N8voZN
 LtsVmmdqDRgSZp7dcyrAGAIp/jG+K2LkVYP0JEH/fTOhTQOAEmlaXSZSwQ7F9WxBzHi8oW1zW
 8LGpImkq6Rh3CFCpnlfHntyLxSPxpM2Ry2jcjRtvc4NTCiTFjiifYquC7tGDpWwOWlmXjusnW
 cSEfD0TXELcK9fNC6K242z0pwfsiE6jomM0qfW+1f4V6EpFlKd/Tz5gQFrzQ9HByIiNnjvJDh
 HjIkcSijxuz7voY19Dxtvc5or0Q9Q/nLXajUiGd0O4xfh7pLPDiTatLhv050Ixt71of+vRGfQ
 BExvdG4wr/jGwnEAlNztbhP4mBaJuJpmI314FzrcX9Iw14ekaBOP5SJBedm8fJAeGXpzsh5sD
 55UHnO6YO5fnv25AX6XWH9HqBoqo8pgMHgBlM4Rf009RwlwimoumNONZtXIx7TruxDygtJSVV
 PIxcHwE/iPHNqYU4Tb1Sx9rmX0eBlsNzyAUIpohFinmk4bpX5kdpq4w080lnHjhxyS4PH0jDi
 96L2vmW+xrL/32F98p/nDnccEOQYk5S9esOuM2TF6rqLsNu+BtCsEa7xuJ9JLMjAMjxIk02fu
 YfN0DflyTFOyhoC3Y94ZQHRQbOEHr3t/pQqCTWi6NWQ5IopbSEzIGheeNXseqp6QtiXxUT70j
 mdWN4hx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Sun, 27 May 2018, Orgad Shaneh wrote:

> exec argument is a command, not a commit.
> 
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>   git-rebase--interactive.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index cbf44f8648..85a72b933e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -160,7 +160,7 @@ r, reword <commit> = use commit, but edit the commit
> message
>   e, edit <commit> = use commit, but stop for amending
>   s, squash <commit> = use commit, but meld into previous commit
>   f, fixup <commit> = like \"squash\", but discard this commit's log message
> -x, exec <commit> = run command (the rest of the line) using shell
> +x, exec <command> = run command (the rest of the line) using shell

Apart from the white-space (which I *think* might make `git apply` barf on
this diff), this looks obviously correct to me.

To make it easier for Junio, maybe you can provide a link to a branch in a
public repository, ready to be fetched?

>   d, drop <commit> = remove commit
>   l, label <label> = label current HEAD with a name
>   t, reset <label> = reset HEAD to a label
> -- 
> 2.17.0.windows.1

Thank you for cleaning up my mess,
Dscho
