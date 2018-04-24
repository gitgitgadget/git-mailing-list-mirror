Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF34B1F404
	for <e@80x24.org>; Tue, 24 Apr 2018 10:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756676AbeDXKbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 06:31:52 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35328 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756653AbeDXKbs (ORCPT <rfc822;Git@vger.kernel.org>);
        Tue, 24 Apr 2018 06:31:48 -0400
Received: by mail-oi0-f45.google.com with SMTP id a6-v6so8124883oia.2
        for <Git@vger.kernel.org>; Tue, 24 Apr 2018 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VxUcQN/EKmRuEY/EwElFvpSYKK5I71ZD/BFvWRFy3WY=;
        b=vclQMgZSzXYvD6BuWAxkKFzVvyuCL/BB8lHKIsdauBBJciTPHBpQ2unXV+5U40k6el
         jamBVqy5gmD7bxAecn42yAd5AwuxOZyLLj4dDdgByBMgyvfR/MeA2NT1dxdjM/e30hhx
         5//aXohSBce0AUs1MUTktTYwC3OKbLIPQ6QfF8T8cMjIaP3HXhr4s/IU1rInhF+VWc0j
         7tcpyMO6GvQH5Y3DK2Pb2OoxHtbXTCGYM/s/8tN5fkgM06xFI+DroLH8fEpIL+AHz+Y8
         nNZJ2sTYPVXtieljYw4pmLDMBj09/CWs+ng20anqYf/VcqAcoJXXh2FrAmuTx0euY8tC
         Z+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VxUcQN/EKmRuEY/EwElFvpSYKK5I71ZD/BFvWRFy3WY=;
        b=r3D1IV4FFQ6Yq00rofHI0sYy0QNQJp++gE7bJSjRAL1gn8Qvx7pMSG74J9SiZk10ki
         e/Vjcm8r4IEfOobHG41KAQ+9y19CQCkGq1RuksSiVovE5pZ20O3g3NGm/iN0w7TzaNrx
         nn43MSEsTvHHobVc5/NOqjHnH2z2ncrWJKyJ1VaOeCwSbzMVm5f1/BoW4m7DTirnB0g4
         6Jguwfp0mZi+Csf+XSFbbYkS3QWs8SpQ4pQ+lBwszPr6qlC2OKa/DSKHq2/5gghbBLQA
         z2Z9oJ6L3XpXBMqrvEbvhZTbfNppJXwMU7LrcZ1mr/uGn2MmpeJzSDC2rTLoSw4n7My6
         kkfA==
X-Gm-Message-State: ALQs6tCbqtfGCanQiwoXRGX2WBx5ISHkuy2/4dm8mWcshxKUyDyk2qvx
        w4Hppl9BMdSbvb9Pipidg7YuPyOCVCrutIVTk+w=
X-Google-Smtp-Source: AIpwx4+4XJtNHNJ+evHtIym+ZYxign37xVkbUjV2Bik5sf/akgtQnhhM+sM+WJD4Xzs+ZXvv/D+6Mp8fkhcWoet6B/c=
X-Received: by 2002:aca:5751:: with SMTP id l78-v6mr14269375oib.171.1524565907668;
 Tue, 24 Apr 2018 03:31:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6058:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 03:31:47
 -0700 (PDT)
In-Reply-To: <20180421062923.4467-1-szeder.dev@gmail.com>
References: <CAEbJ=SN0h_eO+0CJQGEnEafhzgAYdgXByUqb_vsC1rgGw7jNAw@mail.gmail.com>
 <20180421062923.4467-1-szeder.dev@gmail.com>
From:   Vladimir Gorshenin <gorshenin.vladimir@googlemail.com>
Date:   Tue, 24 Apr 2018 12:31:47 +0200
Message-ID: <CAEbJ=SOkfHHrmbUXP_niRP4S0HSENqXriGWNFoYX2XpdvWzZww@mail.gmail.com>
Subject: Re: Git archeology
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Szedar,

Thank you for the reply! I didn't expect it could be so instant!

I checked 'git log -L' option and it seems to the best one so far. But
nevertheless is has a pit fall: I run it like 'git log -L ,:somefile'
and get the output that needs manual scraping since each commit spans
the whole file despite only few lines were actually altered.

I would like to have an output form 'git log -L' in patch style. Could
it be done somehow?

Have a nice day,

Vladimir

2018-04-21 8:29 GMT+02:00 SZEDER G=C3=A1bor <szeder.dev@gmail.com>:
>> And there is a problem, which I believe is fundamental for Git (please
>> prove me wrong): how to find all overlapping commits, e.g. touching
>> the same lines of code?
>
> You might be looking for 'git log -L'.
>
