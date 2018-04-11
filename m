Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE531F404
	for <e@80x24.org>; Wed, 11 Apr 2018 23:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeDKXw4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 19:52:56 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39315 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDKXwz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 19:52:55 -0400
Received: by mail-wm0-f48.google.com with SMTP id b21so6679991wme.4
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FQHZHeHlAzaotDXOJ3bizsfFiwD60gUENtGgVZIkCRk=;
        b=SclQ2fjyrnEEGPym9rvJJ0qkLukAZLhFUjBjxbww53tX3UOpJlO2LE8IdU8rbRD6df
         vU0ZhF7l7JcTNAEZGZ5ui8iZ0C3IaZpT/DJmPmHG8E1VEolrZcWGb1l3XSQCXt4NbrxV
         1S0ZPR9TreH8xODax6sCpfsfmteIFQf/cIUTxqYj3KhMGHZZtbZbPOsjjE1gWfILgNR3
         5Uc+E+3Gr4XANoH+m6jqBEvtSzrA1bpY10BNaskfAos1YDnHfTT/lHWS+34EuDGaUkxm
         Pk7oGFoEmoNeJFkASW4cquo6fXJcYsTbKjMmooLRZxddinrbyr7ca+xDIS8mpNC0MO36
         pHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FQHZHeHlAzaotDXOJ3bizsfFiwD60gUENtGgVZIkCRk=;
        b=SHseFdrTYJduyFmI0GECoR38ip6qMf8NejOZhNsjfRnn2wNzieBecbbEklHlFwhch+
         DbZidCLAFogu3A+9O8hN4qDbn5jF0mXFh1+5EwapQmFjhsoN30bzt/LRIcewuOivkpBy
         8YuJgAoUvuY3sSTzQ2GwMQnbU9Igv2jBN6XGNSKxzJ0NeOq3jtX/THF/dZmhddTpgr2e
         tYwQusyBDHLXxL6qNkhuIOoJ1CH2nojhumtL/EPzM2hGVMYpa8kwDDI8dKAGiQ1ir2aO
         +2RwI/5vLucKYV9N4tpjO33UA0lcZvkos4tpHsDxFtbIS/S6u974pbZo2NkZQRc2X7eQ
         qFPw==
X-Gm-Message-State: ALQs6tAMTVZrNvAW/8c1unlzw664cqOGzuMTcmdAqP9STNjJjxKLHW6O
        /mfXYfYt81BewjLT25qR+OIbmUfI9TiKpY4+LKs=
X-Google-Smtp-Source: AIpwx4/gdMYcv0UA/7xHkmWVk1D+VRkXT83Xo8oA26hfb2dmwLwOIMHRpsZISTD+5xGQ67gbHDQjqm7tOezVqW1LWqk=
X-Received: by 10.80.172.196 with SMTP id x62mr12229842edc.265.1523490773986;
 Wed, 11 Apr 2018 16:52:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Wed, 11 Apr 2018 16:52:33 -0700 (PDT)
In-Reply-To: <87h8oh51jm.fsf@javad.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sfm737e.fsf@javad.com> <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8oh51jm.fsf@javad.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 11 Apr 2018 16:52:33 -0700
Message-ID: <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 6:13 AM, Sergey Organov <sorganov@gmail.com> wrote:
> It was rather --recreate-merges just a few weeks ago, and I've seen
> nobody actually commented either in favor or against the
> --rebase-merges.
>
> git rebase --rebase-merges
>

I'm going to jump in here and say that *I* prefer --rebase-merges, as
it clearly mentions merge commits (which is the thing that changes).

I hadn't mentioned this before, because it was a suggestion that
someone else made and it seemed that Johannes liked it, so I didn't
think further discussion was worthwhile.

Thanks,
Jake
