Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9901B200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeECAr0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 20:47:26 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36312 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeECArZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:47:25 -0400
Received: by mail-qk0-f171.google.com with SMTP id a202so12743880qkg.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 17:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IOKG7Yz/SVq73ov/xerqgSlLyEnkgqUM52iiLiLjto8=;
        b=scEJ1DY9cQH16qto/7/157vNkq+J/hQTXdL4RHwJE1p4VKJp+c41Leif7A11kNEbRr
         bJA6txtRybijNBRgD1FnVlkCEfp+8hxCMex+M+RJLm+qdqiZ70uqtwhm5J5a9ZEr68vI
         bAup95RPmfY20E7UtMUC8oI3DFQIe3L20I0T4d3mbOLlbaOf5F9j/LQ7fk8L9pWuNQyn
         xrmXGooFB8zvEGf/bSLp6LyYjAbmXIPPO6n7gxDFuzN3t7Y/hfpeCCu78Ze4Sq+IG0hn
         yutiNVMkqTaP0ygV1FtVjolOK0luy+cbdcMtCEJkPNr8FXMEvGqxG37y5yovbG5PyuMr
         ZtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IOKG7Yz/SVq73ov/xerqgSlLyEnkgqUM52iiLiLjto8=;
        b=UqQqnRIsEBFMyP3b6cxsO9/XW9npeXpfPYzp4YBbbiDtNaX3yNBv2f6QUqE3+C6G6m
         00ePCQ0khAF9Fv2wmoC+zIxLwAjizFqzZmyVDfKQxw/PiptYMXryE7s2upmbZ1bsOUye
         WN4AqWRzypQQ4Tvw415M3+jv7k90qPxDHWNkDVBw8VagEkTjWdsILTgm23PwUHPDHtV5
         MT84ZynSlUW1kcvMSfe3e1umwAIvjlTJgK9hz0O8xSxypMzEmnG4rRBGrxn7hjflNVp0
         bxEjMFi8oGH7ab9mQ2saQCcZw0/cQNwB6kSWUCKmhCcWVre/qAxzy8IYMDXc4g927Npz
         JyEA==
X-Gm-Message-State: ALQs6tBtUhevcj7qraFuZxVI56Ht5tckK0EEaZyBHOq8pwOAZ0BFEViF
        WvY1HpGyLOIzbb2LGCEF1Ge5rzuBECjrx3w2HQ4ccr2r
X-Google-Smtp-Source: AB8JxZr6OUOUQfT+84XuxGpwHzCJFizCWr62fhNbwsHYp8IDLmZdntTvkAc6Dg2c01jbQc/FhUu8c8sRYAa9KouotbI=
X-Received: by 10.55.166.215 with SMTP id p206mr16359809qke.197.1525308444787;
 Wed, 02 May 2018 17:47:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.59.82 with HTTP; Wed, 2 May 2018 17:46:44 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805020912210.73@tvgsbejvaqbjf.bet>
References: <20180502033925.6744-1-predatoramigo@gmail.com> <nycvar.QRO.7.76.6.1805020912210.73@tvgsbejvaqbjf.bet>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Thu, 3 May 2018 10:46:44 +1000
Message-ID: <CAH5451mJO3Bgg9DST57fqcGGU-SPrcSECjXi0qOqeKsW0uaRzg@mail.gmail.com>
Subject: Re: [GSoC] Info: new blog series of my work on Git GSoC '18
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratik Karki <predatoramigo@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 May 2018 at 17:12, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Pratik,
>
> On Wed, 2 May 2018, Pratik Karki wrote:
>
>> As promised in my proposal, I've started
>> to write a blog series of GSoC '18 with Git. The initial blog is up.
>> You can find it here[1]. The initial one is just to get started and
>> from next iterations, I'll start detailing of my work towards converting
>> rebase to builtin.
>>
>> [1]: https://prertik.github.io/categories/git/
>
> This is awesome! Thanks for doing this,
> Dscho

Agreed, was fun to read.

I'd encourage you to post to the list when you blog, or perhaps
include a link to the blog as part of any regular updates you give on
your project progress.

Would also make for an interesting addition to the newsletter.

I know it can be difficult to sit down and write about what you're
doing, especially when it feels like you could be focusing on 'real
work'. Hopefully you will find the process rewarding; I'm looking
forward to reading about what you find easy and hard, how you learn
the git developer processes, and the challenges you find in converting
shell scripts to a built-in. I'm sure other people are too, and I'll
bet the ones who have been there before will have feedback for you as
well.

I'd find it interesting even if it was a 5-line bullet list of what's
going through your mind with respect to the project! Looking forward
to following along.

Regards,

Andrew Ardill
