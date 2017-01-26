Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527481F437
	for <e@80x24.org>; Thu, 26 Jan 2017 11:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbdAZLVC (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 06:21:02 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:32772 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbdAZLVA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 06:21:00 -0500
Received: by mail-ot0-f180.google.com with SMTP id 73so172816862otj.0
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 03:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammant-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=77f6JYkUN1o0Za5+tc0y6SxUPs5pnBf1vqXT4lD+f7Y=;
        b=u40/NytYHDyi7RpQiNt+vDC4EVCv/7T+29D2B6EocqN856Nb6CHQutN4ld4TCe5MoT
         +hooHtSCRxvqDFMxjrkd3uKtrJ68OVUpNqfReTlAhpI5UyIObYcqRmIrPXlT5GX5UJyx
         Q+9KZIzlKvA+SdJgUT8svgLqKcKJzvdfcUiO4K8h2u7ryGvMBQb8o9ce1o9oMeXnquP2
         HfFU5gqzTrr5QqeVE0AhY46oTABPPuqDnk9QSKIsIJ+PBu/ChbFnmI0HkqxEAeVGlm+M
         UtWTqinlg56wGZV8rSQtk9NyHNPjCUXCufAQpSUsiIZS4OSECTQB3DkecmNn+xbS6u78
         voVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=77f6JYkUN1o0Za5+tc0y6SxUPs5pnBf1vqXT4lD+f7Y=;
        b=KhWIcZDyGxtuAW9z8q1W90qPNkJjYGU9ridbAnhtOKEqn/EJWORSBEP7UMzyL13ASm
         UquQ4C5Si8oWUDIh5zQV8g1cl+imD980jQ/wlI6RQxArGPMp1mvJrQTJw20/XNKKfaoe
         52ZR1U/ePuhc2In0tn/EXYg66UGkWCDxnq+huc6zXunxirU/yap/BfarQJD1/Zvq3Xdu
         YP0s2elQ6H6/VFgGBcdhDQlQNU7squXLGTgDF9tclJ9ywMAqzAd2K8nd5RIH83M9vlKS
         7UTDo9cff62tfCrr/7szpwrKJMScQdszZvTUf+rH+vhIj1KIqQrBo4mxQ6r1htef9GYC
         8dIA==
X-Gm-Message-State: AIkVDXK6clEyVdwFDvqLre7jusmQ92u9TfM+V5H0jYPz7RjgQbuvm0clHx72rndvVv7qqetUQkfHWEFXGmOrdQ==
X-Received: by 10.157.50.133 with SMTP id u5mr990032otb.201.1485429659955;
 Thu, 26 Jan 2017 03:20:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.143.1 with HTTP; Thu, 26 Jan 2017 03:20:59 -0800 (PST)
X-Originating-IP: [65.78.25.171]
In-Reply-To: <20170126045936.wyleenuwunhrvbn2@sigill.intra.peff.net>
References: <CA+298Ujx2wH2WnoYiOaWKoneBrF_E5VUXXSMqecGgNLYS0Wemg@mail.gmail.com>
 <20170126045936.wyleenuwunhrvbn2@sigill.intra.peff.net>
From:   Paul Hammant <paul@hammant.org>
Date:   Thu, 26 Jan 2017 06:20:59 -0500
Message-ID: <CA+298UhHyXvHZzuuVAz-KYuPJydKY4JksKyBPe+VjsL+zOn74Q@mail.gmail.com>
Subject: Re: sparse checkout - weird behavior
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well I feel a bit silly. Thanks for responding.

On Wed, Jan 25, 2017 at 11:59 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 25, 2017 at 10:21:19PM -0500, Paul Hammant wrote:
>
>> Related bug (maybe the same). Reproduction:
>>
>>   $ git clone git@github.com:jekyll/jekyll.git --no-checkout
>>   Cloning into 'jekyll'...
>>   remote: Counting objects: 41331, done.
>>   remote: Compressing objects: 100% (5/5), done.
>>   remote: Total 41331 (delta 0), reused 0 (delta 0), pack-reused 41326
>>   Receiving objects: 100% (41331/41331), 11.91 MiB | 9.15 MiB/s, done.
>>   Resolving deltas: 100% (26530/26530), done.
>>   $ cd jekyll
>>   $ git config core.sparsecheckout true
>>   $ echo 'CONDUCT.markdown' > .git/info/sparse-checkout
>>   $ echo 'Gemfile' >> .git/info/sparse-checkout
>>   $ echo 'Rakefile' >> .git/info/sparse-checkout
>>   $ echo 'appveyor.yml' >> .git/info/sparse-checkout
>>   $ git checkout --
>>   Your branch is up-to-date with 'origin/master'.
>>   $ ls
>>   CONDUCT.markdown Gemfile Rakefile appveyor.yml lib
>>
>> I was not expecting to see 'lib' in the resulting file list
>
> Yep, I think this is the same problem. Inside lib, you get only
> "lib/theme_template/Gemfile", because it matches your unanchored
> pattern. Using "/Gemfile" in the sparse-checkout file fixes it.
>
> -Peff
