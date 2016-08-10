Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4531FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935352AbcHJTD7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:03:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34630 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S941037AbcHJTD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 15:03:57 -0400
Received: by mail-qk0-f193.google.com with SMTP id x67so4128509qke.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:03:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MabQ9xhshzSGAtCTXZZ96Ve092UPSHZVySBg2nNuzMQ=;
        b=CA5srvKJyFTbpmEPdtUK3nt9mEto8uKlhDGXS0FI5qjO7BOr4czUV0IJP4G1z2A8V7
         OI8x2vEGggCjUFi7JMEK8ulKf3W3S/ZN8FIzffO+MIsE4nzDi4jdeC2pTugyYRZyUh7I
         9wekCyHrMEyVIue50kcsVuYUBqhnUWJRVv//CxxyJmHA8b3e+SwtADJUP+x+3aoSDAuD
         6UZzeiPM7vFm9sHlG/djXfKr0XCIfvcvB9BGmv7y2RQ+LDJp1tQQhz3JmK90BzjKOOAz
         YNhrS+COX3nHbMg/UNSszsHYroOZLTIrUsS0DQAe1m2EjAPTkha24e3KHS/dEzhjZAaP
         iHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MabQ9xhshzSGAtCTXZZ96Ve092UPSHZVySBg2nNuzMQ=;
        b=OtWOcPag/qkClituD4d6Tgv7BCUrfZDAMJtQUbOpMWyYMG4gefIW6X62LLxkFvG0Fs
         j21ayInPhBcbY+RNJt+nIDuY8qtaiL98xYO4uB9InHi1CWa+b1G6K2cAsddsUYBNJexw
         CjHAXzGANqXNNlU4MAwxKv656tDRzGAOwBn+0eLQznwB8vqoLTQyxk+mIdyb6CrB800u
         jMRmJlbsrH48wZ0AhtU1dBu+2WDuiV1VzaM+xKmpVsZklJ7YZJnSHk+rgxT6MhfMvFey
         1uijel1rEAKhTFDq6ETSifZTfSTL3VrCAs2kJJXgjZljKbtaqZOBT8845JW6urfzrUmV
         LqRw==
X-Gm-Message-State: AEkoouuRYZjdUyL9RQ6XUGc+tQ03wLOcJdMlMl526A02YHOzM0gqfCioyKO5nfwkQSHD3w==
X-Received: by 10.55.139.4 with SMTP id n4mr6420033qkd.161.1470855835970;
        Wed, 10 Aug 2016 12:03:55 -0700 (PDT)
Received: from nov34rcf12.ads.autodesk.com ([132.188.72.181])
        by smtp.gmail.com with ESMTPSA id m62sm12130396qke.13.2016.08.10.12.03.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 12:03:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] t7406: fix breakage on OSX
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160810175607.30826-1-sbeller@google.com>
Date:	Wed, 10 Aug 2016 21:03:54 +0200
Cc:	gitster@pobox.com, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <42522DA5-C677-4B2B-88CA-918B33069F9F@gmail.com>
References: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com> <20160810175607.30826-1-sbeller@google.com>
To:	Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 19:56, Stefan Beller <sbeller@google.com> wrote:
> 
> On OSX `wc` prefixes the output of numbers with whitespace, such that
> the `commit_count` would be "SP <NUMBER>". When using that in
> 
>    git submodule update --init --depth=$commit_count
> 
> the depth would be empty and the number is interpreted as the pathspec.
> Fix this by not using `wc` and rather instruct rev-list to count.
> 
> Another way to fix this is to remove the `=` sign after the `--depth`
> argument as then we are allowed to have more than just one whitespace
> between `--depth` and the actual number. Prefer the solution of rev-list
> counting as that is expected to be slightly faster and more self-sustained
> within Git.
> 
> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>,
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  origin/sb/submodule-update-dot-branch
> 
> t/t7406-submodule-update.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index d7983cf..64f322c 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -877,7 +877,7 @@ test_expect_success 'submodule update clone shallow submodule' '
> 	test_when_finished "rm -rf super3" &&
> 	first=$(git -C cloned submodule status submodule |cut -c2-41) &&
> 	second=$(git -C submodule rev-parse HEAD) &&
> -	commit_count=$(git -C submodule rev-list $first^..$second | wc -l) &&
> +	commit_count=$(git -C submodule rev-list --count $first^..$second) &&
> 	git clone cloned super3 &&
> 	pwd=$(pwd) &&
> 	(
> -- 
> 2.9.2.665.gdb8bb2f
> 

Ack.

- Lars

