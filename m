Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2EB71FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758416AbdACMVC (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 07:21:02 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:33978 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758406AbdACMVA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 07:21:00 -0500
Received: by mail-io0-f180.google.com with SMTP id p42so429370988ioo.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 04:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BfQ34g7B/Umx2yVf7M2FQSBqLJMEAi+OXLW4wsSEaIM=;
        b=sh6t9qaL3Z62WDtnC9AXAEZ0TfN9i90X0ebuF0spgNEDobiPkkXCdU93UttWtvvrvE
         DMgJC8y5phBgHuvg52A1RV6QAFeCm8qgHpmwGfpDa0WHNBL9Sz2tc+1pZfrn3bOwJbtz
         66vYzvXidrpxqayXC8zpJ2JXVQ2OrrmlIp56uIzuJE/m4Q85Xqql+lz8g7IG4hP1d33y
         JNfrnBxtkEBf/5BAm6Hx7EbFZeMbjuK7yMZj/aA57hRVVVA4T8qbtbfDI4tAWA1EPVBK
         l2aH9Zm52x6YzGNqeoDPOD0IfHs3AYTRhKvtA0IS6rhQqW21/hghCIoo4aZFJ3WyKHi+
         UiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BfQ34g7B/Umx2yVf7M2FQSBqLJMEAi+OXLW4wsSEaIM=;
        b=D1kcSREVdmQvXvuXjCtpQaClGbcXw4IIT6ZeA6hTu8WBcyk9EnJCqC/0m6nnonWpG0
         c5PdMTpNhAOrM60u7OS7aRJV1dHWpn39zK7teBeLTVvUxUViYP1bpJndmBxqVTtid0nc
         aAiBeG+ilwmTyskLsom90ZfeYp30sskZQhbAAQcVWtMG1l7y0s/uum38Yu7eqE2HiKCb
         f8wNK+4jJo7cWqWns+CnYfkuonXFjzs/9d+Qg6nkXKZnTkOwVSkz+otTsnpGxwBGdQ9D
         5fLlTjTCZojZhE5xb0e6pUfsC8+jHa+qxUXhW0am5RoKyT/WsgK6GeDaBxs2n2S4BELI
         RmDw==
X-Gm-Message-State: AIkVDXLTEEFbSqctI2WCoWB3V6UwAjP2xe0GsWqSpyH+LwqjOFlIGg/GYirD8wc9B9CHyR/vwYHtHcr5L3fbpw==
X-Received: by 10.107.44.137 with SMTP id s131mr45215021ios.212.1483446060148;
 Tue, 03 Jan 2017 04:21:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 3 Jan 2017 04:20:29 -0800 (PST)
In-Reply-To: <CACsJy8CmKBpWa=yi44vGUe56CmeT-Swh_M_XxMeA+xkLLUhQ3Q@mail.gmail.com>
References: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com> <20161228181808.GC33595@google.com>
 <CACsJy8CmKBpWa=yi44vGUe56CmeT-Swh_M_XxMeA+xkLLUhQ3Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 3 Jan 2017 19:20:29 +0700
Message-ID: <CACsJy8BxsEtU0q4VBpRpELTnubmL624n35Hw3HPhBVx4=6b5DQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #08; Tue, 27)
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 5:06 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Dec 29, 2016 at 1:18 AM, Brandon Williams <bmwill@google.com> wrote:
>> On 12/27, Junio C Hamano wrote:
>>> * bw/pathspec-cleanup (2016-12-14) 16 commits
>>>  - pathspec: rename prefix_pathspec to init_pathspec_item
>>>  - pathspec: small readability changes
>>>  - pathspec: create strip submodule slash helpers
>>>  - pathspec: create parse_element_magic helper
>>>  - pathspec: create parse_long_magic function
>>>  - pathspec: create parse_short_magic function
>>>  - pathspec: factor global magic into its own function
>>>  - pathspec: simpler logic to prefix original pathspec elements
>>>  - pathspec: always show mnemonic and name in unsupported_magic
>>>  - pathspec: remove unused variable from unsupported_magic
>>>  - pathspec: copy and free owned memory
>>>  - pathspec: remove the deprecated get_pathspec function
>>>  - ls-tree: convert show_recursive to use the pathspec struct interface
>>>  - dir: convert fill_directory to use the pathspec struct interface
>>>  - dir: remove struct path_simplify
>>>  - mv: remove use of deprecated 'get_pathspec()'
>>>
>>>  Code clean-up in the pathspec API.
>>>
>>>  Waiting for the (hopefully) final round of review before 'next'.
>>
>> What more needs to be reviewed for this series?
>
> I wanted to have a look at it but I successfully managed to put if off
> so far. Will do soonish.

I have just sent a couple of minor comments. The rest looks good!
-- 
Duy
