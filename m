Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6C71F461
	for <e@80x24.org>; Wed, 26 Jun 2019 20:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfFZUgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 16:36:03 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33418 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 16:36:02 -0400
Received: by mail-yb1-f194.google.com with SMTP id n3so131730ybn.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MwelzgjKe18kOpDy4kPABwIAbRtTPW6o6AXHx4C5d2U=;
        b=JtcsOXdygmUXU3m0jUsnT91yEyV9yTU+fPkUl/IrV0VkP4NL7KSAvMb7ftJiKWCh13
         H8oD1Lbk2CbT0kGc8RUZYGyNtMPdWYrn7ugjEqMXnWPteFVMiHmSLYrRFNqNXB/xGHiq
         g3qOJaFFsfHUR1Xeaach8UnpheLOrQQNnO37hRmGr/r2kWhfEUe/+6x2AWn5ikDc2I3p
         HP+qfm4janqbHpfIUrGumjqPRtZstjyRksTJ1Am+bOcaJ58vSr8UsTn3hX4JODTZMnpf
         bNJ5iC+mLV7TirjWdg/mM0PlyEeGmm8MR35OmEfRIhbXZoFaIbF8QdLQTp5AFQ686+T+
         lUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MwelzgjKe18kOpDy4kPABwIAbRtTPW6o6AXHx4C5d2U=;
        b=sPrnPjx/d7Je7BUvS04gdaisQrxJvimSa9wR/O17jPuXKrKisjERxQhbZcw0q5q8As
         TiF+Bxp+JsJ4cQFzZDZrOvMMQa7TZ7PabgFIAc2bNvchOodr0G96QDd5XXpI8oQo0Fem
         CNqbXjyJEIr2nBcB6OTr41UmpG0q8eneIXlS0YsjshW1RNS5o7ArYGZI+pMiE5APVVW9
         WWmtFzZgkUA6ww+oULg+WozrDco9mM9hha/y0zaXUZsphvqkbzGcBexHUBlIvr9AxM8A
         bO9a1W8i2OqQ6FMM+GBMsCeJAU84tEogV4hMRFNOF5f5O9v2/pO7CEE7qaN75mKh/yWJ
         tamA==
X-Gm-Message-State: APjAAAXo/qBoPzZPQ3dxcVC+8y5LmgR/i9ug9Q0iZk9n8ijT0fn5moDK
        AMeK/K/uhq2y3RCv+oPn8Dlls51Pbcm8Dg==
X-Google-Smtp-Source: APXvYqzT6+hwnpEKG1C6jRRWeMn64JOi7mPTEPoqaqVkoh0G+ktHkYlmhGFdd1Olcrh3gkv/bkKPyg==
X-Received: by 2002:a25:2d6b:: with SMTP id s43mr209946ybe.462.1561581361688;
        Wed, 26 Jun 2019 13:36:01 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:a495:edeb:abca:f993])
        by smtp.gmail.com with ESMTPSA id f7sm2495556ywb.103.2019.06.26.13.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 13:36:01 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 26 Jun 2019 15:35:59 -0500
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Travis not looking so good
Message-ID: <20190626203559.GA71590@TaylorsMBP3745.attlocal.net>
References: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
 <20190601004143.GN8616@genre.crustytoothpaste.net>
 <20190602112239.GO951@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190602112239.GO951@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gábor,

On Sun, Jun 02, 2019 at 01:22:39PM +0200, SZEDER Gábor wrote:
> On Sat, Jun 01, 2019 at 12:41:43AM +0000, brian m. carlson wrote:
> > On 2019-05-30 at 19:32:41, Johannes Schindelin wrote:
> > > Hi Gábor,
> > >
> > > do you have any idea why Travis is failing like this in the macOS/gcc
> > > job?
> > >
> > > > +case "$jobname" in
> > > > +brew link gcc@8
> > > > Error: No such keg: /usr/local/Cellar/gcc@8
> > > > The command "ci/install-dependencies.sh" failed and exited with 1 during .
> > >
> > > I usually only look at the Azure Pipelines (which gives me plenty enough
> > > to do, what with pu's individual branches being tested individually), but
> > > couldn't fail to notice that *all* four branches (maint, master, next and
> > > pu) fail in Travis' macOS/gcc job (and only there, the Azure Pipelines are
> > > all green):
> > >
> > > https://github.com/git/git/branches/all
> > >
> > > What's going on?
>
> The usual: Homebrew desperately tries to be overly clever and helpful,
> but ends up being dumb and annoying. :)
>
> I was hoping that this issue will just solve itself, like several
> other brew breakages in the past, but apparently it won't...

I have noticed this as well on my own fork's TravisCI builds.

> > I suspect if we want to use GCC 8, we need to explicitly install it by
> > using "brew install gcc@8", or we can just pick the latest released GCC
> > by using "brew install gcc" if we like that better. We will still need
> > to do "brew link gcc" (or "gcc@8"), since I suspect Homebrew won't
> > auto-link it since macOS provides a gcc binary.
>
> Yeah, installing gcc@8 or gcc works.  Back in 2c8921db2b (travis-ci:
> build with the right compiler, 2019-01-17) I opted for simply linking
> the already installed gcc@8 package, because GCC is big, installing it
> takes time, and the macOS build jobs have always been prone to
> exceeding the time limit.  (Note that these packages provide 'gcc-8'
> and 'gcc-9' binaries, not 'gcc', and after 'brew install'-ing them we
> won't need an additional link step (I'm not sure why linking is
> necessary with the gcc@8 package already installed in the Travis CI
> image).)

I wrote something like this up in [1] before I realized that you had
your own patches in [2]. This did fix things, but it's kind of awkward
in the sense that we're not really "installing" anything (in fact, the
patch in [1] incorrectly indicates that we are), but instead nudging it
after it discovers v8.3.


> Another possibilities are:
>
>   - Running 'brew link gcc@8' before 'brew update' works:
>
>       https://travis-ci.org/szeder/git/jobs/540027012#L139
>
>   - Not running 'brew update' at all works as well:
>
>       https://travis-ci.org/szeder/git/jobs/514960153#L179

I'd be just as happy to do something similar to what I did as really
either of these. Getting rid of 'brew update' entirely would make me
happiest, since it takes a *long* time for one of these to complete.

But, I'd almost prefer explicitly running 'brew install gcc@8' to
running 'brew link gcc@8' before 'brew update'. The later seems fragile
and awfully prone to break, especially when we are just doing it to try
and work around a Homebrew quirk.

If you don't have any plans to send your patches upstream, and feel OK
running 'brew install', let me know and I will send my patch in [1].

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/commit/a20e34d143a4a15b6b15ccb5bfb996fab9551b76
[2]: https://github.com/szeder/git/commit/ca29709d09a440d98857efb2575a3f92feaab29f
