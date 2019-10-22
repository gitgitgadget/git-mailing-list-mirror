Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E2C1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 14:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbfJVODj (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 10:03:39 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45571 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387868AbfJVODd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 10:03:33 -0400
Received: by mail-ed1-f52.google.com with SMTP id y7so5454976edo.12
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUqTqRxl7+N+Ipp5S5psUD/Xu4Yu02L4KkqfDVWhzQY=;
        b=XAIqit4uf/iv0oQAVq6NEcHqhlF7+UgoNW90N6ilpDoWtuFGg/C4S0kUI3UKAdGcQD
         1xSaEewDyu7MatuFDWAFxD+zeDKGoy1T6+TEyK8daSu4QiwIVsgsObYIyHDqcXBLshkS
         93Px3eHGW/PAzCcedhwkaL+Myi/ptJBanZ8NOBbBadMq/pWT5qwpGmN9S64PtjR3BrwX
         zfU7R8Q2obJ4bS6UEYHdXersT4V6mC/muHlHrXgOuPTKjCUXM0drTqJhqEeXH5MksU/J
         9RMYlLf+uADCoMeLJVHwvmRs/DTFSe8UWt8sEhcMogdNyYke0+UNBirs6bIHVBSK1s5R
         +k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUqTqRxl7+N+Ipp5S5psUD/Xu4Yu02L4KkqfDVWhzQY=;
        b=H8XMoUUCRH45uLYN7BPd8pIQiRiUk0CoTrjFRCIKyqV2ATjzOx+xBQqX0GcUOm2yhR
         dSdWla5KS3PJs+ce4yXHZvD/8k+8atmcu7rUgdgRJGySTqtNIBnmy2JMT3fazM2esoe/
         2eoZpsf1nGdNtyjuFVYw2XCIZGmR4mG940bvUG3fMpnJ17DANhi0NJQvsXdj0qZddO9a
         lrMQH/0IwpH9QBA8BpGzhRpaY2njOUUpoCDBC+5pQDSzHjJgK6IcdESHi9VT02uthIGN
         oajPUVg85WhFY8PjQP6Pta7tJqej5OUGdaZUWOGqL6BuhMtZ0qkvXzTC28Ea7WZXCDWg
         spbg==
X-Gm-Message-State: APjAAAVlxaaFYcZuNs65uHB4SrEKQq2JTa0HBhcys9HmTY+NECDPIuua
        ZPby+pAGdJY6KlICkhX8QwCuEjaLntuLOn6sYZM=
X-Google-Smtp-Source: APXvYqzB1qDiSPKHpywp0uABm3EyMG8OlbF2tO1az3j/Bn4JaZvmZ2beuDIN8BJ2OQs13276lEFL3xjKjlQA/vn9c8Q=
X-Received: by 2002:a17:906:4d4f:: with SMTP id b15mr4672820ejv.81.1571753011452;
 Tue, 22 Oct 2019 07:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5WHwZCoXtJ5an-8hnHfMsFxKyr6YfHFFg0Pm8Yt5DtrQ@mail.gmail.com>
In-Reply-To: <CAHd-oW5WHwZCoXtJ5an-8hnHfMsFxKyr6YfHFFg0Pm8Yt5DtrQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Oct 2019 16:03:19 +0200
Message-ID: <CAP8UFD1tXV9Mof+HfwqPBB77zDTmAhAjhuyhzuS7MSQ1KO8-zQ@mail.gmail.com>
Subject: Re: [GSoC] Follow-up post
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Mon, Oct 21, 2019 at 7:14 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> I wrote a small follow-up post to talk about the conclusion of my GSoC
> project. I believe the main remaining tasks are now finally complete
> :) If you would be interested in taking a look, the post is at
> https://matheustavares.gitlab.io/posts/gsoc-follow-ups

Thank you for the follow-up blog post!

It is a great explanation of the work you did to come up with the
current mt/threaded-grep-in-object-store!

Best,
Christian.
