Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2977E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998800AbdD1PKE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:10:04 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35273 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2998790AbdD1PKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:10:02 -0400
Received: by mail-it0-f41.google.com with SMTP id 70so40426119ita.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K0KOWRBQV/MDSjL1RykwhgZpKGKEdiMAyNFJlAPkDfs=;
        b=pkubs3Mg2itgwGCE6YrYV3+Hkiyw0Rd9iVms5V4zj28/xKM9dAy5iTyoUXVS0WTLL/
         4cwdVYjl5ieFArWxtdMPVoIkTwJfYmQIGHpCIO2cJCGZ5wgjYLaJ/XnzuGp1qE0fICJF
         SZYF71PGcG724KKD2LZw2nv959AUgj1iZCum6fKAFHT5s5Sh27HD8iCVn7bzGUZNMn7t
         2jwn9dON8ctvLcidnt0/sJu3n6/9YbLIEZ7khO1n6fFTE7eY97aiq2Ak3s+XcA44/WFE
         Cn/6L45JZ9gy64/6AeQBhxIjiYxhrZZHkgiYu20wXDKbAW5uoexcIoSoMKuZEao6ZvQJ
         3CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K0KOWRBQV/MDSjL1RykwhgZpKGKEdiMAyNFJlAPkDfs=;
        b=efHYCmZwJldIj8uQvOHivNEWg/Qb5T3V5SQeV1ppckHIWgAQt1DfI7gecW7D5gvmhU
         joejrEUkuOagnhcL64x8zD7zua5+FaFdoUeqkTx2CaSZVRwtke/QAXQ/TdRbPXflYqax
         /wk1TIDTCNbKPNBA/bXBR9RQqXU68ylSfwU4Fd7HAHW428WTNq1MtY+/R3R9nDAPn402
         phfhm3As39lIT8hRpSG4It3xdwqHR9Jk5xDn/yG4dwAHS4aCuvw5AYWr+6BK6lP+0IXH
         wqAIXoWg+yN9aJM1S2m9klc6eMzUyw70voYi6wgCzKawkaumv8WVkdR4SvqGE0TfO2DR
         WV+A==
X-Gm-Message-State: AN3rC/5T3fG6HYl9DL/1w2XJ8NQYWHFiHAH2W/CvAiH1l0bZlFlZOYt8
        pKlTvUP1I31V5Ke5/+vs9APVEWXjoUQ1SUM=
X-Received: by 10.202.8.81 with SMTP id 78mr4432476oii.157.1493392195519; Fri,
 28 Apr 2017 08:09:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.136.13 with HTTP; Fri, 28 Apr 2017 08:09:55 -0700 (PDT)
In-Reply-To: <20170427201804.3abt5ht6dkwwqo4r@sigill.intra.peff.net>
References: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
 <20170427201804.3abt5ht6dkwwqo4r@sigill.intra.peff.net>
From:   Andrew Watson <andwatsresearch@gmail.com>
Date:   Fri, 28 Apr 2017 11:09:55 -0400
Message-ID: <CAH6sfJX338f=WyEbCBXX_bzq=homhMs=cjPtzmH9cSvtBKPnaw@mail.gmail.com>
Subject: Re: push fails with return code 22
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

I agree that it does look like the client isn't using smart-http. I am
using the Windows client from git-scm.com.

Thanks for pointing me to git help http-backend. I confirmed the
modules are loaded and the CGI environment variables. I've added
"AcceptPathInfo On" to my httpd.conf just to be safe.

I'm not sure what /info/refs is supposed to look like, but it is
empty. Could that be the issue?

Do you see anything in my apache configuration that looks wrong?

Andrew

On Thu, Apr 27, 2017 at 4:18 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 27, 2017 at 02:37:19PM -0400, Andrew Watson wrote:
>
>> I'm trying to setup git with Smart HTTP so we can move off of SVN.
>>
>> I've used the blog post: https://git-scm.com/blog/2010/03/04/smart-http.html
>
> I'm not sure how that post will have aged. You might check your setup
> against the documentation in "git help http-backend", which is kept more
> up to date.
>
>> My system is CentOS 7 which reports git version 1.8.3.1 and Apache
>> 2.4.6. I also tried on Ubuntu 16.04 with git 2.7.4 and Apache 2.4.18.
>>
>> Using GIT_CURL_VERBOSE I can see it fail after a PROPFIND.
>
> That means the client isn't using smart-http. PROPFIND is part of the
> "dumb" http push-over-webdav.
>
> So the problem is likely in the very first request Git makes to
> /info/refs/?service=git-receive-pack. The response there is what the
> client uses to decide whether the server understands smart-http or not.
>
>> My stackoverflow post with all the debug info I could think of is
>> here: http://stackoverflow.com/questions/43643152/git-push-results-in-return-code-22
>
> I notice the response for that first request has:
>
>   Content-Length: 0
>   Content-Type: text/plain; charset=UTF-8
>
> which implies to me that the git-http-backend CGI isn't being run.
>
> -Peff
