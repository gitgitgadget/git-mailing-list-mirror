Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE5D1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 01:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfJZBRS (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 21:17:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33227 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfJZBRS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 21:17:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so2271854plk.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKClsnzDXaPVThSHJVSnSaE1k4HnyKX79PaFw3JJVrA=;
        b=DiZEyXjSlBM3CUtR2w7twiSHV+Weychm9whuzW/OtHuJ+XDTSa6EoIMF2bdj5QF00w
         Hgq+/oEP5irpfD0AuhMv1ZNjhmjP4dY+WAVZ5WTZuTtOrraMl4TzmrEIVcKo5WvRiF1Q
         WHjWqn8POF9gWWjW0kuyXHGRAb1ZlWT8xV2w/uBwIAWm4PMiXi83DQ59XEbenvnzZmjF
         H4IPyQbMhmtI5CNFMsmwmPSx+AoWYUTEEardT8Q3WdGVvVxOj9APKKmIZbacJf6z6e78
         qwbQUPm8Gs4M5pKA+wUgbMA2g1PrkiTGBO7zi5s9Wjz1bXki1V/8om1DKATuaeMT86Cc
         UiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKClsnzDXaPVThSHJVSnSaE1k4HnyKX79PaFw3JJVrA=;
        b=XcbiQhl4eRmOf/JvvNUgt4Smqhq1Wg8vGBZBHyTMJQCVPQU/7GGFox3CTX4UlWtNMb
         hXknDChFLil4WVGQs8gxYY7VMayXnyrqxzgx6HEt4XiBbgHpRyQzCHe2CPEo8M22xBKu
         dGZuiVvIQLv7GmcbOt6aWh7UjzrFqbglbZVBg436OEsEyGGJ6hcIS4o2JghxVspjF8R9
         Hf0Da1EBYLyDAq1J57Oj5aE6o/4/YdzNmZbmOvWcjSl1nsTn3kHqqB5TRhrfTluCCJPT
         twSi2iKRlII52A01O00F4OW1Ykehpcxcc/phMT6IK6uE0OToFf7whs7IYaIcgDVO3gRO
         peig==
X-Gm-Message-State: APjAAAUCeYrKtIli4N5c1V5V+WnjDj+RNWw2NH/WhXklWZcrBb2cBBMO
        rYB5SRVE+CEigo25FzE7ytk=
X-Google-Smtp-Source: APXvYqz7NEKlzDAzYvM2kBCp7ZZhRBUGk1vmDpDGCAfq+Ht5O1ksfJJ/MRlJ8TN4i+/xBv9lQHXIXQ==
X-Received: by 2002:a17:902:8a96:: with SMTP id p22mr6795856plo.272.1572052637341;
        Fri, 25 Oct 2019 18:17:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id q23sm3054993pjd.2.2019.10.25.18.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 18:17:16 -0700 (PDT)
Date:   Fri, 25 Oct 2019 18:17:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] some clarifications to MyFirstContribution
Message-ID: <20191026011715.GD39574@google.com>
References: <20191026005159.98405-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026005159.98405-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> [1/3] Per SZEDER's comment, we should be adding `git psuh` to the list
>       of commands used by 'git help'.
> [2/3] Outreachy applicant Heba Waly indicated that the tutorial doesn't
>       cover dependencies needed to build Git.

Oh!  It's also a good idea to give these people credit for their
contribution, via a Reported-by in the commit message.

Sorry I missed it before (I tend to read the patches first and cover
letter last, which is good for ensuring the commit messages are self
contained enough to be helpful when the patch gets dug up in history
later, but not so good for noticing this kind of thing).

Thanks,
Jonathan
