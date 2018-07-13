Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589B71F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 12:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeGMNBY (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 09:01:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44569 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeGMNBY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 09:01:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so25000531wrt.11
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=H7e+0bO9mgWn7S8vOO+zOiCLEyT0os4mMDsJz9GJdEk=;
        b=BFsxW5Z1kMZK7Zm3fm6WMYstUZsEJMtrVJUh15akDSkRDuwcpy0Fah2/a1+1cklq1q
         rVuuw3/lzS8iEdHZVyQkWWtGbMrzkzAq14rjQMgOAcPn8HSqFZUfH9kV7de7sndS0KSD
         Tbwk+mEYnVqQd/8vRWZHE3oii5xBz9KsjIl+Jo6Btv6O2NnjSHXuAh52nqSeXuaasbUO
         rg1jEoIBht8q6bSjcv1ROHhFmHktWv8IeSEFJKmSQdWZql9rOkOq/sADGwWCA5iXdnSM
         MKfCKbKDlRICWwelFRwSyPU1vdYjP3SxeIJeINWH63xscG0rY5kuk1hLHCBVM8LPDq13
         dzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=H7e+0bO9mgWn7S8vOO+zOiCLEyT0os4mMDsJz9GJdEk=;
        b=pqYq7Iunq6Mi+BbfoPMMW0cCtL18tx3vNmmO/2IV3axnjmw/Gv3kzCITlHci4+BOds
         uv1wQKjbTJQrBHjABDh7GHxqOZQcVp+Ms6SyfUSwaEr3WwsheSH5Xx3PTg9Gv6XqRC3y
         BkkZ9+mlEYsgkPBSWEbMcJPtXKq3aXo8X1T5wS30OACi76OysPlXEZ1UWNkuX3rzu0KO
         AbYRiGy2hnJJcJ19BxgZyqfelUCMe+F8ocTTjGPRAyZUr0MmQwdYSlRCZcIw5oKaiXtj
         1U0o5DZW92nrcjdW84wBtcgdUDeu/qLe5mXpd1Po9C+bSN+AquenC9CjvSn1PoPa8e1t
         1ofg==
X-Gm-Message-State: AOUpUlE3pU1m8azl0sSkgwBxHB1BlQr0pvi/2Pn4OcxfIHIRN9jcGsbJ
        vUAR33yA+J0HLxNyMZ7ZD48x1auKOBvkhCyfmGHuA0Bx
X-Google-Smtp-Source: AAOMgpeMM6btt7+7VjLgNt16rK6HgAWFZ7pyUU5UT+yR6p5bmY8hbAPG9gBH/mhFNxoJhTZNnWg+lG/VQD55t5udoFk=
X-Received: by 2002:adf:9086:: with SMTP id i6-v6mr2199752wri.271.1531486012153;
 Fri, 13 Jul 2018 05:46:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 05:46:51
 -0700 (PDT)
In-Reply-To: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
References: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 13 Jul 2018 15:46:51 +0300
Message-ID: <CAL21BmmwRDwWc_4JmFKMA6ZYcx=A4biG+tmrBHPRNAxpSkt_NA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Use oid_object_info() instead of read_object_file()
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-07-09 11:27 GMT+03:00 =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=
=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com>:
> Hello everyone,
> This is my new attempt to start using oid_object_info_extended() in
> ref-filter. You could look at previous one [1] [2] but it is not
> necessary.
>
> The goal (still) is to improve performance by avoiding calling expensive
> functions when we don't need the information they provide
> or when we could get it by using a cheaper function.
>
> This patch is a middle step. In the end, I want to add new atoms
> ("objectsize:disk" and "deltabase") and reuse ref-filter logic in
> cat-file command.
>
> I also know about problems with memory leaks in ref-filter: that would
> be my next task that I will work on. Since I did not generate any new
> leaks in this patch (just use existing ones), I decided to put this
> part on a review and fix leaks as a separate task.

UPDATES since v1:
add init to eaten variable (thanks to Szeder Gabor, Johannes Schindelin)
improve second commit message (thanks to Junio C Hamano)
add static keyword (thanks to Ramsay Jones)

>
> Thank you!
>
> [1] https://github.com/git/git/pull/493
> [2] https://public-inbox.org/git/010201637254c969-a346030e-0b75-41ad-8ef3=
-2ac7e04ba4fb-000000@eu-west-1.amazonses.com/
