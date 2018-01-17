Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599251F406
	for <e@80x24.org>; Wed, 17 Jan 2018 12:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeAQM2Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 07:28:16 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:47018 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeAQM2P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 07:28:15 -0500
Received: by mail-it0-f41.google.com with SMTP id c16so8976684itc.5
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 04:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngFhyFbQDtL1X6DOajwqJJUMx/qnKH0nmkwXWW9D/+k=;
        b=FiJb39WJuirSMvxaVOGpntGVK9JlO8MeUfqWQqiRDOqZqq//kaYgkNB2pYBwpjWgAc
         6zFF0EIe6BrnjhIeyM5nSK00jYsO8NAQeI7TR/I/4dnZYECSszp3p4Dr0mPHmnYO05pH
         f8gN1/a0Y5FmuTHNiIiF8/UogcuPu3cdQvZNqf1YtSYNaSzr4hEfBhFImwnz9DSRpbKA
         ggBEaclthpbXpHtnqaaTUPOyfKbDTWgU9aSDxpZSnfd0ZxsqhPgpuusvFCGLqmomLYWe
         xsJbAmi16XjAb2tSMMJkNn/ZjAWJQ0EkCzM7qpamg+NkhbBTTpYjI2lBUJeMbME5pGik
         U9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngFhyFbQDtL1X6DOajwqJJUMx/qnKH0nmkwXWW9D/+k=;
        b=YPYbfc8YZ7nL8c/a8VVj2C5J7Sy4VZ0zHiftVBETqVBIA5mLq+M240NHNeY3+USDFh
         h9yqf+CD3ii6H+/wt5ZdMII0u1ViD2CJQ7B7ez9G1AoyGT9I3yHoD+Onc6nlblOr4r7l
         1U8Vi6MaFkEZzV3/PFMyIHWFUomPt7CMcXCqzsLxMn2zSwx0yoIfUQObJiges98Q7/yx
         nFCgAsqfAhkPYTCisoTXrcRROdQKmYzNGssUuEqDvadS74Wn7WlS3Remcy0OWRXlUuMF
         xFmOrNrSckw+zEoIJWpzZqC0x0v/PsQEi4SN1GVXWFEfwznt4Xpe6cKdJO/8Ssl+9SZf
         8bmA==
X-Gm-Message-State: AKwxyte8NsUQTQMVyEUx4FV94ZQTS0p9WCPdkbpBsfkIaJk6Ver8M1kB
        GRpAj+mCgBm6j+dFc4MCDe/NXtZF3A5uURDFc98=
X-Google-Smtp-Source: ACJfBov7rRWo7IWJNM5rHNFgl057qKtbpMZgFhY5dsyHW5Ewsh1245ZjDJfUphf0RwzI99fS5Kv8E+2DOW2xaVJxwiI=
X-Received: by 10.36.249.196 with SMTP id l187mr11916679ith.63.1516192095181;
 Wed, 17 Jan 2018 04:28:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Wed, 17 Jan 2018 04:28:14 -0800 (PST)
In-Reply-To: <CAGZ79kax5Hip1wP3U60im__Dm0GvH8nNd+ByxG5OxMXrRkRvdQ@mail.gmail.com>
References: <q7h9lghcob2s.fsf@orange.lip.ens-lyon.fr> <CAGZ79kax5Hip1wP3U60im__Dm0GvH8nNd+ByxG5OxMXrRkRvdQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 17 Jan 2018 13:28:14 +0100
Message-ID: <CAP8UFD0etLfmvAqHOpoUPWF3eTMJUQZZ4Lfqe+CxTJuQPU3T0A@mail.gmail.com>
Subject: Re: GSoC 2018 Org applications. Deadline = January 23, 2018 at 18:00 (CET)
To:     Stefan Beller <sbeller@google.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 9:08 PM, Stefan Beller <sbeller@google.com> wrote:
>
> I'll be fine as a co-mentor this year.

Great!

It looks like you also accepted the invite to be an admin, so we are 3
admins now (Matthieu, you and me), maybe 4 if Dscho joins, so our
application is complete.

We can still improve the Idea and Microproject pages though:

https://git.github.io/SoC-2018-Ideas/
https://git.github.io/SoC-2018-Microprojects/
