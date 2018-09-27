Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C1E1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeI0WYY (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 18:24:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42148 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeI0WYY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 18:24:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so2219242pff.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/Yzl/duBeQBR7jJwf87tEA0buMroRqAVE0gLOCWk8dY=;
        b=ncAolSx8uOYwrFR+4htShqmJxt2Yn6xysL9TRlTfh7n1feGosRNfwZtH2tOhGmvHn0
         5pywdxT20+0TTVA+r44Yz6qPXOusI9qMJ5c/kmA9UFXKC2WimuGdFZSmWHT7O/HjE5Q8
         5XKtwQxpldidD6h3hdajsPJXQRMMrcatCvyTjiE2IbnIo02MD9Zd2QQRGfJRwkTQRvnN
         l+K3KQ4L7jkQUC1yoAKxcwm1OVYcySuC7sv+SeYEHRFtB89TZen1FSwuUq5yyT2UKp64
         DVoka3UMZOT9cCow/nKZUQrPH2O+xj98rwyVHw7PGUK/cwN9GrmxzOi/ShiWNjh/eCbn
         odHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/Yzl/duBeQBR7jJwf87tEA0buMroRqAVE0gLOCWk8dY=;
        b=KrVIt0ASquTqOy72Tsw8xXe1n9f7h5tDcV0963/va9WsxT9BFrCxL14OWxB9sLLSkX
         3ZI582jXbgm9+nkbMH1teV3PAR/eVG/RkpvQnhyNwH1y/fJz9ENS2jb2gVb4Yh59ROVV
         1PBJhJJQLSfpd1gMHuHxXdsB0cY69chkbd1r0OMIshplEb6ZvNAPot30KMxK8SSSjmNj
         WakRZiB5YRwW/2DcWgP0S3YbNGyZIaflwrF+yQh3uFXWWq2wN8gs6L1RC/0XvBVzcYbT
         9I/wiMf5dUhR6oPbjZvZ6X048MJuXIWGzwUPXtgb5dt3FzEyHccQos9fO6WD8kNlCIVI
         6TYQ==
X-Gm-Message-State: ABuFfoj+DxzOygkLmYVH4H5x6pNancK5gK0EbWgZWjZeTDgOe2bZDBOg
        j8fpVpkx10wSL7TmqDtUcUnqE1vS
X-Google-Smtp-Source: ACcGV61mZfTntfbd3suk8EV3ZmcoYmOLuQzpKrOuIY8O2sfK61hNVg82EilcA2FQ3VF8QVLo+8oImw==
X-Received: by 2002:a17:902:567:: with SMTP id 94-v6mr11884600plf.201.1538064326607;
        Thu, 27 Sep 2018 09:05:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k83-v6sm3805573pfj.63.2018.09.27.09.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:05:25 -0700 (PDT)
Date:   Thu, 27 Sep 2018 09:05:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Git for Windows for Unix?
Message-ID: <20180927160523.GA112066@aiede.svl.corp.google.com>
References: <87va6rhqup.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va6rhqup.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> GFW is a "friendly fork", but a permanent one it seems. The diff between
> it and 2.19.0 proper is ~10k lines, and e.g. this last release had
> experimental stash/rebase in C that 2.19.0 didn't.
>
> So it would be great if this were packaged up by linux distro as some
> "alterate" package of git. I'm putting Jonathan in the "To" line because
> I'm mainly interested in this for Debian, but maybe there's wider
> interest at git-packagers...

Please coordinate with Dscho to get these patches into "next" upstream.

Thanks and hope that helps,
Jonathan
