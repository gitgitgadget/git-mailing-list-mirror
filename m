Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD17A1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeIXUDo (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 16:03:44 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34535 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeIXUDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 16:03:44 -0400
Received: by mail-qt1-f170.google.com with SMTP id x23-v6so9503338qtr.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VR8CYBk5949x4Duw+k8YQjyj/HGLfVSoNfULXMRmI6g=;
        b=Y5iRv9wTHJnGdoEUbSzmH8hfks5NuS9bS6jvuFvlhWsNsiOR4tkGm+/SxxvTD93dbu
         cZHh1d/DMObWDuon9IMJqV0kdpyRLML2EJJllysa1A2sqmrLcQLd3aoXdqP96jqoMyZu
         uz/SRjTLxcdj5ITFW12anlMfNKCgpVH07dOusnBVFvF2YuiVMdtNgzcpCC+eOXCcSoTK
         9oHBqqtkw+f3CA0HE9GnATPXLr3hzdIk4fp2UdzT7M/4bk6r+6kHVwWOaQQiKHtsytuT
         jPtojxHxsqT2PgM0A0QjeGWDB8IOV5eHAXaKX4VPeCzxxWojIy2iKvyaYInXofd7mdql
         wRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VR8CYBk5949x4Duw+k8YQjyj/HGLfVSoNfULXMRmI6g=;
        b=YgHTzoT/BAaHN5lfcBV7ENbkAtcNDnVGrnFx8EIzG4qLp35U+5Z/HLXH6oV7bUfsAN
         bl80/JNAoGCVjAFDcB7EVYIovVbxOPRzfYbCyoi7Xz7sAxbaOTob64vRuYYM4MiruLUX
         0rUQvWMqKXAZq7+94AYxGiOPkCHdFKkVXQmIkPmugI6Wyjkv8iG+BJ51+s+f45js8/2D
         kVQPsAhH7ZWyIt5WfkGaA9qTz2OJpIxUQyRG9tbw0IRas7H007rR7EyvPPkOYSftu2B2
         1TUXW3tfEaKqYHsT+G94Qbd3WH1wIXuOAq/g0euo0VWLuZMocBh49JJX0peqrb3IkZvD
         DBWg==
X-Gm-Message-State: ABuFfoj1YJI5xtwXNQ5fjhmi7urTN8dlmUqdGjjtQmb3CKcfSM2BmhWa
        RktVdjxtanB/92zNTFm2V5TABg==
X-Google-Smtp-Source: ACcGV62iN5rJ6+E3hXJhqG6ALizwpf4a+9Y14Sc58Ha8oXYVgJFWhisevC2O/7Du3PgP49janlOz/w==
X-Received: by 2002:a0c:d48d:: with SMTP id u13-v6mr888670qvh.165.1537797685139;
        Mon, 24 Sep 2018 07:01:25 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id t28-v6sm8882972qki.41.2018.09.24.07.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 07:01:23 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:01:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Austin <john@astrangergravity.com>
Cc:     Randall Becker <rsbecker@nexbridge.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        id@joeyh.name, Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180924140122.GC68796@syl>
References: <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl>
 <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl>
 <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net>
 <8736u8kpgu.fsf@evledraar.gmail.com>
 <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
 <000501d45366$cf437060$6dca5120$@nexbridge.com>
 <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 12:53:58PM -0700, John Austin wrote:
> On Sun, Sep 23, 2018 at 10:57 AM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> >  I would even like to help with your effort and have non-unixy platforms I'd like to do this on.
> > Having this separate from git LFS is an even better idea IMO, and I would suggest implementing this using the same set of build tools that git uses so that it is broadly portable, unlike git LFS. Glad to help there too.
>
> Great to hear -- once the code is in a bit better shape I can open it
> up on github. Cross platform is definitely one of my focuses. I'm
> currently implementing in Rust because it targets the same space as C
> and has great, near trivial, cross-platform support. What sorts of
> platforms are you interested in? Windows is my first target because
> that's where many game developers live.

This would likely mean that Git LFS will have to reimplement it, since
we strictly avoid using CGo (Go's mechanism to issue function calls to
other languages).

The upshot is that it likely shouldn't be too much effort for anybody,
and the open-source community would get a Go implementation of the API,
too.

Thanks,
Taylor
