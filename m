Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94671F667
	for <e@80x24.org>; Tue, 22 Aug 2017 22:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdHVWYV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:24:21 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:32842 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdHVWYU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:24:20 -0400
Received: by mail-yw0-f171.google.com with SMTP id h127so467836ywf.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+jt5jCZqqfpIUf3wtQUSc/fEU1q4Cnf4bvBQ3EKr35o=;
        b=tvhXNoVX3IDi99qcMUbIKIcmk0gn2mfBTbN73RWGRzA1J2mYgQ/mfrEd82kPdlnP9Q
         7t92jhR63H7mJxKXZZy2E1H37dXOybtS9n6N5vqy9P/11lhuFQK7RVbdiV2FzJ5vKUIX
         cApBXVheaLG1PZsHiWha9mFNuLF1SeU66Kazgnf4dbtz8BOWFrREyWInhVu6K/Y7+LDz
         pGeZg+GE6YvVJ6RrD54M4jX9SjwR/lyct5xM+XQ4HX1LdzCxqwTn5w/M1a+xL/W1182x
         XzxMWQRSkxA4w51e+zTLJVm8RmwThnd/z1fdgfsuOCNRBs8q2YYKWL5KOu4CVDDIKLkH
         aArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+jt5jCZqqfpIUf3wtQUSc/fEU1q4Cnf4bvBQ3EKr35o=;
        b=Piflq7YhQP9VAPYOj+MyG2A/FIMQyiQOQPsAgzBNQ1UXfNGjVMWH37pAQWseFcBZQZ
         T1LUd7PxxE0Pz/yNCMaW18tAdAvqIwUchp5/0fbXC8iEVqPElKYo/09ym90/uTiplrJK
         rijOps/LxR8s+7F7iCHwcLZRNkF1dAS23jp3jlmEwua3I1bbnVz5rQyjHI+vsjXR2nUq
         k7J5ma0R3kk6Sj+kbbZ9mt1n1MnN1Y+E4AoUHNs2XEodBb6eRKS5sV/NwpxnbRW851P2
         Hh42OI5zOPOctNHw9XDiO1/XjiIVPAQ+73dQU3Lk8q6Kqa7QsmXMlhWGXQwfNWE6Wn/u
         BwlQ==
X-Gm-Message-State: AHYfb5gGdj/hFER8RQdrSm8bpAsT3UtuS+Ya6b0FkWZIewkHewjvR67p
        MB9j1RITKNpRFfH31bU+flfF3+JA2VZs
X-Received: by 10.13.218.129 with SMTP id c123mr466159ywe.175.1503440660037;
 Tue, 22 Aug 2017 15:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 15:24:19 -0700 (PDT)
In-Reply-To: <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
References: <20170822213501.5928-1-sbeller@google.com> <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 15:24:19 -0700
Message-ID: <CAGZ79kbMc+kVsc2-fBfOHVZvvABWnDpQfs-hqLCxb2FTTr8YCQ@mail.gmail.com>
Subject: Re: [PATCH] vcs-svn/repo_tree.h: remove repo_init declaration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 3:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>
>> The svn specific declaration of repo_init was not used since 723b7a2789
>> (vcs-svn: eliminate repo_tree structure, 2010-12-10).
>>
>> This was noticed when including repository.h via cache.h as that has the
>> same function with a different signature.
>>
>> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> It looks to me that this is a reduced duplicate of what brian posted
> yesterday.  The first two patches in the 6-patch series that you
> commented on, I think, covers what this change wants to achieve and
> probably a lot more.  I've merged those two already to 'next' and
> was about to push the result out.
>
> Thanks.
>

Ok, thanks. I did not remember reviewing those.
(I just wanted to fix my odd compile error here,
and currently I build a series on top of jt/packmigrate
so I shot off a quick one liner)

Sorry for the noise.
