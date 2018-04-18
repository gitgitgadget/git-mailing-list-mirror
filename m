Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CCA1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 13:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDRNJu (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 09:09:50 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:45074 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeDRNJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 09:09:49 -0400
Received: by mail-wr0-f176.google.com with SMTP id u11-v6so4662914wri.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ow9xYMVpKNO864Ah6edQNhKlU2S499z/BAY+Xvjj86E=;
        b=ORbSzdZd/DbqzBRRsDeTpnGS0qD6RkVS0FrrM13OmEjxsdZJx9sVLFLaO13z9rQ7lw
         6tJKXdrfHSqyiaj4JRg49E9/KZqAnqvgJDfzmNW2hhLQa5PQZWJWa9D8u9tGuYWkcwUJ
         WZ921L2bGN97CD+SjEMrw/6yNmn2VaCCotpbHyERQFlUpsJlOIiE4+p7psH2efrC5bk7
         YKYSGC8T1r3Nb+P31cdcaclMpfsrCLhlf9Ij7U4gxr1bgkY+XPRe+WDhk3WtiWBWglWL
         XROQZ1cbGZ+CAB1N+SPY//kE2AAiykksKuWBkIi1z9P5uarjHD8rdGN0fYSfKsFT+Io0
         ewXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ow9xYMVpKNO864Ah6edQNhKlU2S499z/BAY+Xvjj86E=;
        b=qLdG0gkn3oowZKi/WzxrpynBP1+y4EAJ36+AbVnGdhLrqZg3xsdMcvIi9XVJH/Spy8
         NtLOidJ7pCcWrHLzKl/ZRJ+WsAZ5yb0cVoaejz1lHMuFYQLJrU2Jtrs1FlBt9LAWcuqn
         syJMrh4fDITzhD2tOdTZ9dNb2nUxwBtAe0/omPrUYSAjVUoITYJicm55d4Dz0UIVAkMl
         Z9cQ39yLLb3NPv8vwngG2sLr46WKii24F8ieI9zGFiWHo1/yeACfPwsJqsPxL18Wl2Ms
         i6VAmZCNMRjtCL1F9XeiEDGX9Tu6kjT6KJ6vRopqfOEril9bvginF8XC8cX5ymAOFd9r
         lzHQ==
X-Gm-Message-State: ALQs6tD+lbAV3Gx2J7pqjpnJOVwctZWUXL8yXyaf3+wP/x4wkzT8ZR5c
        Hl0Bd2kl1fx0K4BTeVfyMboA5go/PWeH9ardR+owTg==
X-Google-Smtp-Source: AIpwx4+4kPUeF3UaMjOgwO+hpzMc4t6ixV4GHICPMwwoKhJoShMdAgSDzoPSkpFpPKJi5OZAe397KOrBoL3YOvd8+vU=
X-Received: by 10.28.134.138 with SMTP id i132mr1723626wmd.101.1524056988439;
 Wed, 18 Apr 2018 06:09:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.139.13 with HTTP; Wed, 18 Apr 2018 06:09:47 -0700 (PDT)
In-Reply-To: <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com> <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Wed, 18 Apr 2018 06:09:47 -0700
Message-ID: <CAGf8dgLrWx0dNX5W=2_aonaG55jzhzOBTcr8u=36xSPvtVp8kQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 11:05 AM, Stefan Beller <sbeller@google.com> wrote:
>> * sb/submodule-move-nested (2018-03-29) 6 commits
>>  - submodule: fixup nested submodules after moving the submodule
>>  - submodule-config: remove submodule_from_cache
>>  - submodule-config: add repository argument to submodule_from_{name, path}
>>  - submodule-config: allow submodule_free to handle arbitrary repositories
>>  - grep: remove "repo" arg from non-supporting funcs
>>  - submodule.h: drop declaration of connect_work_tree_and_git_dir
>>
>>  Moving a submodule that itself has submodule in it with "git mv"
>>  forgot to make necessary adjustment to the nested sub-submodules;
>>  now the codepath learned to recurse into the submodules.
>>
>>  What's the doneness of this thing?
>
> I considered this done a long time ago,
>
>     "All 6 patches look good to me, thanks.
>      Reviewed-by: Jonathan Tan <jonathantanmy@google.com>"
>
> https://public-inbox.org/git/20180328161727.af10f596dffc8e01205c41dd@google.com/

To add to this, I sent this in reply to version 3 of this patch set,
after Stefan addressed my comments. Most of my in-depth comments were
in reply to version 1 of this patch, which are the grandchild replies
to [1].

[1] https://public-inbox.org/git/20180327213918.77851-1-sbeller@google.com/
