Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A46208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 09:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755093AbdIGJus (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 05:50:48 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34167 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754933AbdIGJuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 05:50:46 -0400
Received: by mail-pf0-f176.google.com with SMTP id e1so3009871pfk.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=c+HbjSW4y/YzNCEe/YSxTGWpqYh9N0sdqZTzxMKm9G8=;
        b=NiPuEdJ1XSQlq83X15tFYTg1ybfMkPKwMgPgPRvpjCs+FfkIDYPrEmcVLtATmPJCN9
         QSmgRkmHXPW6NSz3VK3lB8Fum80A84ko6O0bMwmJGyBQr7OSDmewcPItkBR+kVw+s4X2
         cD4dd05koqQcxPBjlnaWGREiKUvb/BwVVcIu2zeliTHMojq4laEM4ghHpbut6TX6Vovc
         nlVZ4GIVIWnPZVVkg3OzwtjwAGpyulOOYiq44RzIE2TFFaa2zklth6gUlcq7sYZNStKf
         oO5BjDFFMfP4T/cj7SYFR0dq/NibRDvYKuhnKUJztX/1orwDRQh+KNkD/ScS37nWYbBS
         GyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=c+HbjSW4y/YzNCEe/YSxTGWpqYh9N0sdqZTzxMKm9G8=;
        b=jMDfVhNFYLAOQFtaTXETBVkHoEEQIE5rsj4IMmDdjTxuVqhmgUpSf+zeNnx2Anuu4Y
         icT8zHHjH0oBpvFfCm8XBTwwj1AZgWcO9c/8Z8tRg9BSDFi+dwl7Yjz/41Ng/gQJIaLy
         6ac3TCeR6Z2YiyTdjYZL4qstEzlqWoF7Jmvpnro9Y9CDd9ZEeykBzLCa0rFnCWuh8VCd
         lWafKUAnpMB6Wf/B/8xGCzuX44rJ3yvRjKuoAr0mmAmGKNRVJ3RYoEn1Pt2mSjsd70/C
         bynLTT639UjTUcmIOu2ttFAFfEVduBj3HIpH1VfOvm/UldZqoORBAkJZ+jo4RMDITlbD
         FJPA==
X-Gm-Message-State: AHPjjUjMrs6hQtGn9am3z0wHNW5mk3e7IvjjYiq56rsimWrgJZaAXLOE
        THYmTnkIUOPQVz5qYJyLVbcKc3g2yQ==
X-Google-Smtp-Source: ADKCNb7QBPw41P+0lwC/j5WQ+Q2YU1nbnXNTZ05BiaPl9XkcfYTdIzzGqTzuR+GMg+tXpE8nAyqQXHk9DwI+uq5Eo1Y=
X-Received: by 10.84.217.214 with SMTP id d22mr2351757plj.389.1504777846432;
 Thu, 07 Sep 2017 02:50:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.154.129 with HTTP; Thu, 7 Sep 2017 02:50:25 -0700 (PDT)
In-Reply-To: <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net>
References: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
 <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net>
From:   =?UTF-8?Q?Pawe=C5=82_Marczewski?= <pwmarcz@gmail.com>
Date:   Thu, 7 Sep 2017 11:50:25 +0200
X-Google-Sender-Auth: tqpWOorJGyrAfnmxt4IrRBSlDyE
Message-ID: <CACNsYJ8rRSf5gNtnPS05CnYCYGmoBymbgH7UumuOuBz1jp6RBA@mail.gmail.com>
Subject: Re: Strange behavior of git rev-list
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. Any plans to fix that? Or is there a way to turn off this heuristic=
?

On 7 September 2017 at 11:47, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 07, 2017 at 11:20:15AM +0200, Pawe=C5=82 Marczewski wrote:
>
>> I have an interesting case. In my repository, there are two commits,
>> 'one' and 'two'. 'one' is reachable from 'two' (as evidenced by 'git
>> rev-list two | grep $(giv rev-parse one)'). However, the output of
>> 'git rev-list two..one' is not empty, as is 'git rev-list ^two one'.
>>
>> Here is the repository: https://github.com/pwmarcz/git-wtf/
>>
>> It seems that the commit dates influence this behavior, because when I
>> edit all the dates to be the same, the output of 'git rev-list
>> two..one' is empty. Pruning seemingly irrelevant parents also makes it
>> empty.
>>
>> I verified the behavior on git versions 2.14.1, 2.11.0, and on the
>> 'next' branch (2.14.1.586.g1a2e63c10).
>
> Yes, this is known. The commit dates are used as a proxy for graph
> height (or generation numbers, if you prefer) so that we avoid having to
> walk all the way down to a merge base before producing any output. But
> it can give the wrong answer in the face of clock skew.
>
> We walk back five extra commits more than we need to in order to avoid
> small runs of skewed commits, but obviously you can have arbitrary-sized
> runs.
>
> -Peff
