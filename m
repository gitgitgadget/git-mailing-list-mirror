Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07021FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 18:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030560AbdDSSD5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 14:03:57 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35153 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030557AbdDSSD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 14:03:56 -0400
Received: by mail-ua0-f181.google.com with SMTP id f10so25339503uaa.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8bTIDD4PLK3O1ukvSwdO3H7JwSUrGqRJ3+Ii7+mBDY0=;
        b=eKHjKET9wOlCUcqIyjMMiPNCygkE1GzZ7JlHBkCj08NlcaNleRjXyUl1pvrjeXI2fv
         1pVbrix37XuhMByTeipRl82Y41g2MU+VNICsxvqIJyH/mvmqEzdfqjCmn7FsEN87c4x7
         O7n5liPz78KauJB+5dknknxWtDosbuVC904YgWYp3H/QRCm6QfARZJdQ/A2uM/nzyBwl
         r1BqTn0I9ghUnM4VYPyyB3oh2LiSBOF07bML6ryHA+Ye27aBHgzq/8C+3Axrb4ydx099
         BGz8FAjpbidtQJhHz2tgxjt4KgG5XQKrxrhWqvTpgC4RR5OXWCpEkv470K+Ck7bj7iDC
         52YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8bTIDD4PLK3O1ukvSwdO3H7JwSUrGqRJ3+Ii7+mBDY0=;
        b=DEX2c7RpouMJSHb9Y1oa0zP45C6Eu8prhziSzA1bLRcB55Fqbl2wIBNEuATn+odX6y
         AcC2s4r2veSROm7Kxlj4oeEO02PrmUwPMDEPrdr8DoYqVkDoy4sbtplhyWOjGPGhFbFy
         53YL482fMlEZYohcZoW5IHYIQx/7fzIKQx7CYhbM94Gwg2RR89QXvKWeKi14nazRpohw
         FMKJPdZXYdSsl+XyRqsxq3Z3BrrvlcpoSjvwAfgDMTXWNh/z3ajXf4xcnN264DRBPzPf
         4OTJfMynp2Bm35ilj8Y0QxmbbHyDreQe4QVkZ0HECdyyE8cPTExsP9Lr0cFMUjUrefvR
         g7Tg==
X-Gm-Message-State: AN3rC/75o9n507eEerCaLKD/1orf08ZR2TbMDbwTq1lwljXfIE+ZBk4o
        43mlv6TYJCDVSYNKe+hC0riPn1+4CA==
X-Received: by 10.31.199.4 with SMTP id x4mr1649788vkf.35.1492625030003; Wed,
 19 Apr 2017 11:03:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.105 with HTTP; Wed, 19 Apr 2017 11:03:09 -0700 (PDT)
In-Reply-To: <20170419170509.GC28740@aiede.svl.corp.google.com>
References: <CAJZjrdWNQFkWwAO_hmHMzVGNNMfynxsvbWufGvRWX8bZD19Epw@mail.gmail.com>
 <20170419170509.GC28740@aiede.svl.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 19 Apr 2017 13:03:09 -0500
Message-ID: <CAJZjrdWey6atV0rQUborVH0mnev5j8q3Qsny1dgr9hj8_Hz5uw@mail.gmail.com>
Subject: Re: [bug?] docs in Documentation/technical/ do not seem to be distributed
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 12:05 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Samuel Lijin wrote:
>
>> It's possible this may have nothing to do with the Git project itself
>> because I have absolutely no idea how this is handled on the packaging
>> side or, possibly, if this is actually intended.
>>
>> There are a couple of links floating around in the man pages pointing
>> to pages in technical/, such as to technical/api-credentials.html in
>> gitcredentials(7) [1]. On the website and man pages for Arch Linux and
>> Ubuntu, this link is broken.
>
> This sounds like a packaging bug in Arch Linux and Ubuntu.
>
> That said, at least in Ubuntu, I am not able to reproduce it.  Do
> you have the git-doc (or git-all, which depends on git-doc) package
> installed?

That was the answer on the Ubuntu machine. Doesn't apply to Arch,
though, so I guess I'll reach out upstream there. I've also opened
#994 on the git/git-scm.com repo for this.

Out of curiosity, do you know why it's distributed like that?

Thanks,
Sam
