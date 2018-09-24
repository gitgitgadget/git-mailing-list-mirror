Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C83A1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeIYDHY (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:07:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeIYDHY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:07:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id z14-v6so3601483wrs.10
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AnaOIlUyiKvugV/D7L9/aL5d6Ev12NYvs+p4hQp+NTo=;
        b=ihA/oTaEyr71g/kA3yIsEMFdl7DEBdSUqcPS8WJGdP0slhlf7ES3QBh4EQcfJkdOpl
         1+oHeR8in7NQe/RarVny2DkCtYXM6aXCDQaYsh8FWgTMDGJ9/H3JBFzDm/GIa3ErPZLH
         DU4A7fIOq5rFQK0pn9ZOjTPJN/1cLV2eyN8qa5j0ipdVWY7E4Q9Yvra4VeaXOTNjBxiJ
         nUUMfKKwt19+PFK5i34DeOLwGpdGzrmMxz1Vg9OOHwWJ9a71ZDLdzENxph7ku6j+ajf8
         mb8wfYS9E1Zfh7MbpqOSxH29070S4ZlrBuQR1B63LZYg0/nLCRd2m15HTQ8Ej+cTF95/
         DFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AnaOIlUyiKvugV/D7L9/aL5d6Ev12NYvs+p4hQp+NTo=;
        b=DQDgEOSqdN+B6avhDDJIptl2Zegerl8c9ZJITHmRTbenKRPNmZNg69YfrzmfYg/maD
         692JU+t7mCuT9doSb0ff4L9CT8RaGyd82iap6mUWJnryiDaoJ6KXGz41zF4vDfjSSGUY
         b/pyJDMi39lI5LUfp8L1F07MlgPgLwBm0iod28RK36Is3R80Bu34oxxplbHEtexPvJaM
         jNOfHFt7hLfEIU+WAjGwx+Uq1drF16iRtNqWS1ULokPxYweJ2wzrY/jeFuXmGHRCI9TB
         VL2+a/LqKy4Wp7Y67rNCOabiRGrPNB8nP0D4e2A3U0W9IXU58mngyKEmo+VQ+WFCGDjJ
         Ioxg==
X-Gm-Message-State: ABuFfohhAYntOIYX9x/6rOzGHUKPkTNDDaE0zJCiYQlhB55wGkjiNegD
        FDodIeB11vEauo7hzXiabrc=
X-Google-Smtp-Source: ACcGV62DuUsWYb8B3k7dj9jaE3LtsjNg1RTchdYZXiLdyRmXFDtx+VUAjl4wE0bj7eM4SWVtQXx4cw==
X-Received: by 2002:adf:8248:: with SMTP id 66-v6mr461674wrb.140.1537822997192;
        Mon, 24 Sep 2018 14:03:17 -0700 (PDT)
Received: from localhost (x4db15232.dyn.telefonica.de. [77.177.82.50])
        by smtp.gmail.com with ESMTPSA id 94-v6sm635257wrc.10.2018.09.24.14.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:03:16 -0700 (PDT)
Date:   Mon, 24 Sep 2018 23:03:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        gitster@pobox.com, jrn@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/5] CodingGuidelines: add shell piping guidelines
Message-ID: <20180924210314.GE27036@localhost>
References: <cover.1536969438.git.matvore@google.com>
 <cover.1537493611.git.matvore@google.com>
 <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 06:43:27PM -0700, Matthew DeVore wrote:
> Add two guidelines:
> 
>  - pipe characters should appear at the end of lines, and not cause
>    indentation
>  - pipes should be avoided when they swallow exit codes that can
>    potentially fail
> ---
>  Documentation/CodingGuidelines | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 48aa4edfb..6d265327c 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
>  		do this
>  	fi
>  
> + - If a command sequence joined with && or || or | spans multiple
> +   lines, put each command on a separate line and put && and || and |
> +   operators at the end of each line, rather than the start. This
> +   means you don't need to use \ to join lines, since the above
> +   operators imply the sequence isn't finished.
> +
> +	(incorrect)
> +	grep blob verify_pack_result \
> +	| awk -f print_1.awk \
> +	| sort >actual &&
> +	...
> +
> +	(correct)
> +	grep blob verify_pack_result |
> +	awk -f print_1.awk |
> +	sort >actual &&
> +	...
> +

The above are general shell coding style guidelines, so it makes sense
to include them in 'Documentation/CodingGuidelines'.


>   - We prefer "test" over "[ ... ]".
>  
>   - We do not write the noiseword "function" in front of shell
> @@ -163,6 +181,15 @@ For shell scripts specifically (not exhaustive):
>  
>     does not have such a problem.
>  
> + - In a piped chain such as "grep blob objects | sort", the exit codes

Let's make an example with git in it, e.g. something like this:

  git cmd | grep important | sort

since just two lines below the new text mentions git crashing.

> +   returned by processes besides the last are ignored. This means that
> +   if git crashes at the beginning or middle of a chain, it may go
> +   undetected. Prefer writing the output of that command to a
> +   temporary file with '>' rather than pipe it.
> +
> + - The $(git ...) construct also discards git's exit code, so if the

This contruct is called command substitution, and it does preserve the
command's exit code, when the expanded text is assigned to a variable:

  $ var=$(exit 42) ; echo $?
  42

Note, however, that even in that case only the exit code of the last
command substitution is preserved:

  $ var=$(exit 1)foo$(exit 2)bar$(exit 3) ; echo $?
  3

> +   goal is to test that particular command, redirect its output to a
> +   temporary file rather than wrap it with $( ).

I find this a bit vague, and to me it implies that ignoring the exit
code of a git command that is not the main focus of the given test is
acceptable, e.g. (made up pseudo example):

  test_expect_success 'fetch gets what it should' '
    git fetch $remote &&
    test "$(git rev-parse just-fetched)" = $expected_oid
  '

In my opinion no tests should ignore the exit code of any git
command, ever.


These last two points, however, are specific to test scripts,
therefore I think they would be better placed in 't/README', where the
rest of the test-specific guidelines are.

>  For C programs:
>  
> -- 
> 2.19.0.444.g18242da7ef-goog
> 
