Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E231F463
	for <e@80x24.org>; Fri, 27 Sep 2019 12:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfI0MVS (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 08:21:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:53509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0MVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 08:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569586874;
        bh=DPm6Xm6eOaDpdSN4o6Q8RPJ7Usf9476WtJHRZuJNJt4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FkmUx812VwKoA5HtuzByTLuj4Z6Hvzl1P4j8OzPFYmNlUMtVgB5IbOrI3N7B70MYA
         xWFTmioSVrUC1hoEi4layEP/0+5IFI+exUwRb96mtqH2EGA3MVJDZSKZ86wmAC6YvK
         5uAFrNO/ELN68KrWpxcuoLJl6IyHGisO7kTMvkUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1i7VUO0tH0-0170iw; Fri, 27
 Sep 2019 14:21:14 +0200
Date:   Fri, 27 Sep 2019 14:21:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alex Henrie <alexhenrie24@gmail.com>
cc:     git@vger.kernel.org, dstolee@microsoft.com, stolee@gmail.com
Subject: Re: [PATCH v2] commit-graph: remove a duplicate assignment
In-Reply-To: <20190927021952.364646-1-alexhenrie24@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909271418170.15067@tvgsbejvaqbjf.bet>
References: <20190927021952.364646-1-alexhenrie24@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Nd7+MDX8Ywr8kEbC9SNvQsUULhmCklaNdHBYLcirCnZT6As1pXZ
 0C8sK39t/82UxJHT9WAa2JF/QlLYF7WnmzOc9YSlZVzAe2R4kgDB91yZeFfRXSivKSTOoSj
 tuOaoHBrAOsy+FH3MicCLB8dm3xE0JPo9nEFaiudUDtwjAe7NlY9MzYA8ObDwktLE2P7ack
 hO3CIwJ+Cv/sB+Vbz1PwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7x5lsXH/sM=:k0UwLCPYZt2MTIddP+72b8
 wk7KPXdJUeO0rfV/4WLlc8YcI9nsavi1D7X9RMKZpBSANdXio1zTyDU5J+yg4DxuE4o6DLEkr
 EdoelkFDNJsJ79c33oJCLILCXyYQSwPVuTCGmGxwbQtNirFE8WmgGT9+UOA1Qs+cGW3Y4elvb
 r7s/o8eddgP5fpTS68xdyjBXSO08mlqoHhuTSCjAvKIEoXIEKwTe0kPfk1uGtlvdYh+5Xlfxs
 xOvaVtFSUd6DrETNZwG4qR82eQUfNFlDig8ElogZ/IkTDvHVwidQNnsqECpdn12c7rZvpA+mZ
 ZALeoqjxosO1Me0x/hvint2RoO+x+FQYoy4WqwYhC5joF10tV1HDldGlmgEe/cv38T7Yy1BJu
 0gizmvuJFQ+fmWovGiD8IVaHyodMHdZwe96eNQhKYRMLQ5LWzzV12vwT3ZUimA/6DlJ6PEawQ
 iZvTDKO/dEVnOFpqNq25Uc8JFgqSi+09sdDgVMVSqx2JlaIqlziBGN40/HeR5S/qcAwX0JKQJ
 Xbnh2pWkvJGQDpMksfe8zdRP4tNfzfDOIJLQjzIiD2PKEsnxOZpEvAZy6LWPmkgPwNu1OkY5G
 haf5qBBi3K3cQD1EPJ7j5ijUO3TFNqh3uVvwIcuWc3u3+nmDvSa1xmhCdBy81CNyNCr/ZrMsG
 xKN31JValwZyCveGPNy49/d6NOQb6EXXOtrKGhpldrmmlW00hhWnEpCcMLFYQJRFP30jNXQAU
 m3gTWl4LZVjRH63bexhk4/eMkT2H0zw+0L9PqUERc/PGXzKfy0XiuzM0mq17xU4Cob8qifjAq
 QYBWNIeAdr8BiexiTx/L0sSsGNQHoSJ7ZKr2GjX/KoUxapTEBu1W2hGZ/ENa/hfiVDHn9oOTe
 s1l1Q1OS6NbFFS5R867KVdW+9JY5cGZ3Y+9eOmbtV932FqKi6AVmmGr8Zk2TuzYEOHeWkzAF1
 IxFlp/fVumV9mifLC9bzYCeXftliip/zj2yXWSll73pywrJs7sbqZRXHbrZy8oiPjJU+FVMTq
 VUAtEWwkN+bFGBDxLKu9nfjm6KXQxFXjB4WsCHyA90z8LJvUgzwXrlbBBOy4ACuhDAZcz57Rl
 Or96KRbyvASxVBHC+2IwfJHLm+ZF23uef9idnBBAcQR/3zjX2wi6In97rjjTeFdzY3QGwxr+4
 IGntn2OSCgkdrd1+/kek46iXkPJ5Qgu2zoBNr5hZxqk5Mn1qH53Qg4zdTqUiq18ghq8RHZQr7
 CBdqF1HUNT4WNHzwc5ox6/IZXSbUPPa57Bv0jFzJNAmg6KQePlHtd3P4aMts=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Thu, 26 Sep 2019, Alex Henrie wrote:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Hrm, the commit message should reflect Stolee's careful consideration,
no? An empty commit message won't be helpful e.g. when cherry-picking on
top of a branch that already has your v1.

Ciao,
Johannes

> ---
>  commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 9b02d2c426..d0e1f9e1f2 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1522,7 +1522,7 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>
>  static void split_graph_merge_strategy(struct write_commit_graph_contex=
t *ctx)
>  {
> -	struct commit_graph *g =3D ctx->r->objects->commit_graph;
> +	struct commit_graph *g;
>  	uint32_t num_commits =3D ctx->commits.nr;
>  	uint32_t i;
>
> --
> 2.23.0
>
>
