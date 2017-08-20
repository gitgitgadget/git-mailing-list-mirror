Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9227120899
	for <e@80x24.org>; Sun, 20 Aug 2017 12:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdHTMkr (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 08:40:47 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33418 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbdHTMkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 08:40:46 -0400
Received: by mail-qt0-f170.google.com with SMTP id d15so2187976qta.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1791saCgiT/SFT4xiy7LFw8g+JLxe5JoF0lbMzushcg=;
        b=gC0SR3nNmsL/LFU56SdKlWfcMqFj15L5y5gYD0MbGxlaHUsGb4vCKeZtlHmIXls9yg
         9B7ps2Ji+Mz/jG6fXHHJGX96FxXTBySyL3UNqypb9EdxIgvmy+mU7HBmiHxptAtmw+rn
         mUkWyNZ8Q4fUfUrZEVQZwBC70RAQi7nicPgylJ5JSI19Bk+hAPBO4bii9yba7UCZd+mr
         6InbLfq5p3jENzlyezDOWFl/UqQN/CabNEpygwfq0RRMnDz8oQ+LWB2QHRoFIdyzT0tt
         hEGItm4WB9E43+KRUGRknvGlOr2lXk7bc8YTj7SLSuVBplEpytb+gzf8GDvkyLwgBjbj
         aXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1791saCgiT/SFT4xiy7LFw8g+JLxe5JoF0lbMzushcg=;
        b=RU9JUI5xR2OuPvhGkXpKFLNAlA8ouukpBFKmI/xQ7FzGBUZajAwMp9R7hzz50Y5dSt
         QnuRtFTHg8WJMm997SPe3LTsNktX0Mqx90rVHYfCS+RqBrmoLAXcU2GKOb13IWeO67S4
         PC6MU8svU2lgvYwa65T3BlTNBGi9tDO0oNk7cssqpGyemPk5IF9EP7oUACzhQOS0IdEu
         By4DF+8w8EmXS5q9IMxMcMNks5wGKiPtQhT74rXpbx0MP8SrN14UTPlUsHM+15QJLLcM
         9ZwGBX/sa6rlxVZC0QXlZR+iFrkrH82R8c9pJjBi7/y3hnNOsvUI7JyzsjKJ+hHDtWxT
         gnKQ==
X-Gm-Message-State: AHYfb5gWuLs6oLm7mHyuG7iocneDz0os1bnyRRyTUHHqDaPFdS8U71Kn
        QRAczWzgVlhuN0FyXsGLz7zvKk8DOw==
X-Received: by 10.200.33.188 with SMTP id 57mr19623156qty.101.1503232845362;
 Sun, 20 Aug 2017 05:40:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Sun, 20 Aug 2017 05:40:04 -0700 (PDT)
In-Reply-To: <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
 <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com> <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
 <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Sun, 20 Aug 2017 22:40:04 +1000
Message-ID: <CAH5451m58n8mYvt=BC_t2=EAv0HOOdAWrCHCNEPQ3NVjT174nQ@mail.gmail.com>
Subject: Re: Please fix the useless email prompts
To:     Jeff King <peff@peff.net>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 August 2017 at 19:18, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 19, 2017 at 02:02:09PM -0400, Jeffrey Walton wrote:
>
>> > Hasn't this been asked and answered already?
>> >
>> >     https://public-inbox.org/git/CACBZZX4vEOD-4a-eK-uBxmFrb1GLSvJKxHW51whCSbCZdh7amQ@mail.gmail.com/
>>
>> Its 2017. I'd like the tools to work for me instead of me working for the tools.
>
> Ironically, Git used to behave as you requested in 2005. After being
> bombarded with complaints about how Git was too lax in creating commits
> with bogus ident information, we changed it in 2012.

Maybe I am missing something obvious, but if that's the case then
can't we just do the identity check when trying to make new commits,
in which case you should be able to pull without setting your
identity?

Regards,

Andrew Ardill
