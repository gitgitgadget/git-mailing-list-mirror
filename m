Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525991F453
	for <e@80x24.org>; Fri, 28 Sep 2018 19:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeI2CWc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 22:22:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46946 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeI2CWc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 22:22:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so9139785edr.13
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AsIkLEhT7cNPKzeY/vcGr9l5TApDMw3CTJU7aytkK5Y=;
        b=Szz3fJzlxuED2+SiSSlhWigNzU7E7PnGLkfYt4QN+kyebbrvlB41N51cdYXXlkGR0w
         YE4+4TBfzhgM5+x0SAGaFb2E3TUS8KAyO9j5hoMWPLt6WlevbhvsB8rXwg62w61WPzt1
         ZvYIg5tR0CEP2jmEQPqjR5MnXvN/miJFoMHnEmFb9Oi23q4FPTNZHoHRSRGv3QrDWhOE
         lky6eUcyFghInwhvnr5D4Ny9NVZmkzSzERuUB6bqCofCZ1bQgpHoN0BUCXCqDe0tRGxI
         gAllGc27xOgqXmSc1p6ZRbEg03KD5G3GyUnQvEfI6iYk+Tb14w3lPh7zAQ0cs5bF06V0
         b00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AsIkLEhT7cNPKzeY/vcGr9l5TApDMw3CTJU7aytkK5Y=;
        b=lec9z1cw8ejSUS8QnZJIQJoYFHN/4ZVRyDDQCyroPep/4huzIb8MdbhdRwDSwtZkAK
         FGbpq4+8oMPv5Jt0HLklXzOIe4T1FVsAe59CpUeHbH7av+o6Hz8jyBjosByo7ydPCek2
         x7f4pLJ4tLmgVmEZBJ01ThUmRHhREwqUbQSAvvuXGXy6DU1EyUQoyrZeqqE8Wai6OqBC
         oPzFr1t+AqHrlO+5CAdlp+4aniXs8Hhmtm73+kBLuLWGIy78wTBx+oS9VRjIM9Ae2wRG
         P6p+C4jNe1xU0XrkMs0bgvOSLSfMkqBPob8EondaJ8kWIiRmhtWLvJRvR//nkkL74xMd
         RAgQ==
X-Gm-Message-State: ABuFfojnOczC0AIKuQRgO2bsir/IF7CUEN03i6INGc0on20EDPKWnOvj
        No9UA2rv900MhzcwDZlCFgg=
X-Google-Smtp-Source: ACcGV61jX1+x+y3f4QphxQb/lBRxQRovvvLntG6y5JMhFQjXj3XAI47A19ZuCGhRPSiSyVWJvNaa5A==
X-Received: by 2002:a17:906:1cdb:: with SMTP id i27-v6mr3947251ejh.195.1538164632465;
        Fri, 28 Sep 2018 12:57:12 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id v27-v6sm856102ejj.7.2018.09.28.12.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 12:57:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Git for Windows for Unix?
References: <87va6rhqup.fsf@evledraar.gmail.com>
        <20180927160523.GA112066@aiede.svl.corp.google.com>
        <87tvmaj4fq.fsf@evledraar.gmail.com>
        <20180927162623.GB112066@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927162623.GB112066@aiede.svl.corp.google.com>
Date:   Fri, 28 Sep 2018 21:57:11 +0200
Message-ID: <87ftxtieeg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Jonathan Nieder wrote:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> So it's similar to various packages that have "alternates" and are semi
>> or permanently forked, like emacs & xemacs, JDK etc., although I can't
>> recall one offhand that's quite similar to GFW v.s. git.git.
>>
>> My only stake in this is I thought it would be neat to be able to "apt
>> install git-for-windows", but I understand there's a support burden, but
>> if some *nix packagers are interested, maybe never taking it out of the
>> Debian equivalent of "experimental" and saying "this is unsupported, go
>> to the GFW tracker..." when bugs are filed would cut down on the support
>> burden.
>
> If someone else wants to package git-for-windows for Debian, I am
> happy to offer them advice and will not stop them.

Thanks, presumably this is going to be more involved than just
downloading the source .deb, replacing the source tarball &
s/2.19.0/2.19.0.windows.../, since presumably both would need to be
aware of each other not to conflict, or would need update-alternatives
integration.

> That said, that seems to me like a lot of work to avoid adding some
> patches to "next" that belong in "next" anyway.  I understand why the
> Git for Windows maintainer does not always have time to upstream
> promptly, which is why I suggest working with him to find a way to
> help with that.
>
> If there's something I'm missing and Git is actually an uncooperative
> upstream like the cases you've mentioned, then I'd be happy to learn
> about that so we can fix it, too.

That's one and valid way to look at it, convergence would be ideal.

Another way to look at it, which is closer to what I was thinking about,
is to just view GFW as some alternate universe "next" branch (which by
my count is ~2-3k commits ahead of master[1]).

From that perspective if/how/when it's all converging is just inside
baseball. I can install git from "testing" in Debian, and get the same
version that's probably stress tested by tens of thousands of users, or
"experimental" (next) that's probably run by tens or hundreds of people,
maybe thousands.

I'd just like to have some easy way to install the gfw, which I'm
assuming is used by a lot more users than any of those.

One reason to do that these days is to get git-stash and git-rebase
that's a lot faster, yeah I could just pick those from the ML or build
from "pu", but I'm betting the GFW version has been tested a lot more.

I can just build it for myself, the reason I sent this mail was just to
a) see if there were some packagers that were interested in making
non-windows packages for it (e.g. some linux distros) b) it wasn't clear
to me before what the extent of the divergence with vanilla git was, and
that there wasn't much Windows-specific about GFW, it's just a fork
whose maintainer happens to just make releases on that OS (but as I've
learned, also tests them on Linux VMs).

1. $ git log --max-parents=1 --pretty=format:%s v2.19.0...v2.19.0.windows.1|sort|uniq|wc -l
   2346

   sort|uniq because without that we get ~27k commits, a lot of these
   seem to be automated commits made by some bots.
