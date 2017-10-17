Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A58202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757300AbdJQHP4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:15:56 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:56546 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbdJQHPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:15:55 -0400
Received: by mail-qt0-f173.google.com with SMTP id z28so1450579qtz.13
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LfIdfUD85ozOTPQiZt88HEYZmh4rcenN60dFumAN0Ms=;
        b=OluEtd+8VZi1q15EITOcQKXaDuzL1ChYepxac+iV7C7ArL8cdiSU6c/P4S2tJTDblJ
         +eUiJ4mokZVSeuTwBJku8sfLJjP5QGUQ7aoEFdumEmhMyCcAwJdFpQnVVHTpG4E01tC7
         WeWWoGScPkXoJPeb4gEHhDxLVnXLV8Iup/IgcmnAlI8oSSZuldFT30Uhg2cMbNAmtEQY
         m7lrOsMpVK5QS7jCjjPagdZO9FSqW60ZMyFLtKzv/jbFbuMdrOFekHfcFGM8G5z/KggL
         LMfHZdVZhPO78cSjk8GZExqFvzxQHtqoOlwVa7QkmUdLq5jhnZKMxe79mSjyd+udnK+B
         PFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LfIdfUD85ozOTPQiZt88HEYZmh4rcenN60dFumAN0Ms=;
        b=D64Zlm41yc/u8k3CR9PgupCNeo/C+DgYfCkDaT2aENrddt8UwHShW4taJppe6EkbnV
         KEOFmQAaiyLPMnRqnerEh2K+A77jUBJZfLzSpXTr8pDGwkXGhnrpfQWaHxeoT6mqJtFg
         DPz9YRBpjn6iM7RF+jc35gy3hL1s2qKubSeRU71QYDiklFJET4XvolODnEWuRKloj0hD
         eNkjkV2kWrDQJsRHnoiisbwSiiEzuIRlGWtXj0Z5pqEVDWaIeiHHztFEqT9RVXkcEPy7
         ud/JgqfDivGy+wkM/VE/cAehko3MLXOhmFl9lVPTW3+yX+KyYsL/ItE5IeYd0PweVZnB
         Vrbg==
X-Gm-Message-State: AMCzsaWXhTOvIdnKSdnRcXzicBY9Bfvz3Camx4VV3x9Og/kOn4MMJqyR
        PGfD9DxES8CpsGpq03hnLi5MDehhdqRXArF2zlc=
X-Google-Smtp-Source: AOwi7QAkm7uTp9DbRgHfae0KeEtBIwh222snPN9HGx08P+1i6UZi+GzeYug4L5+k6GWuzEvXuAhAxvQmZZt//1PIkLU=
X-Received: by 10.237.39.211 with SMTP id m19mr16452851qtg.93.1508224555110;
 Tue, 17 Oct 2017 00:15:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.83.136 with HTTP; Tue, 17 Oct 2017 00:15:54 -0700 (PDT)
In-Reply-To: <xmqqd15mpgmk.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv4x11y9.fsf@gitster.mtv.corp.google.com> <20171017034743.8418-1-thais.dinizbraz@gmail.com>
 <xmqqd15mpgmk.fsf@gitster.mtv.corp.google.com>
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Tue, 17 Oct 2017 09:15:54 +0200
Message-ID: <CAK7vU=2f+EVorUS4Js7WW6GePnbopGi54egviJ_NG9prj6C6OA@mail.gmail.com>
Subject: Re: [PATCH] patch reply
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thais Diniz <thais.dinizbraz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just sent a patch to a new thread which is not what I wanted.
However I already sent the same patch a few days ago:
https://public-inbox.org/git/CAK7vU=2ePR3jQsgu=RxSMrxytAAHqxC0SFrN5YozLzQzP2ZT2A@mail.gmail.com/


2017-10-17 6:01 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Thais Diniz <thais.dinizbraz@gmail.com> writes:
>
>> +Just to clarify I did not see Marius patch.
>> +Did see Marius' comment saying he would look it in the leftoverbits list,
>> +but since i didn't see any patch i thought i could work on it and did so based on Stephan's comment
>> +(which i suppose Mario also did and that is why the code resulted to be similar).
>
> In any case, both versions share exactly the same "don't call
> get_multi() to grab the same configuration values from inside the
> callback of git_config()" issue, so whoever works on it to complete
> the topic, it needs further work.
