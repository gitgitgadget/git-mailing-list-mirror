Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08CC1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 00:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeDFAUm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 20:20:42 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:41665 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeDFAUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 20:20:41 -0400
Received: by mail-wr0-f180.google.com with SMTP id s12so20562191wrc.8
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=azdx9wmb5yIQ1ujZOaAbay8uAa9FQ06AlJ9Yhz4nEYU=;
        b=DNgLG0kEzsh75d1pq/G+CnT4zqIwfhHf7FWauV+rndqKFzTmnVtqMV+bqPq9Y+B7OX
         KskX/XRXJ55k0DlsMhwxvCi42rYruU5v+zjUOS0+/wUAN1I6LNPEbIz2vroVtuUlbbf2
         fgImt/8nAzIx2QEBun7wZBXw4VP4BFEgS5V5K7BqqCy8rY5iy+/mB7Sw5/xN3pcFu9/J
         dqLo/F8hywszTVISk2oloDaAJNDUeuukcalh/F8SSHgW1uVwQPrJQz5Nw+xx6lIvFDqC
         r2SSjVJ5CITFs9MG1MnLIFh3qI3mKGEBgoFK3aSb7bheynhdZsZlzS+v/f5mzcAwiD6K
         d+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=azdx9wmb5yIQ1ujZOaAbay8uAa9FQ06AlJ9Yhz4nEYU=;
        b=A1cDAKA+2krT4VN8YMPgrZJfFmUUu+H0hOzNhYMCg6IZVlbAe/R13PvAnhPweRwn2B
         dG+dA0B/iBSoSIS0bQWzqkimhzoFje5EtFOXs5U3mJ7ihniTFblMePD3R6Y0wIn50Ydh
         M10JAKWihKl5ehbBRw/UROn1+fhafxXT+mSzE+mrzslxuCep0CNuNxWaUSj2C5N1bIz3
         RBv9QN8su0qJ9dhBfSzm7wuoxCyQL0R3oGYOhfP48sfDHUSf4YJQlgOENdrpS0B//NtE
         Ml8gg5BZ4ZrOdOnVxH1+C76RlLw+sRQLcB/pe0dl8saL2xnVgGrnzUlHYxjNMZwVDo3v
         cZUw==
X-Gm-Message-State: ALQs6tBuQTVm9cH2NiS4L9vATECUVhaD9FDBhdR/BdS7W5CgW8airvX0
        Aq+KlHifOv5I+qWkVbar1WJmyLuj1hv22SS8tu6Khg==
X-Google-Smtp-Source: AIpwx49KQF879U7GOLi6cJld5Al4rLxxLcpueTz/l1iBKlAmmiOit8qHKmMsx7bKaX2/8XXm9zuaZECrfumDY5cQVuw=
X-Received: by 2002:a19:c1c8:: with SMTP id r191-v6mr14038490lff.45.1522974040401;
 Thu, 05 Apr 2018 17:20:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Thu, 5 Apr 2018 17:20:19 -0700 (PDT)
In-Reply-To: <CAPig+cT6wq3=0ychBH9+YharVvX8KNFLStdb8wGG33o_Lungyg@mail.gmail.com>
References: <CAKk8ispGB2cxCxVpmabf7ASU3bSTLdMPbSQeAdYNom_JL=O0Bw@mail.gmail.com>
 <CAPig+cT6wq3=0ychBH9+YharVvX8KNFLStdb8wGG33o_Lungyg@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Thu, 5 Apr 2018 17:20:19 -0700
Message-ID: <CAKk8isoHq0KTUfKuuHh=6HzV5ncBryatR6GiPoXYDngF5xjQSQ@mail.gmail.com>
Subject: Re: Errors testing on macOS High Sierra version 10.13.4
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 2:33 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Apr 4, 2018 at 1:06 PM, Wink Saville <wink@saville.com> wrote:
>> I built git on a mac osx laptop and got some errors when testing.
>> I ran ./ci/run-build-and-tests.sh and three of the tests had failures
>> that appear to be associated with character encoding:
>> ...
>> Of course on travis-ci there are no failures so I dug deeper and found
>> that travis-ci is running 10.12.6 (I added a call to system_profier in
>> ci/run-build-and-tests.sh) where as I'm running is 10.13.4:
>>
>> Not sure, but maybe I've got something configured incorrectly.
>> Suggestions anyone?
>
> I'm still on 10.12.6 and I don't plan on upgrading, so you may need to
> dig into this yourself.
>
> Try narrowing down the problem to the exact command within the test
> which is failing or giving unexpected results. From there, it may be
> possible to identify some difference between 10.12.6 and 10.13.4 or
> between something in your current configuration and that on Travis or
> elsewhere.

OK
