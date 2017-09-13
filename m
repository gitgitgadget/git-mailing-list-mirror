Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E16209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 10:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdIMKor (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 06:44:47 -0400
Received: from ikke.info ([178.21.113.177]:42972 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbdIMKoq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 06:44:46 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 64C74440120; Wed, 13 Sep 2017 12:29:15 +0200 (CEST)
Date:   Wed, 13 Sep 2017 12:29:15 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] commit-template: change a message to be more intuitive
Message-ID: <20170913102915.GA21499@alpha.vpn.ikke.info>
References: <20170912105536.6094-1-kaarticsivaraam91196@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912105536.6094-1-kaarticsivaraam91196@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 04:25:36PM +0530, Kaartic Sivaraam wrote:
> It's not possible to 'touch' the cut-line that is shown when the
> user requests a patch in his commit template.
> 

Touching something can also mean to disturb or change something, which
is the meaning being used here, so it is not an incorrect use of the
word.

> So, make the sentence more intuitive.

I can understand however that it might be not so clear for people with
less fluency in English.

> 
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Just a small tweak. May or may not be worth the patch.
> 
>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 77c27c511..1f54b1df2 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -934,7 +934,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
>  
>  void wt_status_add_cut_line(FILE *fp)
>  {
> -	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
> +	const char *explanation = _("Do not edit the line above.\nEverything below will be removed.");
>  	struct strbuf buf = STRBUF_INIT;
>  
>  	fprintf(fp, "%c %s", comment_line_char, cut_line);
> -- 
> 2.14.1.1006.g90ad9a07c
> 
