Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDD11FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 05:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbcFRFgo (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 01:36:44 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35672 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbcFRFgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 01:36:43 -0400
Received: by mail-lf0-f42.google.com with SMTP id l188so9627302lfe.2
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 22:36:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=bWPB5B8SOeWZwg6FblNH6hYA0Jb1I9ZLRN4q7XvFkGQ=;
        b=vtLQgDMd/iq/A0r0rvPoXh9/UEhF60HR7qqW4PGv+ODM7eQEzbm39r2lAw17kW2exs
         rkDb8otc5U9EyEgj9KuG2dS9Y8ET9vXCpyoP339NkL56DcVBB7GCICi46PdyvWualVvn
         +K3td1He777u6SvBj94Rmc8m0stIVeVmtpRD50CjZZEW2aJiwyNpC9Ht/VQFN4ianwr+
         9USk05LkRfB1ezRQQZ/pKbD/oij7IlCOHBFrhaXYwK7CsesYduv9lJZ9AhEvftYOBomI
         HTKUPnCCSztDy3CHkt6S2tqD/I8nAAPC3itHapZFTXpzNzjBEM4GTY4UZbQj5KkrDUJU
         +1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bWPB5B8SOeWZwg6FblNH6hYA0Jb1I9ZLRN4q7XvFkGQ=;
        b=CmbUTAGMKhe7Al6I8yF4cw8triPqpRgXGAj50n4W2b8VuYUsllICxCrlsLFvrGubUW
         pjuBEdhND/XbBNwnkVESM12fCy6gHDZongctqbM2xo4GfLRbXx6sUNjlV6lzInvBTvyS
         BCgIhv72v3bhH81AgROIcpGY7rNDaHq+QR3/dVX+w1o3e2wvu0N2TvAFrefn2BCQV1bW
         K4qUBPg9woGG1JYrvFt42zm0pEByS1xsunMFh+CGe89GoYn4WIx6Ta+1ihLmCXJIZqSM
         vCoZXF7Yon5JYSTF4NXoBGcv5Zox6uP/BRJ/A1Zdr1h+P0k+pPo6uu/a0YRv0oP2iw2c
         XsQw==
X-Gm-Message-State: ALyK8tI30mVqitFIBZyr9aKY6VDPiEw1jr1jz3LSK9rU+I3isZ7X0JJL4qAs3pJAhBocegbT/9IEb3xImmvZWRUi
MIME-Version: 1.0
X-Received: by 10.25.168.202 with SMTP id r193mr1845371lfe.85.1466228201120;
 Fri, 17 Jun 2016 22:36:41 -0700 (PDT)
Received: by 10.25.156.83 with HTTP; Fri, 17 Jun 2016 22:36:41 -0700 (PDT)
In-Reply-To: <20160617150137.GA9197@sigill.intra.peff.net>
References: <CABYP2JZU5wqxCK1B7b_fDB0Lqz4-7a_Erb5dHKReZHQecxC8QQ@mail.gmail.com>
	<20160616121353.GB15988@sigill.intra.peff.net>
	<CABYP2JZ5nNHh_cRkgpRMkn7Qfs4zAjy+wfaputJ0CvZ-M4FW6w@mail.gmail.com>
	<20160617150137.GA9197@sigill.intra.peff.net>
Date:	Sat, 18 Jun 2016 11:06:41 +0530
Message-ID: <CABYP2JZ7jek5kWqx+1CZQB0AQCngwtEYr2YJc6QiOMdGFMgUOw@mail.gmail.com>
Subject: Re: URL rewrite in local config unable to override global config rule
From:	Saksham Saxena <saksham.saxena.1994@ieee.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks a lot Peff. This cleared a lot of things. Would it be okay if I
cite some parts of this conversation on my personal blog?

On Fri, Jun 17, 2016 at 8:31 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 17, 2016 at 08:05:47PM +0530, Saksham Saxena wrote:
>
>> > ..even if I have an existing "url.git://.insteadOf=https://". But I
>> > could believe that having other config confuses things. The
>> > url-rewriting is not "last one wins", but rather that we try all of
>> >
>> > > them, and the longest match wins.
>>
>> Longest? Could you elaborate please?
>
> The one that matches the longest number of characters. So
> "https://example.com" is a preferred match over "https://".
>
> I don't think that's what's going on here, though.
>
>> Here you go (https://gist.github.com/sakshamsaxena/a1cee9c39ddc127ae659e92d02d58f0b).
>> The commands are run in that sequence.
>
> OK, so you have:
>
>   url.git://.insteadof=https://
>
> in your initial config, to convert https URLs to git.
>
> Later you add:
>
>   url.https://.insteadof=git://
>
> to do the opposite.
>
> The URL in your config uses http:
>
>   remote.origin.url=https://github.com/sakshamsaxena/sails-hook-jbvcs.wiki.git
>
> And when you push, this gets converted to "git://".
>
> I think this is the expected behavior, due to the first insteadOf, which
> converts https to git. Both rules are "active", in the sense that the
> later one does not replace the former; together they make a list of
> rules to try applying.
>
> Git doesn't recursively apply insteadOf transformations. So the "convert
> https to git" rule triggers, and we stop. The "convert git to https" one
> doesn't trigger initially (because we are already https). And if we were
> to apply rules recursively in this case, it would loop infinitely.
>
> So I this is all operating as intended. And what you really want is a
> way to say "erase any earlier rewrite rules; I do not want them applied
> in this repository". There's currently not any way to do that.
>
> For other "multi-valued configs" like this one (i.e., ones that form a
> list rather than overriding earlier values), we have started using the
> convention that assigning the empty value resets the list. But this
> particular config key has not learned that trick yet, so it would
> require a patch to git.
>
>> > You should be able to clone, fetch, or push wiki repositories using any
>> > of the normal protocols. So:
>> >
>> >   git@github.com:username/repo.wiki.git
>> >
>> > should work. Likewise, git:// will work if the repository is public, but
>> >
>> > > you cannot push over it.
>>
>> True. Can't push over git:// and that's why I'm limited to https://
>
> You can over ssh, though (which I thought you said earlier was your
> preferred protocol).
>
> -Peff

Thanks and Regards
Saksham Saxena
