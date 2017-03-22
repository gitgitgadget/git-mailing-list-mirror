Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E24520323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965088AbdCVSCe (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:02:34 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32898 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934824AbdCVSCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:02:33 -0400
Received: by mail-pg0-f41.google.com with SMTP id w20so8721223pgc.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X9EJCuBgAur8FMGGWwPTB0aH/wSIqcjCYpmsmjHq7Hw=;
        b=sWNY8smrBUzYo8/8w/i7D+6pD1wJsm08SsFeGE3uYhDc1wDWZQQwkxx3r/+PxJv7Yb
         r3O4UP1mOhwWjATWZfBtscgmGy9W4gVvbaTva/zRVATvWS1EyTlxCRqhH1oBp/N2sKjz
         SK0B0EHcOKc3roj82vXtQMIMnghlAFTS9lcxyk0NkPG7Zp7FG9CjDOAq8ojTc5ZhnFyN
         HTYxZFzIkMIp/rnAe0KSKira9nbi54TlC7T1cn7ZG7/iO/Obd/oYbMFDIIwO7k29fpeh
         jCAm9SSGOFvTMpEavDtRfPyos/hQ5s5zUQz3Xm5P9QaQhFo3snpfT+9E0HdEDBktpLlh
         pY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X9EJCuBgAur8FMGGWwPTB0aH/wSIqcjCYpmsmjHq7Hw=;
        b=jZIHrNIfIBdKS/qIDI8Fsg1VhEzeJ3wGSA1q+h3i2pirbHtwvaJbpnPhaf1m7wYAbq
         Rt5s1Xrg8AEBjZRGacFIzL9+ygbgOL1Qfog14FriNgTjjiQ24zCKeS4xl6VvNMsrW32P
         2iwPrtIwtXwZlDP+aAf/duJxQ0zEFqZRZaxhWH+Ig7SNRW6/jd+JnKTdpL4GFKuvs3bV
         avt2nWh0spRL7nNOhTsPdYwPCrRRqH/u0WexC36gaOO2PnY4s2Qz6HgmX5yPFAqisy6u
         58CId6t5Zg4zbLVfJgdCW9/E5tvRXGnpCLrM1DYrFdV6hFJU8AUMTKt85xROFtktYSjO
         Fb5w==
X-Gm-Message-State: AFeK/H1h7SxcQ4MQynASKdxiNBJO6quC4CQz/XzBwSF42GxI80LfTj9SLgzBn9IW4HFQ5pUn3OOlFk1xGQ0MTFun
X-Received: by 10.99.120.5 with SMTP id t5mr14192872pgc.223.1490205751779;
 Wed, 22 Mar 2017 11:02:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 11:02:31 -0700 (PDT)
In-Reply-To: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 11:02:31 -0700
Message-ID: <CAGZ79kYh0eP-dzpX58SrSRJGEr9iyOb0Q3vizsvxE81kzddwxQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] thread lazy_init_name_hash
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 10:14 AM,  <git@jeffhostetler.com> wrote:
>
> During our testing on the Windows source tree (3.1M
> files, 500K folders, 450MB index), this change reduced
> the runtime of lazy_init_name_hash() from 1.4 to 0.27
> seconds.

This sounds promising. :)
A fast skim over the code makes me like the code.

>  hashmap.c                           |  29 ++-
>  hashmap.h                           |  25 ++

Could you add some documentation to
Documentation/technical/api-hashmap.txt ?
(Bonus points for migrating the documentation inline,
c.f. discussion surrounding [1])

[1] https://public-inbox.org/git/20141212212800.GA27451@peff.net/

>  name-hash.c                         | 490 +++++++++++++++++++++++++++++++++++-

AFAICT the new threading is all implicit in name-hash and we do not expose
its functionality or tuning knobs outside the testing helper, such that we do
not need API documentation here, but only enough code comments to
understand the code for maintainability?

Thanks,
Stefan
