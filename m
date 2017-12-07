Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602B220C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdLGAIv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:08:51 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40870 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdLGAIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:08:50 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so9964096wmf.5
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 16:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=G/dKJNQm7PwKq2bMFf7iiiCvBZO2SCxOG6VH+nz4yfs=;
        b=AJie7n7zzrF4irmqgKiujFYURieYjppNLWgPw3RsMAN95GGU+tpiayJK13Vq1bSciD
         tfEXo7cBSnF5NlcWGs4kIlEJjNOyte6VDhGMuRcam23kMEnCDmMK6bddLg7ncReVNwQ1
         OFkeVexsvqEESPf6mkUVq5hvcScu4LT+XkyKa4o/NNEOi3WOYTIVF1OWx6oaKcIGaUd2
         y7AEJcxI2rlXZVhKUxWecBdRfSrE5ep28+GGp7CJtXjGkHhrioHhOdzf2d9L+b//TkVW
         GvzgqV3Wb8zX4mvEICD7yD8WWY4dd+VDUjgUkDTPc1MbKMdYnF3r464X0B8p/fBvFSW1
         jRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=G/dKJNQm7PwKq2bMFf7iiiCvBZO2SCxOG6VH+nz4yfs=;
        b=RKRHmN9fea3qscJllbbPx2bLV4xxGl2//7ooXrZtHskau6nUX/9ZYN7E//FoVX/PJd
         ukwpeeigGfnMvf5abAubUqAf+dNGgVjjBFHHi1QYatgsSDa3IK99nQ98gTdNEqNSyxU4
         KaHJpGDAVP/aYU3ocESYT/by3J/XCKeqE/mmWrnO8TUkreJQe8VjTf92iOFOAMmXJ+6v
         CRW/vcXpL5EBsch0w9YtFVa1dnW+tvpKHHcZU4/B4GE+1kw/vwys7OWNu8hJGGw8nQIH
         caUQLR9ewW3aytId1Ha+iUjBMZaI73TZY/HVONKoN4bDfys4jX9HWW1mJRXk6JaBq4jy
         VH5A==
X-Gm-Message-State: AKGB3mKZZFrXrDQ0YxBbIAaA1mb3o5D5Pkb1femzqq6z5OX1vUiqRn7R
        BKEnAcuVeyNvFpYHfRak1/B1eT/SlEv5asuln28ToQ==
X-Google-Smtp-Source: AGs4zMZuyiIOfL2EgXUvNausULo8z8Cn5IuFtK12fO/EOTN2aG4/vE8ghGXudv+xwqU7qzmX2j0H18IBFsRBXEzE6yQ=
X-Received: by 10.80.176.70 with SMTP id i64mr834364edd.187.1512605329407;
 Wed, 06 Dec 2017 16:08:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 6 Dec 2017 16:08:28 -0800 (PST)
In-Reply-To: <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Dec 2017 16:08:28 -0800
Message-ID: <CA+P7+xqdJjxFDSe61BTkkxE0RF6-n4OCCrsL1ZbViXnJcAqE1Q@mail.gmail.com>
Subject: Re: git commit file completion recently broke
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 4:01 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Dec 6, 2017 at 3:53 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Hi,
>>
>> I'm still investigating, but thought I'd send an email. I recently
>> updated to jch branch, and found that completion for git commit does
>> not work as expected.
>>
>> If I have a git repository with a modified file in a subdirectiory,
>> then git commit <TAB> produces the name of the subdirectory instead of
>> the file names.
>>
>> This occurs regardless of where I run the git commit command.
>>
>> Thanks,
>> Jake
>
> I think I narrowed this down to "git diff-index --name-only --relative
> HEAD" producing a list of files *not* relative to the current
> directory.
>
> Thanks,
> Jake

I've started a git bisect to see if i can find the source of the problem.

Thanks,
Jake
