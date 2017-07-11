Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6165A20357
	for <e@80x24.org>; Tue, 11 Jul 2017 00:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755079AbdGKAFO (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 20:05:14 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36216 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbdGKAFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 20:05:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id q86so57595703pfl.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=U3e7JEt1ZnxddEWg/kytxLv+CssGt0nsrvdOj4Uslwg=;
        b=R1q8EqfRrfncMAyoN3vgjTUbGqmjJE8wMBLp3OlCmGXbWgS1C8ps6utcisWTcF90qI
         6R/K6+i1+pHhGLS+D1i2kxaaKuW0pi7LjorRBo2ylp/lN5Gkh+67/zI4JafhUUqezuPz
         4DzA0urG6RBWe2TzN1MYBcl5eJt3ioE/O0yiURq/R5u6L69wcAK8jrkq/IckJrGiLdSP
         V8qcrq8SwzVifARvDLRNeeDzNMZrBri2nK91B9WrhO5K70fqWkzN14yMy1EsHItFOu9r
         KmfLf23HokwM00/b1qm7LWjQHrfuip/9csBIT3aQDVa5dCBamwtwLuuQFjyFjXXnAJUk
         e+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=U3e7JEt1ZnxddEWg/kytxLv+CssGt0nsrvdOj4Uslwg=;
        b=W4wu8oBW649uBjfXepvjkzdUxvTbwZKf4ktV4SXUUg97aNUD6bL8Z+jWLNZuG5+FDm
         /ElqWwA8AgZ5nwS1DDH5GYFZ7DHOK0xgTsxZ/tdpXzNMVhXX//kTUfnBcjZLsAzQKwky
         FyzXI0Mn43Xh+CvnIE9vKpyXSJEtrtHvjRWkjyO9KTMLYMdhTZT0qogtk8xtGL2m5k9Z
         4ZlVV1qeySthmbegS/wvA7iFeaMq0wZMyhu/+UulJcV0Lgc7GSVyKc32z7DUrBeJA8/y
         upeg1pgnO1dWXwVeL6zgfl4KHzmOF35T2gV7r/lgbLZsHBArWLkGj+fkYi6pyd5IsnC4
         cWuw==
X-Gm-Message-State: AIVw1136YfV2ao7EpMfJT1lMixPB8rVeWg2YHVUsEdPniBjfVrGmFF8T
        l2TriRkQAOG/VCVV8FT0ocbsEGovnBV7
X-Received: by 10.99.44.206 with SMTP id s197mr17202974pgs.116.1499731513400;
 Mon, 10 Jul 2017 17:05:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 10 Jul 2017 17:05:12 -0700 (PDT)
In-Reply-To: <20170710235321.m3xfx2lfsvyirzme@genre.crustytoothpaste.net>
References: <CALs7=Px4nqr6LhOTEQY80WbahRRuaKut-Us5tP7Puda0kb5EdQ@mail.gmail.com>
 <20170710235321.m3xfx2lfsvyirzme@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Jul 2017 17:05:12 -0700
Message-ID: <CAGZ79kYNL7-TPkn2F_i3g5kO4C+1VeZh8ERigA4LTqck1ktLzw@mail.gmail.com>
Subject: Re: Bug - Dirty submodule differences between OSX/Ubuntu
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steve Kallestad <kallestad@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 4:53 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Jul 09, 2017 at 01:42:47PM -0700, Steve Kallestad wrote:
>> change into the submodule directory and run status
>> cd python-mode.el
>> git status
>>
>> On ubuntu:
>> On branch master
>> Your branch is up-to-date with 'origin/master'.
>> nothing to commit, working directory clean
>>
>> On OSX:
>> On branch master
>> Your branch is up-to-date with 'origin/master'.
>> Changes not staged for commit:
>>   (use "git add/rm <file>..." to update what will be committed)
>>   (use "git checkout -- <file>..." to discard changes in working directory)
>>
>>     deleted:    EXTENSIONS
>>
>> no changes added to commit (use "git add" and/or "git commit -a")
>
> This is an artifact of using a case-insensitive file system.  There is a
> directory called "extensions" and so git has not checked out the file
> "EXTENSIONS", as there's already a file system object.  It therefore
> sees it as deleted, since git tracks only files (and not really
> directories, but trees of files).
>
> This repository is always going to show as modified on a
> case-insensitive file system.  You can either ask the maintainers to
> change it, or reformat your disk with a case-sensitive file system.

While this is certainly not the answer Steve hoped for, we should
see if there are any implications by the user of submodules, i.e.
is this behavior reproducable without submodules? (In case it is not,
do we want to have the same checks in place for gitlinks as for
directories?)
