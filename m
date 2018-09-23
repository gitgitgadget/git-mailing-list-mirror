Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E8D1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIWV4O (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 17:56:14 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40909 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeIWV4N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 17:56:13 -0400
Received: by mail-ed1-f46.google.com with SMTP id j62-v6so14326019edd.7
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l3KMb+v3Jtn0Mgy5M/AuGtiFNkkNnvk9BseCJtL8++4=;
        b=r2PQ+U/r06svVvxuLp3qFH6znZYpCeT4Bm+UzEE3Z3sq2e4/ioZJyvww/Hv4/14Rap
         pW2hb6PWn27sxXofJgV0nCWsS7vuOYqF70tLqT/lnb/g9vmhlfP8xiPyvzvn2afkYlWz
         6yCd7ZMSlOSToRh9g9pAj+ta1qOhBUIcjTR+bCrzEn/Fex3d6dM+yxZdbMf/4QnPZz0+
         yfQsKKm13LZsPNvJtoLgq0IWtdKklw8RzpVn0Gip2oOXJ5RsAiHXarwNxAGYeqFwK77k
         baXY/pIVOqFE5HU2EP3NTQHW9y8i2gZoq19/SrgcalMX8yBmGws4zkV2LqTOq4zv8ONm
         ePJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l3KMb+v3Jtn0Mgy5M/AuGtiFNkkNnvk9BseCJtL8++4=;
        b=o8acqnGEHPRTv+YZ/lXIfXpGo07ySR3er3WMG04ICuNw5YvidHgENxyjDlbEvCIAwj
         BKuVtxMZihyYZUblIJu+VLS14Vqo7EvK0Tzt8Of3Sh3wNeHddJ1Ys6YiDBbHwxzD2MI7
         3CXQkx1kO7Zf64O35bbIHvykqxvSA9Np/AfBNPqBHbLetst0+25yJjsHmZ974c/OclGs
         thDt5TB/m8hKlcgVX/b7dgJstSmSdS4JpVcTCQQh/3iN0gMvKTwJf72xnxvWIT50kA4n
         7c3o+XkrCFou6Y5wQuQlZ11LnIDwMo3pjG91QYkzUeXkPZEfkQm8Pexha476W1/CmN4L
         DHiQ==
X-Gm-Message-State: ABuFfogHOGzRLQqcZ3/rJf5D7vQiRmC0HjVvUowM9+3iV1KCHArTKBcD
        BKW35gvCIZtpSU5Td9T8L38=
X-Google-Smtp-Source: ACcGV63Drn/2QtK/A1myfik/VdIMY9dxQcTGivi2u7dNUm08HBO0AxopnMCx1GZv5O/N6Tn3kL8Qqg==
X-Received: by 2002:a50:9e65:: with SMTP id z92-v6mr7800971ede.204.1537718296936;
        Sun, 23 Sep 2018 08:58:16 -0700 (PDT)
Received: from [192.168.2.7] ([217.9.127.11])
        by smtp.gmail.com with ESMTPSA id m22-v6sm439364edp.0.2018.09.23.08.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 08:58:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Import/Export as a fast way to purge files from Git?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cTLjThK4CVzfgV=Uk5OumpjhaQD_YNXmg7pNtkkUFiiyQ@mail.gmail.com>
Date:   Sun, 23 Sep 2018 17:58:14 +0200
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE9CF60B-7DCB-4B82-9C96-663E145CAD56@gmail.com>
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
 <CAPig+cTLjThK4CVzfgV=Uk5OumpjhaQD_YNXmg7pNtkkUFiiyQ@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Sep 23, 2018, at 4:55 PM, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sun, Sep 23, 2018 at 9:05 AM Lars Schneider =
<larsxschneider@gmail.com> wrote:
>> I recently had to purge files from large Git repos (many files, many =
commits).
>> The usual recommendation is to use `git filter-branch --index-filter` =
to purge
>> files. However, this is *very* slow for large repos (e.g. it takes =
45min to
>> remove the `builtin` directory from git core). I realized that I can =
remove
>> files *way* faster by exporting the repo, removing the file =
references,
>> and then importing the repo (see Perl script below, it takes ~30sec =
to remove
>> the `builtin` directory from git core). Do you see any problem with =
this
>> approach?
>=20
> A couple comments:
>=20
> For purging files from a history, take a look at BFG[1] which bills
> itself as "a simpler, faster alternative to git-filter-branch for
> cleansing bad data out of your Git repository history".

Yes, BFG is great. Unfortunately, it requires Java which is not =
available
on every system I have to work with. I required a solution that would =
work
in every Git environment. Hence the Perl script :-)


> The approach of exporting to a fast-import stream, modifying the
> stream, and re-importing is quite reasonable.

Thanks for the confirmation!


> However, rather than
> re-inventing, take a look at reposurgeon[2], which allows you to do
> major surgery on fast-import streams. Not only can it purge files from
> a repository, but it can slice, dice, puree, and saute pretty much any
> attribute of a repository.

Wow. Reposurgeon looks very interesting. Thanks a lot for the pointer!

Cheers,
Lars


> [1]: https://rtyley.github.io/bfg-repo-cleaner/
> [2]: http://www.catb.org/esr/reposurgeon/

