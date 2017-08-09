Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD65720899
	for <e@80x24.org>; Wed,  9 Aug 2017 00:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbdHIANr (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 20:13:47 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34682 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdHIANr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 20:13:47 -0400
Received: by mail-lf0-f42.google.com with SMTP id g25so21472298lfh.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cAGbQJ6WaPlXg3CQswawtyjfYXUHuKs1zVCMbN72WIs=;
        b=GMUHFM5PN5/a+MSVTeklpihvIhka/F2AjkztyvYwWr4+qxLITps+f5pqFTauS3//nz
         rOf5fY2LGj7jGu3sLyVEVTjdAVNu6cmlhfmZNDknWcwIttjNovrSXmVPAKObPwIiM18U
         ODiXSUlzhst1jLtpWgXVPXYLgd9ocm4Mcvd/ldidF4kYFABRz0xS20A6wQrwJiIbr2/k
         0NR6HgrWZOJXZm/PIKnwbWcwcT/u88k/Pg8l+MCATs2iG3sNb1U/gNAQMqYWWr6OLW3B
         kBv5xtKU5Bx+9mb1ERzX3MCKkzjt77wfREL21TBd+hi7vsZLcg95aOL/jizuU4x4eBDb
         jASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cAGbQJ6WaPlXg3CQswawtyjfYXUHuKs1zVCMbN72WIs=;
        b=S3SvdjF0H6M9dRHWr5PM+RJ0vE5RZUjot4Wjv4jk6S9iApJ2zOZCAM7yxeRiF4wf5J
         9LMqtknjONRfdG43ztm+Lcn2QhgDrFxORO5Nu53lckwwhsJ2gsikBfJA04FExn4gWQq/
         K64ikpjGUXqR+4pj5Yt30VXuXI/89ORAwraQU8eNoY05zebWVEF/1FDb0EoGGRjpUTbx
         mefV+omUw9Xn8KxEFEtP0aeUIG0rRVxabOkzZpvkU8DmgvrdZUW1DVXyL9U8lFLXW1VC
         lrwc3ZaZWVQOEoSWzgsCNvbcjVDN93KKwyKisR1BsXsltTPZnheIJdFi0MktkhV8CBIh
         DLsw==
X-Gm-Message-State: AHYfb5hGwHwX07UwcxsG2k9Jt6LpSZoxJSm/yHpBB3Tse4k+C28Y/FP2
        gp2R8oRwnruK6fJ2YbXApQo0tL7qcgTp
X-Received: by 10.25.228.206 with SMTP id x75mr1790991lfi.94.1502237625732;
 Tue, 08 Aug 2017 17:13:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 8 Aug 2017 17:13:45 -0700 (PDT)
In-Reply-To: <20170809000742.GG169894@aiede.mtv.corp.google.com>
References: <20170808234308.25565-1-sbeller@google.com> <20170809000742.GG169894@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 Aug 2017 17:13:45 -0700
Message-ID: <CAGZ79kZ45=2ngM437fdj8KCJjJo5h0R7FtmEBBG+VVkm0pTLrw@mail.gmail.com>
Subject: Re: [PATCH] t1200: remove t1200-tutorial.sh
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 5:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> Nowadays there are better tutorials out there such as "Git from bottom up"
>> or others, easily found online. Additionally to that a tutorial in our
>> test suite is not as easy to discover as e.g. online tutorials.
>>
>> This test/tutorial was discovered by the patch author in the effort to
>> migrate our tests in preparation to switch the hashing function.
>> Transforming this tutorial to be agnostic of the underlying hash function
>> would hurt its readability, hence being even less useful as a tutorial.
>>
>> Instead delete this test as
>> (a) the functionality is tested elsewhere as well and
>> (b) reducing the test suite to its core improves performance, which
>>     aids developers in keeping their development velocity.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t1200-tutorial.sh | 268 ----------------------------------------------------
>>  1 file changed, 268 deletions(-)
>>  delete mode 100755 t/t1200-tutorial.sh
>
> Interesting.  When I first saw the diffstat I assumed you were talking
> about a test that validates the examples in some manpage are correct.
> But this is not that.
>
> There indeed appear to be other good tests for these commands, even
> "git whatchanged", so for what it's worth,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.

2ae6c70674 (Adapt tutorial to cygwin and add test case, 2005-10-13)
seemed to imply that it was testing some part for Documentation/tutorial.txt
though.
