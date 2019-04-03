Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8F320248
	for <e@80x24.org>; Wed,  3 Apr 2019 06:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDCG72 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 02:59:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54630 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCG72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 02:59:28 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so7886712ite.4
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 23:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40DekmwSQ3lRk04SzR6vghWrms2UmItbLhcT5TXM2Kk=;
        b=lPhCVerAGKj1U99aDj5AILIwAgVGcLxv6t++Jq5o3SpeDR8aQUx669a9b0MkhyDTjI
         j4/glk2wUUYxQrvrjpblAKVb5RZczNDPgDkn91yUOKE8+hRjh5gKOOkhEkor9YAFEZHg
         kq6mZZ0ApWHYNT2hqUgkilHa4iBdCHQepOJjjwq6nLc/WhWnZfEY6tZV5bxxWDUuv/V0
         op/bK2vtss2B3kiN3T6/rbeQ9H/iAKw9GeapiNBNkytuuhH1BYDqvaHMZgikTAbHFiSK
         7mwJgstwtDOoss9gV13qzcY3LFwQiZAYAXU6tUM7h13mj6u4K0iwoZHvkOvA9sMyOYzv
         qzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40DekmwSQ3lRk04SzR6vghWrms2UmItbLhcT5TXM2Kk=;
        b=rf5Momyn7lcNxtCzgVDErscz89hwh7UtMRcXetGBf+DrIS0YZfQmm+kbZX7a3J/JYL
         7WAW8ZvCoz3LjQbGal3+oafkvNmzwlHhnFPek3roD8ocs3/8AULMlXYeSu6h7Py/nBXy
         I281nahISOjB1eDsv8CTjv1HNJXgMUB+HGbXyER+gs1Lx995e246EYGiYbSzhdCkn0ih
         IGQ8QzEZ6S5q9AdFgttEpT6e+MPZsx/JwoP2ElOkQ9hm4RJcEb37pto2inqgNrG08/La
         Fpe/Vi0rlgNRd6WHw8AhcJX26/Hcf63Axh+4aYKBJogjLFYGVFCYw+hlzrY+Wt1h7E8K
         tzew==
X-Gm-Message-State: APjAAAXl84TTXnNmS3suvfz+Rx4WUGTfnrW1yjEGAOFh0aNRDrnPTVX9
        8C1slxgoH2+a4W/lXNczTKB+X0OIrDoy/t8yrjkFNw==
X-Google-Smtp-Source: APXvYqwLfR7ubhKfjAKMLxC/e4GGKSS4OkcbRySwu5/xDoxnFHuPoGTKG5CKShZr37IYBR1mSCybrRAXYXxUUEPhA/s=
X-Received: by 2002:a24:4702:: with SMTP id t2mr631243itb.105.1554274767301;
 Tue, 02 Apr 2019 23:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR08MB41993844F57794DDF4B33B8F8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
 <AM6PR08MB4199B076CB886AE814AFF4528D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4199B076CB886AE814AFF4528D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 2 Apr 2019 23:59:15 -0700
Message-ID: <CAGyf7-HUAoYURDnnp+nq+4EQkysoTE+f_WK8cEVPCHP065rv6A@mail.gmail.com>
Subject: Re: Fw: git describe issue
To:     Amiel Elboim <amielel@matrix.co.il>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 2, 2019 at 11:47 PM Amiel Elboim <amielel@matrix.co.il> wrote:
> Hi!
>
> I've found strange behavior with 'git describe' command, look like for me as bug.
>
> In the case I create 2 tags on same commit and I run 'git describe --tags' I expect to get the latest tag, but always I get the first tag I created on the commit.
>
> Unlike git-describe documentations - "The command finds the most recent tag that is reachable from a commit. "
>
> Simple example -
>
> amiel@CLINIKALDEV10:~/Xpress$ git tag v1
> amiel@CLINIKALDEV10:~/Xpress$ git tag v2
> amiel@CLINIKALDEV10:~/Xpress$ git describe --tags
> v1

With this example, Git has no way to know which tag is "newer".
They're lightweight tags, which means they have no metadata of their
own; they just tag a commit. That means, as far as "age" goes, they're
both the same because their age is drawn from the tagged commit, which
is the same for both. (Since tag names are entirely free-form, I'm not
sure Git makes any effort to try and parse them to "guess" which is
newer; that seems like a Sisyphean task to me.)

If you run this with annotated tags, you get different output (at
least on Git 2.20.1, what I happened to have installed; you never
mentioned your Git version)
incom@Jael MINGW64 /c/Temp/first.git (BARE:master)
$ git tag -a v1
incom@Jael MINGW64 /c/Temp/first.git (BARE:master)
$ git tag -a v2
incom@Jael MINGW64 /c/Temp/first.git (BARE:master)
$ git describe --tags
v2

Hope this helps!
Bryan
