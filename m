Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7834207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 02:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdF0C6x (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 22:58:53 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36667 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdF0C6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 22:58:52 -0400
Received: by mail-pf0-f180.google.com with SMTP id q86so9267140pfl.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 19:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DcpTZzwYX1TvGZRTgLwlIY/5nrPsYu1VSenMvyCMez4=;
        b=uh1xdAsq4ElHvnLzwAUeYfN9kXLg8hVfPWUUJQOAis9laU5ptTR4a4+OWTzvqe/6hf
         nmeTCFGaRD5yc9IkiPZ4zkQyRoG2Gn8afjrREWooWijzQItpvgpxTl9tNrxE2iLlUl4p
         whqcQEOZRk+GtmjFNPK4zOSfsS2lT9PqVJ+i7sORMj3mNSxBWMS2UX6YXuM6hsn38GWo
         A9Wj+komxRowoiL0sdRKlqvtZV89Knm3geO1TvGJetjwFcy4Qw6rVOHNG9RHdmb26Ubm
         xKH9XR+EOQi4IXRMN5MSw+CqsSE6ZoBmnVGUTi7Z9qDqwUK11df4YnERW9vlzKENVXSZ
         Z8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DcpTZzwYX1TvGZRTgLwlIY/5nrPsYu1VSenMvyCMez4=;
        b=EpJGRNVeQyli6wAJs4NjyFKhtCz3W2B7E49RgDDY7wOt2YAJpKrxjBUHsswp+C+uE4
         9FKsL8wyaGOuuFd2yCN1wTPD/kyGF44L3JLB59vkCqFgKW4v2wvjCZz+w12ItfgbbJVc
         8FjeVkYd6OdLm0w/fbuytGvs9iGaANzQcd3Xg7RMSuCuFh91aBJOlcRFltJM44KijKxF
         nkuXKGbWdhbY1l7xeLuLNrziAcGHMBEO8eY/cDpvB2a/kzhmtAI8qPkA5CAuTrTGb3ha
         wV1guQGmUWz809nGhwGwaIpcWCpOCcpBA8/tbHMqV5JKgLY4J+gbJAW+ceYSrQ9mTevl
         IBog==
X-Gm-Message-State: AKS2vOyKwA2Sx9ucuHFVFDKRqfeCoxMdWRX+uzhhRukZeuFWegpQeQ6r
        Vfi2H04+EQMh/zdeehEovU+IuAtVlaZC
X-Received: by 10.84.224.74 with SMTP id a10mr3367724plt.210.1498532331402;
 Mon, 26 Jun 2017 19:58:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 26 Jun 2017 19:58:50 -0700 (PDT)
In-Reply-To: <xmqqwp829p18.fsf@gitster.mtv.corp.google.com>
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com> <871sqajrgi.fsf@gmail.com>
 <CAGZ79kZyMUKPahTXOF7ds6zSvFKLrM2N78JKG-2+GRL5nnmuvA@mail.gmail.com>
 <xmqq60fmb4q8.fsf@gitster.mtv.corp.google.com> <xmqqwp829p18.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Jun 2017 19:58:50 -0700
Message-ID: <CAGZ79kY4bLaFgkkWZCriTQrRWHLhZxuNo9WQdRopSWET6driUQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> But for the purpose of this "moved line coloring",
>> excluding multiple copy destinations of the same thing may be a
>> simpler and more robust solution.  It will not catch "somebody
>> stupidly removed one function and made two private copies", though.
>
> Let me take this one back.  Treating multiple copy destinations and
> multiple copy sources differently is a bad idea.  It is easy for a
> user to give "-R" option to "diff" to turn such a stupid patch into
> "somebody brilliantly consolidated two copies of the same thing into
> a single function", and we want to keep "diff" and "diff -R" output
> symmetric.

Thanks for the pointer with "blame -C". I'll look through the archives
to see if there are good discussions that yield ideas for this.
