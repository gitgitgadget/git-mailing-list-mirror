Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0EB201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 06:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdKNGVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 01:21:48 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:49340 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdKNGVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 01:21:46 -0500
Received: by mail-io0-f179.google.com with SMTP id x63so11063280ioe.6
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 22:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O9HeD8BtOwkDTHwHgIi2my8xO7mb/n7YlF25ziWT37Y=;
        b=psJKXyVhyDJS9T/d+eKvF279kXbbRlcGhnkensmuXHahjhMtNoWfpqRGNSAJIVO4Zu
         Y39PgU5vvsVvAreOsacMNirIL0/lnm5RfA4ot0vzeEtNrhF+fTiNGoRBDvWgg6d3obdY
         bBUosIJKuw5d1OCpiAJ8rzwEen8Da5gkTvqYpFgSviDwF0+kXIhUndkNSqlWX81IFLtJ
         GocY/qxHLItjKjftHUS8rCUcqpNBVhmXihnLaCDyPOhN3k7k9BVyZTjzh7C8zAFXDVhz
         /1C4qtspQsPe7Pp0rZZzqx64L4+aTHUQelxGoqUeIAw9KVKcUFFe6aXiUgFII+qzCEcH
         eW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O9HeD8BtOwkDTHwHgIi2my8xO7mb/n7YlF25ziWT37Y=;
        b=R4VvBuvBrIOOZ7Fzl19MIX7eCfGoOh6/UAcYafH6cIuepbmkXqURiex/kKt7jK8CVX
         tqj/G/mmGj8OfGu5sUUvHGpk2AHS6MXvndKHgBFvld0nAnYUKf5q6G9dslGFFABtMFHA
         dnGSPM9HalQCh9FCwdNAqlS4w6pXfajaERZzGhWciOlEvufWqq8RboFfRT054F7j+RuB
         i1jcoxgRcUz1YFXhVXADTyd684HxkDybuMaVm56dgW6uyNjlDFV/S23PbFl08iGDI7UK
         eR3RB9+3Ssa9FdOE709nTb26h842wArYfpcaQthax7HXd/qu7KU5Wx91+s76jgieK/kS
         MUTQ==
X-Gm-Message-State: AJaThX7H5FJaFeZaN1G27b1o6uR1wfWLCEzUokByGEjEcvvUx2+b2Irb
        R7HLkGbfk1pYpOBJs+YYUNK4n25wGyu6IH+wbm4=
X-Google-Smtp-Source: AGs4zMac6QFh+LsPIbHOJM+8Iv+FetckldFqJXoBFwu3nmMvWisjDQiOY9+fKXQAvQi8oM+lm98WwQG9HzOn2o+S/JA=
X-Received: by 10.107.111.14 with SMTP id k14mr11644253ioc.282.1510640506067;
 Mon, 13 Nov 2017 22:21:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 13 Nov 2017 22:21:45 -0800 (PST)
In-Reply-To: <1510625073-8842-1-git-send-email-hsed@unimetic.com>
References: <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net> <1510625073-8842-1-git-send-email-hsed@unimetic.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 14 Nov 2017 07:21:45 +0100
Message-ID: <CAP8UFD3TbmZ3bRwg-fRoSJWAFaa=UDxVsZphn_3Nt4wMz1N2=A@mail.gmail.com>
Subject: Re: [PATCH V2] config: add --expiry-date
To:     hsed@unimetic.com
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 3:04 AM,  <hsed@unimetic.com> wrote:
> From: Haaris <hsed@unimetic.com>
>
> Description:
> This patch adds a new option to the config command.
>
> Uses flag --expiry-date as a data-type to covert date-strings to
> timestamps when reading from config files (GET).
> This flag is ignored on write (SET) because the date-string is stored in
> config without performing any normalization.
>
> Creates a few test cases and documentation since its a new feature.
>
> Motivation:
> A parse_expiry_date() function already existed for api calls,
> this patch simply allows the function to be used from the command line.
>
> Signed-off-by: Haaris <hsed@unimetic.com>

Documentation/SubmittingPatches contains the following:

"Also notice that a real name is used in the Signed-off-by: line. Please
don't hide your real name."

And there is the following example before that:

        Signed-off-by: Random J Developer <random@developer.example.org>

So it looks like "a real name" actually means "a real firstname and a
real surname".

It would be nice if your "Signed-off-by:" could match this format.

Also if you have a "From:" line at the beginning of the patch, please
make sure that the name there is tha same as on the "Signed-off-by:".

Thanks for working on this,
Christian.
