Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7A520281
	for <e@80x24.org>; Thu, 14 Sep 2017 07:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdINHgo (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:36:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdINHgn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:36:43 -0400
Received: from UltraSam.fritz.box ([178.11.154.32]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MTsps-1e1EQ91d3I-00QPCN; Thu, 14 Sep 2017 09:36:37 +0200
Subject: Re: [PATCH v2] commit-template: change a message to be more intuitive
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <<e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>
 <0102015e7b585037-5f88e775-2696-49ec-8dd9-5e1635a34607-000000@eu-west-1.amazonses.com>
From:   Michael J Gruber <git@grubix.eu>
Cc:     Jeff King <peff@peff.net>
Message-ID: <862e71a1-2dee-4a20-d828-69a0547fa5ec@grubix.eu>
Date:   Thu, 14 Sep 2017 09:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015e7b585037-5f88e775-2696-49ec-8dd9-5e1635a34607-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:woHrN84aDwmnkEvjNk5iHEGcMKeMm49qcrCcri7l0nuV5fwSdOq
 5b8VRMBohk9WXmt05Yhn8+4DSjaZvfO9r4xXQ8m+xNr04S5WsvYPl2OeKRg3kkLtfyykBWJ
 QkE4Tf9IWlTmLIUnmYxRrj3jrj6BXoM53lTcY7vwBxQMHX6ryd0f07DFwblnI0x6G7N3uFS
 DEqDhmb6+QBLB/teHdgiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D3kUJCEnMiE=:QrfKSSKUOYWjWc4TtJU7T0
 XL6Ab8ugKBDSgPhzju3SjGXFzBjZmwALjfb8ywGzX6fCMifN7DRp4JzQWztYq+oQ2MCKBqx48
 PpCOv2AHLKsTwiEgGLwGu83qNvrbA0W7LrauMJ1DpqT2cr56WitMxe91ZpeMe2tllixfP+Nyx
 lb0xqD0De9PRI0dnX5wuFr1vO0NHvz+Qry1S72R/NoBO8mpQutNczjpUudq3d3Eg8H9GTNz5p
 k7fVPo2DHPgNo4qtB49uA1PTQtALpU+FyWY4c7h246V2APPBK+sKtt8OSI1OZ2nN638WpebJ4
 0YwASPixcrw1h/XBNJ8eQUHnYM00bIFSS26FS1HYh31WrVuntjdKUSVCG0ML8p26uIdY03Vwz
 90WNwNpUSbpvio2YlwQm2A79RPPveIQKtCgrfLbQvCv0xGmGy2j4MQOCl/J+yvEbbUmsxVj3I
 acmZW2jgYyYyNsiwtzl4rv+P/+sVfbobGTtesJzO+8e/STtVuTa7DYutBFop0cfuega9kRo+j
 aTqdWUQGiTVZmEuHyUJist1pRV4caVnpkbfs/sfTDz+gWS/P6NNyzMWmM7Mq/aarVO6o2DGO9
 GdRtDgAJXwGcBYc0HyL+0WHaMKRKdh4pIF6r6av0siMjJ50oURpzPs02QQq5oiLvqxeaNlGFw
 38R79313GGnYXca/7eckaYVOOE03mVtmVSf/Rc6LfBe8NEfi5kkxfhlTburtc9p+JhbD9Jl4Y
 7xDXVip8SV3qchXHYhKcKJwxcYDgFGa7M9wjlhYGDfTVCs397bh4uuscoqE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam venit, vidit, dixit 13.09.2017 15:05:
> It's not good to use the phrase 'do not touch' to convey the information
> that the cut-line should not be modified or removed as it could possibly
> be mis-interpreted by a person who doesn't know that the word 'touch' has
> the meaning of 'tamper with'. Further, it could make translations a little
> difficult as it might not have the intended meaning in a few languages when
> translated as such.
> 
> So, use more intuitive terms in the sentence.
> 
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 77c27c51134d2..be53579760ee7 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -934,7 +934,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
>  
>  void wt_status_add_cut_line(FILE *fp)
>  {
> -	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
> +	const char *explanation = _("Do not modify or remove the line above.\nEverything below will be removed.");

I don't want to complicate things. But now - due to the repeated usage
of "remove" - these two sentences seem to be connected by an invisible
"or else" ("will" vs. "would" not withstanding). i.e. "or else
everything below will be removed, too", which is wrong. Before, they
were separated more clearly.

Also, given all the translations that we have, it seems somewhat strange
to try and foresee and workaround possible misunderstandings of commonly
used English phrases.

>  	struct strbuf buf = STRBUF_INIT;
>  
>  	fprintf(fp, "%c %s", comment_line_char, cut_line);
> 
> --
> https://github.com/git/git/pull/401
> 

