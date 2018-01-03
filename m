Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF8D1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 05:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeACFfV (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 00:35:21 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:37537 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeACFfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 00:35:20 -0500
Received: by mail-it0-f65.google.com with SMTP id d137so579171itc.2;
        Tue, 02 Jan 2018 21:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b2KNJQiJdmh3UdfKzkTzLLueTKRqKiKoEvampYYoM5o=;
        b=PGbc/yrw9d863ydf8udFNN9U0lLcP23uj0Xrl9Yubm9P4ig0VFGQ+cQs7WeRUeZGvR
         xstEjE+9Kjgvkj2zeUEsGqX8CCrk6QDOMiESgJWtoa4RVwrDDU7rZsJ/nsy3ZRd9l3Ua
         gVuZEiBxMtAq2NBhjiC1Rt3OlDF1SVGCo3d+JYn6Zo7grE6duGZAuR9pL5J+7cC1Mh1t
         hDqE8DN3f+ZuuJoS5zg0NjgsGwuUw2CUh3F2dPHjyfeF0zASmHEIQmXX8W870NGgH2jl
         G/HDPCX6b4lLbBpxXAzS/Mm6v+6jvdR7e366Ip7kygjtTbZwSbS41YfpDWQdwFV7UdjF
         t7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b2KNJQiJdmh3UdfKzkTzLLueTKRqKiKoEvampYYoM5o=;
        b=IXrFCO109kc7hBgBEWlE1LLV2l7vXjMxUMLmONUmah/XrEB8aErtfc5oib84NjxnjL
         febTXHHpmoBTYlEx9XG57ZtyUkRkF2BCTNEZwKOMIu2Mm6fhLrJxEtMAYPPhSFY+LuH2
         xp5mX8op8alnPfmhWdVzA297k7tqhhZEE75rqm6jOf9CHdRpcXFSwdjTKzyvHmx8Bywo
         e5YF8+yibHIUQNUdpsqCpilrOgQ1zxNl8w6Q0GlLNBNRYuqHHKHEiaOr9qYayzOGSDct
         Jo29G62TAfTE9cxTULBTXFzGwQXSg9C69V1dqw9ppSzCEBHJqnsYVCjBtgBt6BMygAZE
         bP1g==
X-Gm-Message-State: AKGB3mLaeHwoS+vzjLfVQ99VKLMjbcNXI/sNF0CKAlvfu7ZJGMQfd0kU
        LJ3Qmae4vcrzqcaexH5KbW8=
X-Google-Smtp-Source: ACJfBouJC27fcLbC5ynC7DHpCb5qxaiyHy/b7egVz8eeDsva8sEFIhiwg8IY51jlXMGYQo7MCwUdeg==
X-Received: by 10.36.51.74 with SMTP id k71mr596170itk.41.1514957719554;
        Tue, 02 Jan 2018 21:35:19 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q190sm141564iof.57.2018.01.02.21.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 21:35:18 -0800 (PST)
Date:   Tue, 2 Jan 2018 21:35:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180103053516.GB87855@aiede.mtv.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A few more notes.

Bryan Turner wrote:

> bturner@ubuntu:~$ ssh -V
> OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.8, OpenSSL 1.0.1f 6 Jan 2014
>
> bturner@ubuntu:~$ ssh -G -p 7999 localhost
> unknown option -- G
> usage: ssh [-1246AaCfgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec]
[...]
> Is it possible to adjust the check, somehow, so it doesn't impact
> older OpenSSH versions like this? As it stands, it seems likely a fair
> number of users who have an SSH command that does support -4, -6 and
> -p are going to end up getting "penalized" because it doesn't also
> support -G, and have to manually set their SSH variant to "ssh" (or
> something other than "auto") to avoid the automatic detection.
>
> I'd love to say I have a brilliant idea for how to work around this,
> oh and here's a patch, but I don't. One option might be trying to
> actually review the output, and another might be to run "ssh -V", but
> both of those have their own flaws (and the extra process forks aren't
> "free").

I have tomorrow off, so I've filed https://crbug.com/git/7 to make
sure I remember to follow up the day after.  Of course I'll be happy
if someone updates that bug saying they've fixed it in the meantime.

One possibility would be to use -V as a fallback when -G fails, or
even as a replacement for this usage of -G.  To avoid misdetecting
PuTTY and other ssh variants that also implement -V as OpenSSH, we
would have to parse the output.  This would also misdetect a script
that does

	host=$1; shift
	ssh "$host" -- "$@"

as supporting OpenSSH options, when the use of -- ensures it doesn't.

Another possibility is to parse the output when -G fails.  That's
hacky, but I think it would work well!  We would not have to be too
clever, since we can look for the exact output produced by the
versions of OpenSSH that we care about.  This still has issues with
scripts that forward arguments to OpenSSH, but at least those issues
would go away once the user updates their copy of ssh. ;-)

Another possibility is to pass options *before* -V:

	ssh -p 7999 -V

Since OpenSSH parses its arguments left-to-right, this gives similar
information to what we did with -G, and scripts like

	host=$1; shift
	ssh "$host" -- "$@"

would even be correctly detected as not supporting OpenSSH options.
We still would need to parse the output to distinguish OpenSSH from
other ssh implementations like putty (unlike OpenSSH, putty saves up
argument errors in an 'error' variable and forgets about them once it
sees -V).

Trying -G and falling back to -V seems like the simplest detection
mechanism to me at the moment.  I'm hoping I'm missing something
simple (another ssh option?) that allows avoiding this mess.

Regardless, I think we should do something like [1] first to get rid
of the regression.  Thanks again for reporting it.

Sincerely,
Jonathan

[1] https://public-inbox.org/git/20180103050730.GA87855@aiede.mtv.corp.google.com/
