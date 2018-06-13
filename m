Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C2F1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 17:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935315AbeFMRnu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 13:43:50 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33516 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935163AbeFMRnt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 13:43:49 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so1179047ywg.0
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 10:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKisfqBmqvfhEmchE8X2Bc9WPsX/9xaWDPtfW0W0izU=;
        b=JJ3tb896nP9Uro7o0tlEl1ZwibmwC9DtDHV9UWlwC7G0g7RfcjNyL7oiTHT4smYiwo
         /vuQ2wu+wDrqw/BPMMBQ17AfVdrjtZSojY54grr22aoACkm/EntO1lWHv4XQPOI/IHvb
         /uxzghY8pQ1XambJsNCrRerCWgLkYrBgdJTxUJ1oY7cWbfN91gqbkIeV2n2YaHst7JBs
         Pzv8nLHry/RvxmikZlo7QyijNUyq8JYm48b963LbCv3R4xUhlBGF3Hkyg622E/pkc6fA
         2ej/f/SWvroENlf4w3KJr3lR0mpi2EAtxoGogzKgLxiGsXAlBMpXn6I0YuA5uEwx98Uk
         5oKQ==
X-Gm-Message-State: APt69E1Fs1vsQStWaVHr8WpXwXaZuoWRzjollI9i5Fdxu9NqpfP88KMk
        QGAjr6r+F2+UxJhqR0m9dXlBfNASnwFcyFO1Z5E=
X-Google-Smtp-Source: ADUXVKLJ8NNyob9Wn0tMIrUsfvK/Ma4WyGKlq5seJIjCftPwIwHL6JcE15rC0XHI81Y8sx8FYLbK1+W0pQDgY/oMNUo=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr2846393ywd.131.1528911828971;
 Wed, 13 Jun 2018 10:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180607051958.759-1-tmz@pobox.com> <20180613031040.3109-3-tmz@pobox.com>
 <CAPig+cRcPD9vh1WMX7UkiD9R_A-DrybvOYwi3R8U2bskfOV_1w@mail.gmail.com> <20180613172111.GH3094@zaya.teonanacatl.net>
In-Reply-To: <20180613172111.GH3094@zaya.teonanacatl.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Jun 2018 13:43:37 -0400
Message-ID: <CAPig+cQf1LadhKmyGoX8uYx5pAg5c3JPjxQp_=g9fibaXVAhzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] git-credential-netrc: minor whitespace cleanup
 in test script
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 1:21 PM Todd Zullinger <tmz@pobox.com> wrote:
> Eric Sunshine wrote:
> > Since you're touching all the tests in this script anyhow, perhaps
> > modernize them [...]
> > (Not necessarily worth a re-roll.)
>
> These tests were based on similar test_external tests which
> use perl. like t0202 & t9700.  Both examples use the same
> formatting (and use of 'set up').  Perhaps a later clean up
> can adjust all three tests?

Whichever course of action works for you and Junio is fine. In this
case, it's such a minor bit of additional work to modernize the two
tests in this script that it would make sense to do so in this patch
if you happen to re-roll (and if you agree with me), but is itself
probably not worth a re-roll (as mentioned above).
