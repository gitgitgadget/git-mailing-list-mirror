Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BABB20357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdGQUmD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:42:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36715 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQUmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:42:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id y129so99807pgy.3;
        Mon, 17 Jul 2017 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lPwCFzxyuRoeQme5lHGLC3LmQY5pPCuJGsmSEuvfBV0=;
        b=BhnXG2lKuYuLosRRjSv/8MaKim/mPVa30dfTflMWIkr+WvU+ReHD7dkTeVxTgK0SHj
         7tF55pHiaxmt2JM11AxX+VwVIACMKp/9kAkDLnFWj9pOk9XofLtJNzMSkfp8DFxlFSel
         8vI2fhlK+7aCzB1S5JfvDllSiq7wTBDD7XEWxmoqVCIlTT1yklfYS9WRMT4f+Zp7/ATG
         PKehEAnhkLrb6pCP/oK9nvrejpH/dd1G0SRRrBbaoNg34+klzMIPKL4tR02AKJLl/3d9
         USMi2eqEik+1NXXg7p+E7w9NqWKQmxZRoECrcNd5eFL2ahC0p811fesBbEGvUxQc0U8a
         Y4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lPwCFzxyuRoeQme5lHGLC3LmQY5pPCuJGsmSEuvfBV0=;
        b=V8uHq+xJEiKbHmCWBUQaNCzH9aL5nb517AfJhXhmmJ+ZDpPElwA/ZfODcvG4PBHUet
         isU1/P+TOkUDN1OpaOTx7sklP3g2JExiBh/VWouqqjc22JfB0IYD2jy6uwQs7hpRTK5V
         EeDokjo6pypw5eRsiEWk88w6dfqqZtNavktMRYHCuULhli36v8vBzlXx56MOCQRQyfB/
         WArQp99wRXqIImmM8ElP4XpRyk0GZnXW2QDX42rH9tvzyHU5uT19A5DhJ9mhHS/zGULx
         dtG54G+ZLt3yOpcayvEpygf6fhK6W7nzAz2ZnN/bo/nTpAdW+mWmBa+ZWEdPCym0wbAX
         lqJw==
X-Gm-Message-State: AIVw111L5bJ5q/1nMBXqmS+mSUi+NlgVoKSul23DBd0sIqvHv3X/MBZ+
        +1fWwFIV/YWDFg==
X-Received: by 10.84.210.172 with SMTP id a41mr2225012pli.194.1500324120783;
        Mon, 17 Jul 2017 13:42:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id i67sm189859pfc.122.2017.07.17.13.41.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:41:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.14.0-rc0
References: <xmqqzic7sy2g.fsf@gitster.mtv.corp.google.com>
        <87mv8638y5.fsf@gmail.com>
Date:   Mon, 17 Jul 2017 13:41:57 -0700
In-Reply-To: <87mv8638y5.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Sat, 15 Jul 2017 01:17:06 +0200")
Message-ID: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Jul 13 2017, Junio C. Hamano jotted:
>
> Proposed improvements for the release notes (is this a good way to
> propose RelNotes changes?)

Thanks.  You could also throw a patch just like any bugfix/update
to documentation, I would think.

> I think this may explain it better:
>
>  * The "[includeIf "gitdir:$dir"] path=..." mechanism introduced in
>    2.13.0 would canonicalize the path of the gitdir being
>    matched.
>
>    Therefore it wouldn't match e.g. "gitdir:~/work/*" against a repo in
>    "~/work/main" if ~/work was a symlink to "/mnt/storage/work".
>
>    Now we match both the resolved canonical path and what "pwd" would
>    show. The include will happen if either one matches.

Will use this (and some others) verbatim ;-)  Thanks.

>>  * Update "perl-compatible regular expression" support to enable JIT
>>    and also allow linking with the newer PCRE v2 library.
>
> At the risk of advertising work I've done too much, I think it makes
> sense to split this into two separate and somewhat more verbose items:

As I shoot for shorter summary, going down to too much detail in
these entries is not welcome.

However, an exception is the top part of the release notes where we
discuss backward incompatible changes etc. that helps people to
decide the deployment strategy.  Encouraging migration from v1 to v2
belongs there, I would think.
