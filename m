Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CA81F404
	for <e@80x24.org>; Tue, 13 Mar 2018 00:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932383AbeCMAQk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 20:16:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45687 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeCMAQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 20:16:39 -0400
Received: by mail-wr0-f195.google.com with SMTP id h2so10411595wre.12
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 17:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oAGEsS+3CXCVttAHaRZNtuAd/b4t9SmmQ1pJH9bZDNU=;
        b=Hzg4zV2BtZQLBfBpxvff/s6NmZyl3Omt6nxzNkgy+RAxQ938e+KQrO6+qrWRnlsTZl
         M1EcvlY/EhHo1Od/vwXQw2NN1HbkOmdvoD193gGd3r7XNcCRTfyyVE9VDktc60s95De1
         8HjgUcjj2qM7flVsStuW5FY0yAl5gBrvP3xwU2GnUDTfw0PqVttoxMQnbxwKWiSkD91A
         gyIy8EHGZtIiyMt/SKXiOthQqJGhf6kFfqy9bo4DalOogMtclWVqUj8OI98+L2N/3vQJ
         1A8m/Ow9kfVa3PMFFUadyKjBTVZWOZel6XJdGmgdVz8fs+h9lIVuoqAmhri6t1QPZUON
         Ok7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oAGEsS+3CXCVttAHaRZNtuAd/b4t9SmmQ1pJH9bZDNU=;
        b=b5z5yo1Klj2Efe7wqHhP4Tw0iHyOK1fLfHE4zuW+rPRxTGm0W2t/mzWdE7xeang0A/
         jXWQxm1F2dW+sziNCc+qCsXWpe7ZfRcCEq6Ejv5H7Zo7Tb9UNxd3hDGwB1mMkou0tgZX
         5KrSYh7yJfK4Iw+2Kyr/fFHbdhQEAL+HFJDxDuniQHy1TGCriKZYK51bLqiWw3x6i9mw
         gMltVUcue5w3S3B51Nief8CaxIFzAFhavSfYgFZGzBDeRQTZAffFuDf4+ZyEHSfJ+/1j
         gJRfuC0Fdaigw8pGVVivVRHDjS/i6Us6/QHSQwyApS50ZExovGdQtCqYk1IrApQxMBBe
         pmuQ==
X-Gm-Message-State: AElRT7Hsv7aWmYhTM4qpj44nttnMLRvQ/zhKQ0CTwsiBpFtUgObdoX7v
        51IDUgdlQKmOMwBPitz1/mY=
X-Google-Smtp-Source: AG47ELt68mnq+WeStJudnjZhHtqXbJxGehkiOCzUA1GaeXckMh5CMRvxz2nhQSm+YAss6REQFQRSSA==
X-Received: by 10.28.141.131 with SMTP id p125mr7000168wmd.0.1520900198455;
        Mon, 12 Mar 2018 17:16:38 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id w73sm5514226wmw.42.2018.03.12.17.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 17:16:37 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
 <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
 <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
Date:   Tue, 13 Mar 2018 01:16:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 12/03/2018 11:46, Johannes Schindelin wrote:
> 
> > Sometimes one just needs to read the manual, and I don`t really think
> > this is a ton complicated, but just something we didn`t really have
> > before (real merge rebasing), so it requires a moment to grasp the
> > concept.
> 
> If that were the case, we would not keep getting bug reports about
> --preserve-merges failing to reorder patches.

Not sure where that is heading to, but what I`m arguing about is that 
introducing new commands and concepts (`merge`, and with `-R`) just 
makes the situation even worse (more stuff to grasp).

Reusing existing concepts where possible doesn`t have this problem.

> > Saying in favor of `--rebase-merges`, you mean as a separate option,
> > alongside `--recreate-merges` (once that series lands)?
> 
> No. I am against yet another option. The only reason I pollute the option
> name space further with --recreate-merges is that it would be confusing to
> users if the new mode was called --preserve-merges=v2 (but work *totally
> differently*).

I see. So I take you`re thinking about renaming `--recreate-merges` 
to `--rebase-merges` instead?

That would seem sensible, too, I think, being the default usage mode 
in the first place. Being able to actually (re)create merges, too, 
once user goes interactive, would be "just" an additional (nice and 
powerful) feature on top of it.

Regards, Buga
