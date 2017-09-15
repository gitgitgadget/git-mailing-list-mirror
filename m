Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C606F20286
	for <e@80x24.org>; Fri, 15 Sep 2017 10:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdIOKAa (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 06:00:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50612 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOKAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 06:00:30 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MPuba-1dnrjb3tx4-004x8p; Fri, 15 Sep 2017 12:00:21 +0200
Subject: Re: [PATCH v3] commit-template: change a message to be more intuitive
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <xmqqefr8zouy.fsf@gitster.mtv.corp.google.com>
 <20170915045025.4272-1-kaarticsivaraam91196@gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <a8bfb8dc-583f-3126-bbe7-55cb845f1037@grubix.eu>
Date:   Fri, 15 Sep 2017 12:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170915045025.4272-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:INH+PYnKW51/dxA16a31KycZv5M2q3LobjEaEpqXh4/k8XRpfB2
 0qkBLMhAf0ijD1OfNEwZfJgIzLWeBA4w00z5MY1ek5Sg24vLVXxCtOFwy5TKpd0BUfmQa8G
 hqQPeeB/2Bo+jgfZLhPoYlryye1SxQkAzb+vNWctM8BqKpVRWJORfBLlPDjNZaiYHVPNccp
 Iz7izNTI9GxFVvVZqRwUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YClKzIeCXys=:AzWALpzEF+7ba43eQwPUnK
 XOs2Hy2QC7/g3qR1xXkgC7il2fbic++4AtVQAX7nUXt/pN1OHQxYmay5So4D599hjd+TrNb3a
 XmWRUk0gneH5E4nVyqurEps9BcWsSRuIvBz04KovoPfxII3xWLeZNk9Ye957Vi+oUudPsoONS
 UhG96ZBFkEiVpqzc6IqWcFEYHxGphen7xeHD6n8srkJ+18uejOUOguLzAcBPLzfkln55C03Uf
 OgZcJt0rJlD8YZiM39r0enoTct3D5vfvAeKwXklt2NSlhmQC24tBPbmmKSl/XaL1dzppYuBQW
 VcDqKW8ZLaGZmzxKgeV6HfhlIHWQY8OMYd9rN2FP/XQfxEPIjafX63o6om9t3SOSt4QcnCzgg
 7/cK3gd3OLtinOAz0H7eq9uc68NHfy6R1cEeiCwclPlLs6zKU/tzsc6PvDtNqWmAabafm0eUq
 ui1czb9a7x+lIwle0uDSSRtI5AheIPaK9lTEgDg7gPGl33lqzm20ISx1UUQaY5LpbBaUjQoiE
 RHpHQsEQ/ylchQFoJ8TiTlj+9lLItnfZDBIZ8mDKpJAwnAHKsfR1PkE1ifcXmD41ITWo4yPPo
 OLiADLIyjftoZdSQ7XdjNNBroLgMVLwcOm0l4wryco3DeyRZQB7+9FaBJnlauEPJRT8CJSLjf
 VLgeATvc4Xwo5kUZJAmedtKV/NmlQPZUxWWQsdogohqCPeWlGplqby2864Nrqwj7esCRQL8SX
 n1wz7zFlVaYVvTeNKmg8lAApe6Kc1ZCaiMbkspFAbI13h6ImD4YR0q3jp40=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam venit, vidit, dixit 15.09.2017 06:50:
> It's not good to use the phrase 'do not touch' to convey the information
> that the cut-line should not be modified or removed as it could possibly
> be mis-interpreted by a person who doesn't know that the word 'touch' has
> the meaning of 'tamper with'. Further, it could make translations a little
> difficult as it might not have the intended meaning in a few languages (for
> which translations don't exist yet) when translated as such.
> 
> So, use intuitive terms in the sentence. Replacing the word 'touch' with
> other terms has introduced the possibility of the following sentence to be
> mis-interpreted, so change the terms in that too.
> 
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Changes in v3:
>  
>     - changed the wordings of the second sentence as there seemed to be a
>       magical 'or else' connecting the two lines.
>  
>  I didn't expect the least that this would go upto v3. In case anyboy finds
>  something wrong with this change too, it's a lot better to drop this altogether
>  than going for a v4.

That happens more often than not :)

Your original intent was to avoid any misunderstandings, and all the
comments and iterations made sure that we don't trade one possible
source of misunderstanding for another but avoid them all.

I consider v4 to be a strict improvement over the status quo and (as fas
as I can see) to serve your original intent as good as possible.

>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 77c27c511..23e87e74d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -934,7 +934,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
>  
>  void wt_status_add_cut_line(FILE *fp)
>  {
> -	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
> +	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
>  	struct strbuf buf = STRBUF_INIT;
>  
>  	fprintf(fp, "%c %s", comment_line_char, cut_line);
> 
