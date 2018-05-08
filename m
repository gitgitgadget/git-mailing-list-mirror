Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64EE200B9
	for <e@80x24.org>; Tue,  8 May 2018 01:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeEHBBd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 21:01:33 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:41127 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeEHBBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 21:01:32 -0400
Received: by mail-wr0-f174.google.com with SMTP id g21-v6so30484113wrb.8
        for <git@vger.kernel.org>; Mon, 07 May 2018 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sJ2cTD2PgrMTxIyDkPGqLxAlMybpjrH4f6lvbV0dO94=;
        b=ORNhtqI1XH/X2k84zXPzZUTAEUySHXr9v49Fn/N1+aTlPnex99iw5uUEaOiFXVNS9Y
         Xog04qfuXIKNXH5wzLCMh4gOVSaPQ8y3kdFKrHSFPPTHt4y6wII5yL3TMEhA8RNspV7I
         t918s8NkYxDzgn3jD8fd6XbiXXhKiYl0u62QgB2OHrO5mT/TwZxODrLGNX0/6C2a1j+g
         KqdaEWRHRR/sBjcVFLMEiIkk/hgXmlmk0T59XirIkukyp3ycUwaDXCzGNM52ebH4NPCV
         PbS0mYVhiRkCpzJ8FV2JFUWFJPwHSVLb6mRk23w+7L5lq6jkLuY58ecEkb1MpMyk/vvg
         ih7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sJ2cTD2PgrMTxIyDkPGqLxAlMybpjrH4f6lvbV0dO94=;
        b=Qt4W5vyPQt1S5d3Z+I9hA0JjjyV7Fo+V7uibeYrEgREHhm/qqNAjVvIfKw1d4ve9+i
         +3XTOuT5v6KPusf0apSwJG0lnQeCIqi8knV+TU7QYvuE2B+UA5OUfOBBXVD+/DNu3jOJ
         XEGqrcGAyloquEVzLUXyMvElZT2AiuIkWgJf+q9vTcsATC+QQGVHy7MnL2oDCcenLxUy
         z1c8C8I3JYYKnVzCIHPehjzEcxXJkjfbzMfb2CSKNHk3sisKh+GWh/v7FSdg26AUlR9/
         5n2VnsoToYAi7pnPkOcWCEZwUmteTAqvQlA14dxC4vSA4NP85eVaxfPPLYCfp/nuRolh
         jCUw==
X-Gm-Message-State: ALQs6tBnxxZluW7a/hGH3xn2Lk9E5TOUBBADwpgPkUJ662l+fk2EGHHi
        7+Po8cXUhzaRPArqH3hQaMQ=
X-Google-Smtp-Source: AB8JxZoBJIZ7veaoyTrYZgBIzLYhCtXdWCm7VuOgiUYcwJYdiBqhrf1m7N7LQ4SMB/BPsHMr3ZpWOA==
X-Received: by 2002:adf:b246:: with SMTP id y6-v6mr16872206wra.99.1525741291279;
        Mon, 07 May 2018 18:01:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p35-v6sm32902172wrb.12.2018.05.07.18.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 18:01:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2018, #01; Mon, 7)
References: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGG8O=T1xQzPokcfCCujY7S05LtuQz-VQV_64hgmOEBJQ@mail.gmail.com>
Date:   Tue, 08 May 2018 10:01:30 +0900
In-Reply-To: <CABPp-BGG8O=T1xQzPokcfCCujY7S05LtuQz-VQV_64hgmOEBJQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 7 May 2018 08:57:20 -0700")
Message-ID: <xmqqh8njneol.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  Rename detection logic in "diff" family that is used in "merge" has
>>  learned to guess when all of x/a, x/b and x/c have moved to z/a,
>>  z/b and z/c, it is likely that x/d added in the meantime would also
>>  want to move to z/d by taking the hint that the entire directory
>>  'x' moved to 'z'.  Incidentally, this avoids updating a file in the
>>  working tree after a (non-trivial) merge whose result matches what
>>  our side originally had.
>
> Thanks for adding a comment about the fix for the unnecessary update.
> However, you've dropped a comment from the original release note about
> the other fix this series also provides, namely, "A bug causing dirty
> files involved in a rename to be overwritten during merge has also
> been fixed as part of this work."

Thanks again.
