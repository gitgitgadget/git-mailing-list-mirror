Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50301FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 02:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdBFC2I (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 21:28:08 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34834 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbdBFC2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 21:28:08 -0500
Received: by mail-pg0-f68.google.com with SMTP id 204so7688297pge.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 18:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OfxFhjgoPyNyQ5BrPR67qo2WaraZN7BXSYNjknMXqmk=;
        b=m0UZgbuNYSpD3iAP49FGGxmCNMS4uZnwSgYHKnAcG0eD2PcyWxFccjM5v0/iQ/7LzD
         E1oW1pS+QONrm2TPhpnZ2fS2bbADYo10fzoWXidZLoUuUbbx5EUr9UyMJ43F+8iWgpWj
         Tq0/0+hheSxxQlS9EPTtpYyeVuex2S7s9TwiMu66QeGvmI3qHAiRIOfoMwUrlrEECeaw
         4qM+D3OjLAkralpUUm6h3hbpG6Iorfrm0xNvYGExb8DryiXqvc/2L9yffAyjv47N/hj7
         S6axEoK5uNMG+D1vBKO6PLP1HOSCriWCajpyTfBPdHHfUxswW+xQvF3pBvYm7o3L9IC2
         W0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OfxFhjgoPyNyQ5BrPR67qo2WaraZN7BXSYNjknMXqmk=;
        b=SYhY2p/zHnuuPPhI7pLijHUwskw6AsvOR+XuDgjUE7cP7W8ybSHvNvwk3PyIZzX+Hk
         MOcITicjKoxqqhUG63Fu185FegeH4+kygezdhODFPhVDMTm1/i/HGajFoP776/CTfUI4
         sRx83GkDcbDEhFBoYv989sXQduS9s3rktW2vfVALohjJQasSckKxXL2f3g7bban6H+Xt
         Xg7mgnOhswLjHRq2E68zTJd2aIzgvyW2Cng/0ABV42tNs6oNzMyhX+7t7JXbd88WUJsu
         AOhZz/tRPyR6bcqSrhJB6SLA/GKTU/Rxl6Qu7hr4h9EWmMRuaNC+TSpvZD/ixxovEljC
         ypOQ==
X-Gm-Message-State: AIkVDXIdTpblrzYBNgwPIPrc5cEAdGsRSqmKgTsYmwvxBvB7EME9Yt9Jrass2w/SjkI0zA==
X-Received: by 10.84.143.203 with SMTP id 69mr13989102plz.68.1486348087305;
        Sun, 05 Feb 2017 18:28:07 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id f188sm83860474pfa.35.2017.02.05.18.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2017 18:28:06 -0800 (PST)
Date:   Mon, 6 Feb 2017 02:28:04 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3] parse-remote: remove reference to unused op_prep
Message-ID: <20170206022804.GB3323@ubuntu-512mb-blr1-01.localdomain>
References: <1486218663-31820-1-git-send-email-kannan.siddharth12@gmail.com>
 <CAFZEwPOdL4mOAnmTUqs5LmfdG2GQCieVGVQ7T3ZWR0n+d6tCQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZEwPOdL4mOAnmTUqs5LmfdG2GQCieVGVQ7T3ZWR0n+d6tCQQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Pranit,
On Sun, Feb 05, 2017 at 02:45:46AM +0530, Pranit Bauva wrote:
> Hey Siddharth,
> 
> On Sat, Feb 4, 2017 at 8:01 PM, Siddharth Kannan
> <kannan.siddharth12@gmail.com> wrote:
> > The error_on_missing_default_upstream helper function learned to
> > take op_prep argument with 15a147e618 ("rebase: use @{upstream}
> > if no upstream specified", 2011-02-09), but as of 045fac5845
> > ("i18n: git-parse-remote.sh: mark strings for translation",
> >  2016-04-19), the argument is no longer used.  Remove it.
> >
> > Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
> 
> This looks good to me! Thanks :)
> 
> Regards,
> Pranit Bauva

Should I send this patch with "To:" set to Junio and "Cc:" set to the
mailing list, as mentioend in the SubmittingPatches document?

- Siddharth Kannan
