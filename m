Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F8E1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 13:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeIQTWx (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:22:53 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:35889 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQTWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:22:53 -0400
Received: by mail-io1-f53.google.com with SMTP id q5-v6so11501558iop.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uUfKS/rX0+r1psvL+1pDzQwTco4R+FPUyfCD+nkJDHU=;
        b=DTOuBT8LBMY5rXKzmWSV6t7HRyK10XxCgkTya5U1EX5afjNLHNH+ScArSucNKl3Kkz
         /Z2dQ9O5aZ79d8oUb4Wgjc7fpFk0/ELwY8cRRqpeQ0vs+3ONTNJCbFcyDAyB0jknU+zm
         oCaG6e7K2J0Hlyoe5j2yLMkyR5cF35zSokAwjIhfX8SPUJc7fI7Hcew2FafIjrCFAOXp
         fhLhRdB0Upn600LjirvcfqDGM4eayLaWeOjpwfixE+vQh6Mk5YiYQSsj0/3VvkIRiqsF
         dzdN30q8EfFViQ+m9NVtgWE53/tuc5diL78fxeCugBzeq7t08QIQFq5mzUZrJJvoXsBm
         WhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uUfKS/rX0+r1psvL+1pDzQwTco4R+FPUyfCD+nkJDHU=;
        b=GLTyF7M7NyjEmjOHN0STGVtTaFlPpn2n0eT6bbQzHPb1WcyOc/I2Ach8D1rDz0mESx
         jaS9IuM6TbCUqH2VBEdcQwuqNax6FFLPLpaFL4lXZ+n81HAMhUvpTC8s1JQrJOkPjr88
         TXHpkkNXfMU/KkBH14WaKk8ddd8lIQhPwPqKe7ECw83Fr7R9pXvjyY/46vHNTj871s3L
         2giwuwO2ijOwyruHB+QUCsPeutmVkh2OQ5632bdIQTgyaqyprJEe8b+xsILPYFqbKWtz
         E3PHnKP/6vuM5nnDjslJoh1oy178hL1Rgb77b04s3haPmnd9kdv5YenQ2aedcJamQYH0
         lq2w==
X-Gm-Message-State: APzg51Aet8c5p5ROOtUO+Fk4Tj5ndNdgjY0okUrkV0ktyeFAxRQEjQjQ
        dOskE9/lHDRQJ6ig2OzpRn1YwA==
X-Google-Smtp-Source: ANB0VdZYbdSdOIsG9P/UFAD/3503k2QsIS5YnIXNYI+obyzEclyCTi+UcpDmOvvtyQC8gyfzH/0NDw==
X-Received: by 2002:a6b:2387:: with SMTP id j129-v6mr20314790ioj.86.1537192525881;
        Mon, 17 Sep 2018 06:55:25 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id m5-v6sm3653558itb.6.2018.09.17.06.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 06:55:24 -0700 (PDT)
Date:   Mon, 17 Sep 2018 09:55:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        John Austin <john@astrangergravity.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, larsxschneider@gmail.com,
        pastelmobilesuit@github.com, Joey Hess <id@joeyh.name>
Subject: Re: Git for games working group
Message-ID: <20180917135525.GF71477@syl>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
 <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl>
 <878t41lcfi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t41lcfi.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 16, 2018 at 04:55:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> In the hypothetical git-annex-like case (simplifying a bit for the
> purposes this explanation), for every FILE in your tree you have a
> corresponding FILE.lock file, but it's not a boolean, but a log of who's
> asked for locks, i.e. lines of:
>
>     <repository UUID> <ts> <state> <who (email?)> <explanation?>
>
> E.g.:
>
>     $ cat Makefile.lock
>     my-random-per-repo-id 2018-09-15 1 avarab@gmail.com "refactoring all Makefiles"
>     my-random-per-repo-id 2018-09-16 0 avarab@gmail.com "done!"
>
> This log is append-only, when clients encounter conflicts there's a
> merge driver to ensure that all updates are kept.

Certainly. I think that there are two things that aren't well expressed
under this mechanism:

  1. Having a log of locks held against that (a) file doesn't prevent us
     from introducing merge conflicts at the <file>.lock level, so we're
     reliant upon the caller first running 'git pull' and hoping that no
     one beats them out to locking and pushing their lock.

  2. Multi-file locks, e.g., "I need to lock file(s) X, Y, and Z
     together." This isn't possible in Git LFS today with the existing "git
     lfs lock" command (I had to check, but it takes only _one_ filename as
     its argument).

     Perhaps it would be nice to support something like this someday in
     Git LFS, but I think we would have to reimagine how this would look
     in your file.lock scheme.

Thanks,
Taylor
