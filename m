Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112AE20966
	for <e@80x24.org>; Thu, 30 Mar 2017 22:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934266AbdC3WE0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 18:04:26 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33969 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934191AbdC3WEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 18:04:25 -0400
Received: by mail-oi0-f51.google.com with SMTP id o67so44621553oib.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QcUZ1dwzrpDMOojISyE/r/ueZkB4Fxvx27dGbrXfHEQ=;
        b=m9FJRdT6/tYyRJDow17zlSG64YQElrar+ehSP5J2PLpYFE+hSrw9OKSN8Eccasw0Yg
         l3hmyDFUSxQV2HqD9Gn3nEEJq2Ds4kXxI6W5bv3fhqpyCB2Hi8mAwNf2Gnd1zplBvJ0R
         LvO+5qKjBXooQITZml+TiBtNRoH5oLCDbNhWvx68PZaRvi3PGHSBmpO0esUMZRlMhGZs
         ub+I+EIkvH4Et3ZIeUO8qTkaZE27piuPWUzQuN4YlnlUarq9AAyyl5bQw7azpd9TmX2V
         uS8E4YNyagsLpg0DVgVxk1Fum8zuA0M5R9YSGtf8bxT4czZ0WVdl1XAq1ilHU+KM27wL
         z/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=QcUZ1dwzrpDMOojISyE/r/ueZkB4Fxvx27dGbrXfHEQ=;
        b=ikCcrcHSvcSBxk3TXjK98iFzxdvnLsqcF1h2V1czehLMFrvXJ0H8o0d6v/Kwb23SWp
         uRwTcovegYClf97Hpc0YhbfUrhNX1LzdxnhfiRLErLtHdgsmxXajkh/lJJjAos9RmJNR
         2PtELqZqqWemPAZhstOk85j+/Rc9CA9Nsnptk3R7/Us9BTM6AGo6E+HCF1lYtZL9Nwcs
         3tqBRkkU/x0pBVfkKid++r74lojvnn6zR1iyccwxcpM1FxiLc/FTG5fulMLYWhEAAJ26
         COKmmuK1mf1VnKSxshVPjO15JDRJiW60RdqOGyu3o5OIDk8GC28r/1/5MMZrTfdG4jpD
         PZ4g==
X-Gm-Message-State: AFeK/H1icHuWoz1aFwHLlyJOc2M7N0NXTd8A2AqCYtHT5Dv9oWHg1oKRVnkFts+kRAL8UOTZLc4laDRdj5EZqQ==
X-Received: by 10.202.177.215 with SMTP id a206mr1342891oif.147.1490911464042;
 Thu, 30 Mar 2017 15:04:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Thu, 30 Mar 2017 15:04:23 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <xmqq60iq31dk.fsf@gitster.mtv.corp.google.com>
References: <CAH8yC8kOeuVjvoeg0WsSfDeakJh_es2xhYK_O_bM87DEBVcB1w@mail.gmail.com>
 <xmqq60iq31dk.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 30 Mar 2017 18:04:23 -0400
Message-ID: <CAH8yC8kEzK0seNj9GK8h5mnMDvyG9=PnChmseSuvSfvb5h+uDQ@mail.gmail.com>
Subject: Re: Git and PCRE2 vs PCRE?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 5:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
>
>> Is it possible to use PCRE2 with Git? If so, how do I tell Git to use PCRE2?
>
> Given that pcre2's symbols are all prefixed with pcre2_ (I only
> checked http://www.pcre.org/current/doc/html/pcre2api.html) and we
> do not see any hits from "git grep pcre2", I do not think you can
> just "configure" Git to use it.  Unless pcre2 library has a drop-in
> replacement backward compatibility mode with pcre library, that is.
>
> It probably is possible to use PCRE2 with Git by adding similar
> amount of code to grep.[ch] as we have support for pcre and that
> would be the way you tell Git to use PCRE2, but I think that is
> probably not the questino you are asking.

Ack, thanks Jeff and Junio. Its no big deal to me.

I'm not a PCRE user, so I'm not familiar with the extra gyrations
needed for the migration.

I'll get the original PCRE installed.

Thanks again.
