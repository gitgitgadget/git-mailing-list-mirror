Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B79D20248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfCUTEe (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:04:34 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:34917 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfCUTEe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:04:34 -0400
Received: by mail-it1-f173.google.com with SMTP id w15so5841315itc.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgvl5UZ8RaH423RjXIan/hLNh/mI/tzJkmPvTOI0LlQ=;
        b=HgS3Z6Cj3kRRChFejrr4iLlSdgyQ0MmSVr12TGFzfqGTCHjPU6TlC6Yjg+yNdDievX
         Nc3bzzWDZs5+mjqDkS6SwLMr7viqDFMQcDyxgp6mx6P3D9dyUWoIZGlSX6OKAjzhpKDC
         YY8HGg4nwlMYj14x4HTIpffQcD5+r8lMx53x+g37Y6NMW/eBL2p4PwG6Az7TFjrnB105
         zDoZJxYv9LXlwjHajKRCBYh93CZiyNVEgJGoPYAgzJnX6W9tbAQRu3Ytq4Ifs4TmVjvr
         CDHuNtAaGQc28Hk3jX1M4gfQ+b+z2LeSNbDUYa3UH8f21j1UaVrLxbLTa+bU2Yz79wfs
         Mezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgvl5UZ8RaH423RjXIan/hLNh/mI/tzJkmPvTOI0LlQ=;
        b=e+ZERVKL/gLbxb8GkgN3uuYzyx2gJ8dKU6dRqlOHH5mj1DAvD07WH6Rr2EGspPF67C
         qO9ORxBSvfissdX1rEaO2RDrwFScTjUoXZYbV8TOEL2pEXlhbLwb/ehBaY19z6qVYjCH
         YxMflJsaxOh9jfbrDKEs5L9wdgIGBGQELZp0lBdAQ7jxJN6r04hDKx7dZGAfYrfC94zR
         Bs61Zv6lYQKAwsGqzOll7fWQKLb19laalORAKilVcPcNWYN17JFjRJ8Wm9//wfrA94MD
         wxIQN2MkVeq1aH0ATds0Zgu65bfw0Ant1hQKdgB9ikKyz89D/R+o0oHM5DwjxjloqkoN
         CV3A==
X-Gm-Message-State: APjAAAXCMK0QmV/M3v9HjFHP3wKsG3Lcl/924BfDjJ55mO7ndG0mSPUH
        e5x36CkjKfn9Kx0FlFlKr0HTwwOPil9OVj/D2X1jKw==
X-Google-Smtp-Source: APXvYqx83UcOLOY4bWxqRR6hlwQfRPH6TDkwfOF/nckH/NpS0EUQt31o2tlhbAMzlxLHZZGg17y0sG6vAV2+K1/iRdw=
X-Received: by 2002:a05:6638:1a:: with SMTP id z26mr3775772jao.99.1553195073098;
 Thu, 21 Mar 2019 12:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
In-Reply-To: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 21 Mar 2019 12:04:22 -0700
Message-ID: <CAGyf7-F4vvzwVsdgtiog+xvwgHgYkNMKQ59bCxrZYtdn+eGAPw@mail.gmail.com>
Subject: Re: Strange annotated tag issue
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 9:59 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> I have a particular tag in my repo that shows 2 annotated
> descriptions, which is very confusing.
>
> The command I ran:
>
> ```
> git show --format=fuller 4.2.0.1900
> ```
>
> And the output:
>
> ```
> tag 4.2.0/1900
> Tagger:     John Doe <john.doe@domain.com>
> TaggerDate: Fri Jul 18 10:46:30 2014 -0500
>
> QA/Internal Release for 4.2.0.19
>
> tag 4.2.0/1900
> Tagger:     John Doe <john.doe@domain.com>
> TaggerDate: Fri Jul 18 10:46:15 2014 -0500
>
> QA/Internal Release

Not sure about this part, though I notice that the two rows have
different "TaggerDate" values by ~15 seconds.

>
> commit 2fcfd00ef84572fb88852be55315914f37e91e11 (tag: 4.2.0.1900)
> Author:     John Doe <john.doe@domain.com>
> AuthorDate: Thu Jul 17 11:20:17 2014 -0500
> Commit:     John Doe <john.doe@domain.com>
> CommitDate: Thu Jul 17 11:20:17 2014 -0500
>
>     Commit description
> ```
>
> Why does it show two entries? In my `packed-refs` file, it also shows
> a strange revision for the tag (I expect to see just 1 SHA1). Not sure
> if it is related:
>
> ```
> 66c41d67da887025c4e22e9891f5cd261f82eb31 refs/tags/4.2.0.1900
> ^2fcfd00ef84572fb88852be55315914f37e91e11
> ```

This part, though, is normal for "packed-refs". The first line shows
the annotated tag object's hash ("66c41d67da8") and the tagged
object's hash ("2fcfd00ef8"). You can see that "2fcfd00ef8" matches
the tagged commit output by "git show". The leading "^" on the second
line is how Git knows the line identifies a peeled tag's target rather
than the start of a new ref. If your "packed-refs" starts with
"peeled" (and maybe "fully-peeled") then every annotated (or signed)
tag in the file should have a second line prefixed by "^".

Hopefully this at least resolves part of your question!

Bryan

>
> Note I'm checking all of this on a bare clone (used `git clone
> --mirror`). Can someone help me understand what is going on here? I
> found this issue because I'm trying to do `git lfs migrate import`,
> and it isn't processing my tag because of this.
