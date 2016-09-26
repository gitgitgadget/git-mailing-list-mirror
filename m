Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C93B207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941165AbcIZUoW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:44:22 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36011 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933488AbcIZUoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:44:21 -0400
Received: by mail-it0-f49.google.com with SMTP id u134so23318473itb.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aBLY2Rj+4+7oY27a/5otClWGM1x89QA/bufQgyEWifU=;
        b=ZsJpJyKjHpF8UBBJzETEyyp2DWlj1TMZDxRDJUtMDl1W8v5z8l8TT4deWq96SG2xT3
         uXZm1LjBuBaS7F8JPP8k3vqBYY3gyp8QZtj88O3UmB6s2DeyiEOEoi6fwTcw1e2Jv7wL
         1T2rjgkCQGJ0ujZ9IrJG3xEtcSDpex+iM72VIyo19oBDk95VzoNBKxX/5nI6qAKrUscI
         m/nQqeqAjyc5o2u6CxCtPXQ1T2UJZYJ5yYRMOGFncalpRpQSJQuUDOdvZnwqYmc2aLUh
         qOdWn/+6D6qXokLjo4DC9VGDX9uWLRnJi+JkRz2L7ElMg1we2jtgIbJR/mcYEyAIl1FA
         7plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aBLY2Rj+4+7oY27a/5otClWGM1x89QA/bufQgyEWifU=;
        b=dI0cbLkc4aTPTW5eHtn0dg+yW1DfFmFHPOzBufpgZMAaCeH0h0MgsDdAYiiSnoB9Ix
         Wh92NTmEE5B0SjnCrWpOAHEJC/G+plqvT/a/0TsTZM2X7aJaxN28f5mxYy1lVjuEY+vU
         Iiti+aQOY53hNX3rHMAXynX728P+x1p8lO0oZ7nYleBW5LbW9GxZ1vsfVcfUZCaUsF0i
         wNfsASyySODsX7UqM9+hZ6yGLnb/uNywBIGxxzxgV72OFqpj5l/6JldH0xcVMlQqXTSJ
         /8lSRmfTxcqYqKzF31pOeGlxAjK9ors+3v8WbBT71PpD19WjJrnxLRvePPCh1LyDtdLp
         YWBw==
X-Gm-Message-State: AA6/9Rl9EUVa+v819X1lVf+k4b6u8Y85OoL+l02d/2zLzi7Vgj68Jsihj2R2UX9BRh8wBMcmdlOk/kCWevOJIl84
X-Received: by 10.36.36.214 with SMTP id f205mr20079081ita.50.1474922659929;
 Mon, 26 Sep 2016 13:44:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 26 Sep 2016 13:44:19 -0700 (PDT)
In-Reply-To: <xmqq7f9yqu9w.fsf@gitster.mtv.corp.google.com>
References: <20160926193553.32631-1-sbeller@google.com> <xmqq7f9yqu9w.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Sep 2016 13:44:19 -0700
Message-ID: <CAGZ79kbeq+Wznm=ChWO0tU5A_haPQ6DvKNHbK+8Y3es5OVcRag@mail.gmail.com>
Subject: Re: [PATCH] Documentation/fetch-options: emit recurse-submodules,
 jobs unconditionally
To:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Currently the section about recursing into submodules is repeated in
>> git-pull word for word as it is in fetch-options.
>>
>> Don't repeat ourselves here and include the --recurse-submodules via
>> fetch options.
>>
>> As a bonus expose the --jobs parameter in git-pull as well as that is
>> declared as a OPT_PASSTHRU for fetch internally already.
>
> The above may not be technically wrong, but smells like an
> under-researched description.

I knew this question was coming, but the research was not as easy to
follow as it seemed convoluted to me.

After a bit more research, I think 8f0700dd33f (fetch/pull: Add the
'on-demand' value to the --recurse-submodules option) is the culprit,
where this patch should have been squashed into, as that made the
both locations word for word equal.

>
> So where did we go wrong?  Was there a good reason why we have two
> instances of these option descriptions, and if so, are we sure that
> that reason is no longer applicable to today's system that we can
> safely share the description?  The proposed log message is a place
> to answer these questions.

The commit above is where we went wrong; It doesn't seem like a good
reason for not including this is given in there.

>
> By the way, 7dce19d3 is interesting in another way and worth
> studying in that it adds --submodule-prefix ;-) It may be something
> we want to consider consolidating with what Brandon has been working
> on.

That's why Brandon is cc'd now. :)

>
> By the way^2, the "unconditionally" on the title conveyed less
> information than their bits weigh.  Unless a reader knows
> fetch-options are shared between fetch and pull, s/he would not know
> you meant by "unconditionally" to show these in both fetch and pull.
>
>     Documentation: share more descriptions for options between fetch and pull
>
> perhaps?

That's way better.
I'll resend shortly.

Thanks,
Stefan
