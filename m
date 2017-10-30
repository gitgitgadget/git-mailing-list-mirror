Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304B21FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbdJ3Qpl (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:45:41 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43106 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbdJ3Qpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:45:40 -0400
Received: by mail-qt0-f196.google.com with SMTP id j58so17205360qtj.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PMZAQOEvb+yCd2wu8As8WcVhxB+wtYzS/Hy4n+c2Qq4=;
        b=Kb+MG7hpETquoJrvYNWp6XR67mK6Bv9DvSOQKesrBIzxx7Rn4JmWXqdzCSFY/2AKwa
         Y0tZ7JBhG3Bmgp/M5jwZCqkiqiuxUelPWQJSG0xmDlSUlOGcaMEy29RHEo8UEgC7iBwX
         /HhHrW0BBN2kL9vg151TPtyf7NOC5Qiqnbe+PauSxuhEYn21ySo7QeqMLGXPWurGeChJ
         tJ5lUbdkkVV70SJDHkqZT3XNE6CzLNErTM1PC/yemQ1N+85x4d2eDe6s0S266Oa5JAD5
         dJuGvb6QD+Ktv7rXS/Jdgp1luCwl/99x/2jCwTNtHAzBCeKhs/esKLIbT87599CjYwXH
         yq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PMZAQOEvb+yCd2wu8As8WcVhxB+wtYzS/Hy4n+c2Qq4=;
        b=EpwpLRM1RbIe+omSw1W/kSN9arK+12BqVlAHmKr6FdMZv3+sjRHW0za6hrau9t+KLY
         UxTDnqNW/JH1RpP+WNpFxeTPFgKBFTLhnRJTY/uloZstTOII6kqVml6pMvNQsISQz/un
         d14UyQ+1ZswRRTjQv8SEjrghRQCkZWEryn9HSjLpgY2lo+GEwOtTSADzrUjBUvdboWod
         qV2yd5Egtt3/khfkISDD/6SmCaGxpWNRijQbCBBwfwo2LZ5lg+LcnUUrXtK9jtrQPljz
         mw7PBnWM0sk0trlL5Kn/s8/dzd9rmz4NGGPwqIf8SpwR5ZJosyDCJFFvAkJkwmDT/Lax
         qyTQ==
X-Gm-Message-State: AMCzsaVPpNHuS2IZljYp94utgHoyBJDeycrD43Hjj88WHuAchnvchNqE
        xYTPpkrYcAygjZ2Fww5CHoUuBCMq6RCPoha7d8ZamA==
X-Google-Smtp-Source: ABhQp+TDDqVuJkXvuiRDHvWUYuOXxfCnY/IV70bvBuZDnh2iigK6r2edo0Ut+fkr8HFe6peX1TjYAV+FkosSRI/M8/0=
X-Received: by 10.237.37.132 with SMTP id x4mr12961467qtc.224.1509381939130;
 Mon, 30 Oct 2017 09:45:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 09:45:38 -0700 (PDT)
In-Reply-To: <20171028181239.59458-1-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 09:45:38 -0700
Message-ID: <CAGZ79kbX_6ONL1RK3xPopE8Rg15AinvzVZv3rAwLCXgX15NQ_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Hash Abstraction
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 11:12 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This is a series proposing a basic abstraction for hash functions.
>
> As we get closer to converting the remainder of the codebase to use
> struct object_id, we should think about the design we want our hash
> function abstraction to take.  This series is a proposal for one idea.
> Input on any aspect of this proposal is welcome.

I like the series/idea.

> This series exposes a struct git_hash_algo that contains basic
> information about a given hash algorithm that distinguishes it from
> other algorithms: name, identifiers, lengths, implementing functions,
> and empty tree and blob constants.  It also exposes an array of hash
> algorithms, and a constant for indexing them.
>
> The series also demonstrates a simple conversion using the abstraction
> over empty blob and tree values.

That looks good, though I wonder if we'll have to give a way a little
performance during the transition period (or even indefinitely, as the
hash abstraction won't go away; we'd rather want to keep it in place
long term). I guess we can measure after all is said and done,
no big deal.

>
> In order to avoid conflicting with the struct repository work and with
> the goal of avoiding global variables as much as possible, I've pushed
> the hash algorithm into struct repository and exposed it via a #define.

If you are referring to that long series[1] that Jonathan and I were working
on, then no worries.  Unfortunately that series got some delays, but I rebased
its prepared successors (of over 100 patches) on Friday and it was surprisingly
easy to do so; just tedious.

[1] https://public-inbox.org/git/20170830064634.GA153983@aiede.mtv.corp.google.com/

>
> I propose this series now as it will inform the way we go about
> converting other parts of the codebase, especially some of the pack
> algorithms.

Thanks for doing this now.

> Because we share some hash computation code between pack
> checksums and object hashing, we need to decide whether to expose pack
> checksums as struct object_id, even though they are technically not
> object IDs.

I think we used sha1 as checksums, because it was a hash function easily
accessible, not because its other properties were the best to do its job.
So I am undecided if we want to just "keep the same hash function for
checksum as well as object hashing" or pickup another checksum, that
actually *only* does checksumming (we don't need the cryptographic
properties, such that an easy hash [such as crc, djb, fnv or murmur]
would do; raw speed, barely protecting the pack file against bit flips).

For the sake of symmetry I tend to go with the former, i.e use the object
hash function for pack files, too.

>  Furthermore, if we end up needing to stuff an algorithm
> value into struct object_id, we'll no longer be able to directly
> reference object IDs in a pack without a copy.
>
> I've updated this series in some significant ways to reflect and better
> implement the transition plan as it's developed.  If there are ways
> in which this series (or future series) can converge better on the
> transition plan, that input would be valuable.
>
> This series is available from the usual places as branch hash-struct,
> based against master as of 2.15-rc2.

Thanks,
Stefan
