Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8091F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161852AbeBNSV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:21:56 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35724 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161827AbeBNSVx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:21:53 -0500
Received: by mail-yw0-f180.google.com with SMTP id d77so3296764ywb.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LJ4X1ySpNTqU8t+YJTL0z0+S6ASp8tUVAsChKFGUwVY=;
        b=DQ5n/JlT5iqfnuVpuNLYbSx1klGK2nRfRoSq+Cro8zellP8t2Zny09C7KInyyldcdk
         WGNxHLWQX4ZAjQP3wuV1oilWSkV2V89dv99XHt8RcVTy5rkBH+zb0nHKpaADXAVza2z6
         aWT9jHR21i/61LaBCsfhYzy0piKj+fXssCtdJaHTDoJUi4I4gLX5Twvi6xL653i1+KZp
         dpTufI66TqWy31s41elaLn551N7avLHcCy37svqK6g0/bDctnOeI5rqAPbdQMrc29QPv
         9YQkdPi78bKygBBOSM8hAIo3hq0FaIhCGzbYKRp3pqYOQI4Ndx30KlIXBB7ocwty+PzE
         Da6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LJ4X1ySpNTqU8t+YJTL0z0+S6ASp8tUVAsChKFGUwVY=;
        b=GI1Tn01ZdcEHVB8qCGkmy/2yG8lmdxeCMb1XyXJ9fDlvH5L0hqPD9hHmf1wYCnjivK
         VldMKtjoPwk6weWaK+8R8FSltDhrMgPiArxe9EOZ+VRKLfICz8yGU7C/LjIQ23clSl3K
         j7w96WvmqE262Kn139o1ICPYlBLUMBFr0cIXtzX1U29+9VJ0EZV+Qc8DrGL8fOjjMk/C
         4PHSeyAnBdP0X6I7LuSLwFv8s4RJ1KeiB5ZRI6g69jn3cZHrYAZLPlCzhgvbA+V8jm85
         vdXIABAUdBt6wFiDFQNAyTGhiD1QgiHKv3spPt4sb/BOwOeoOTHfDCM/bY58c8Q2LWYa
         Rlvg==
X-Gm-Message-State: APf1xPCKnjIi5p9VPkPewyCz2U5EFElVVeY64YwbnZAqZ/QFhsRrDyjW
        fnqw5Ya07X4JwsJAL6Q3Cujci/C3O/DBjKWiaESibw==
X-Google-Smtp-Source: AH8x226Tf1eHWqnuQDYOor5GPmlNVilZm6n8koX2nNS6vAHc7ejd1ShUgnkaZD099RrPUWnf8mb/DTgK5AvetjFGWr8=
X-Received: by 10.37.37.87 with SMTP id l84mr117498ybl.386.1518632511960; Wed,
 14 Feb 2018 10:21:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 10:21:51
 -0800 (PST)
In-Reply-To: <20180214181149.GB139458@google.com>
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com> <20180214181149.GB139458@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 10:21:51 -0800
Message-ID: <CAGZ79kZCBSzz9mW-2xKcq=2YRzyqvdktYe7ncKhsKRQizXndSg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:11 AM, Brandon Williams <bmwill@google.com> wrote:
> On 02/13, Junio C Hamano wrote:
>>
>> * bw/c-plus-plus (2018-01-30) 37 commits
>>  - replace: rename 'new' variables
>>  - trailer: rename 'template' variables
>>  - tempfile: rename 'template' variables
>>  - wrapper: rename 'template' variables
>>  - environment: rename 'namespace' variables
>>  - diff: rename 'template' variables
>>  - environment: rename 'template' variables
>>  - init-db: rename 'template' variables
>>  - unpack-trees: rename 'new' variables
>>  - trailer: rename 'new' variables
>>  - submodule: rename 'new' variables
>>  - split-index: rename 'new' variables
>>  - remote: rename 'new' variables
>>  - ref-filter: rename 'new' variables
>>  - read-cache: rename 'new' variables
>>  - line-log: rename 'new' variables
>>  - imap-send: rename 'new' variables
>>  - http: rename 'new' variables
>>  - entry: rename 'new' variables
>>  - diffcore-delta: rename 'new' variables
>>  - diff: rename 'new' variables
>>  - diff-lib: rename 'new' variable
>>  - commit: rename 'new' variables
>>  - combine-diff: rename 'new' variables
>>  - remote: rename 'new' variables
>>  - reflog: rename 'new' variables
>>  - pack-redundant: rename 'new' variables
>>  - help: rename 'new' variables
>>  - checkout: rename 'new' variables
>>  - apply: rename 'new' variables
>>  - apply: rename 'try' variables
>>  - diff: rename 'this' variables
>>  - rev-parse: rename 'this' variable
>>  - pack-objects: rename 'this' variables
>>  - blame: rename 'this' variables
>>  - object: rename function 'typename' to 'type_name'
>>  - object_info: change member name from 'typename' to 'type_name'
>>
>>  I do not mind refraining from using these keywords in a foreign
>>  language in our codebase too much, but at the same time, renaming
>>  must be done a bit more thoughtfully.  When the original uses 'new'
>>  together with and in contrast to 'old', renaming 'new' must be done
>>  while preserving the pairing (which may involve renaming 'old' as
>>  well), for example.
>>
>>  Backburnered, i.e. will drop if other topics start to conflict with
>>  it, but will accept rerolls.
>
> I was under the impression that people didn't care too much about this
> (which is a shame but that's an opinion :).

I care, so you are free to change your opinion. :)

> If people were more
> interested in a change like this then I'd be happy to go back through
> and rename the 'old' variables too.

Quoting Duy from a neighboring refactor thread:

  My stand is a bit more aggressive. We should try to achieve better
  [clean code] if possible. But if it makes [Brandon's] life hell, it's not
  worth doing. Converting to ['C++' compatible] is already a step
  forward. Actually if it discourages him from finishing this work, it's
  already not worth doing.

:-)

https://public-inbox.org/git/CACsJy8CPKESE8atc_eWdNVknQYp9T6ebwKwCdzLHyaFKH2BnZA@mail.gmail.com/

So if you can pick up the work to even make it consistent with old/new
variable names, this would be huge!

Thanks,
Stefan
