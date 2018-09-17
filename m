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
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B201F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeIQU16 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 16:27:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33442 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeIQU16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 16:27:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so13206448edv.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=re5c7a7zpFBPw4Ts3qdRLHMEQNYrrqCnfcdfttxst/c=;
        b=DenpwCTtzw62BMO4dB3VH9wAjDw+rldS21xziOktNVt49KNH+1RoO9Rih75fgTZptm
         qbfgZizNKj2TMceh0F2NWdEbP6TUogQrfUAWt433LAxVfNcGcJ2KP2v8i4amqqMMLDYb
         04cJoBjb588A2qbGDJLeNbgBIBgPX0Zo+Ki20qClg3cYkTaGR33fxN4CCeqV7qqNkd5x
         5LmGK26RYWPmA8ZarVorJBDlDU/vLpzExZaj39PwBHzcgtajhSELpPVFl3kWjfILPhXZ
         fzK8n4k83+SK5o9DM3pKwN1wx+r5v/hynZr1/SI+bVYTPMSDNqdJf6fYy0HsLdqVlWxd
         6F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=re5c7a7zpFBPw4Ts3qdRLHMEQNYrrqCnfcdfttxst/c=;
        b=VcJVrObZo4pX3Vu4o0wUm5TJnpevAC0gn6rjfPMLaz/3Q30ETaP9gtuOqExocj0R9X
         DKzxARCjOxnWh1bAZ1QtSZA1cOYJLGfkeyKMiY16974tMChqQbDkIZwKTsHqksnvFUlm
         pJmD9G3MAfnHifpZNUQpKkYaGyEKlcrcFFD+qnCMG80bZ41rD1ldvgyyrtVhL3LKEFGX
         00poUBo0QTIyax8F6LGSQk63ez3KWN0+mZNx41sMOxMkLBwHuVebVVIpPOgPS8BFbABR
         5yv2e11ADhL7NRnBPtd8q3irP9nzteI2LbwmUu1J16YxixXOPVtyUGHOp/C9n2ffOsTN
         STkw==
X-Gm-Message-State: APzg51AUpgxv7JyPB/y1Z0lH1ybUak/eSf+k3kpd/PgMzWcilARNMv6O
        +wZMOgTSwv31iHH3Nf2ViiI=
X-Google-Smtp-Source: ANB0Vdaya69+lz/afGyrr8swO24vYhu17ZJmw5R6cmpJGcXiDsMcho8ov3MOyWdrP6tsZmt0TpSKsA==
X-Received: by 2002:a50:c101:: with SMTP id l1-v6mr42318210edf.126.1537196414157;
        Mon, 17 Sep 2018 08:00:14 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id z30-v6sm7621903edb.4.2018.09.17.08.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 08:00:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Austin <john@astrangergravity.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, larsxschneider@gmail.com,
        pastelmobilesuit@github.com, Joey Hess <id@joeyh.name>
Subject: Re: Git for games working group
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com> <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com> <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com> <20180917135525.GF71477@syl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180917135525.GF71477@syl>
Date:   Mon, 17 Sep 2018 17:00:10 +0200
Message-ID: <874leokw3p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 17 2018, Taylor Blau wrote:

> On Sun, Sep 16, 2018 at 04:55:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> In the hypothetical git-annex-like case (simplifying a bit for the
>> purposes this explanation), for every FILE in your tree you have a
>> corresponding FILE.lock file, but it's not a boolean, but a log of who's
>> asked for locks, i.e. lines of:
>>
>>     <repository UUID> <ts> <state> <who (email?)> <explanation?>
>>
>> E.g.:
>>
>>     $ cat Makefile.lock
>>     my-random-per-repo-id 2018-09-15 1 avarab@gmail.com "refactoring all Makefiles"
>>     my-random-per-repo-id 2018-09-16 0 avarab@gmail.com "done!"
>>
>> This log is append-only, when clients encounter conflicts there's a
>> merge driver to ensure that all updates are kept.
>
> Certainly. I think that there are two things that aren't well expressed
> under this mechanism:
>
>   1. Having a log of locks held against that (a) file doesn't prevent us
>      from introducing merge conflicts at the <file>.lock level, so we're
>      reliant upon the caller first running 'git pull' and hoping that no
>      one beats them out to locking and pushing their lock.

I was eliding a lot of details about how git-annex works under the
hood.

In reality under git-annex it's not a Makefile.lock file, but there's a
dedicated branch (called "git-annex") that stores this sort of metadata,
i.e. who has copies of the the "Makefile" file. That branch has
dedicated merge drivers for the files it manages, so you never get into
these sorts of conflicts.

But yeah, the ad-hoc example I mentioned of:

    echo We created a lock for this >Makefile.lock

*Would* conflict if two users picked a different string, so in practice
you'd need something standard there, i.e. everyone would just echo
"magic git-annex lock" to the file & track it, so even if they did that
same action in parallel it wouldn't conflict.

There's surely other aspects of that square peg of large file tracking
not fitting the round hole of file locking, the point of my write-up was
not that *that* solution is perfect, but there's prior art here that's
very easily adopted to distributed locking if someone wanted to scratch
that itch, since the notion of keeping a log of who has/hasn't gotten a
file is very similar to a log of who has/hasn't locked some file(s) in
the tree.

>   2. Multi-file locks, e.g., "I need to lock file(s) X, Y, and Z
>      together." This isn't possible in Git LFS today with the existing "git
>      lfs lock" command (I had to check, but it takes only _one_ filename as
>      its argument).
>
>      Perhaps it would be nice to support something like this someday in
>      Git LFS, but I think we would have to reimagine how this would look
>      in your file.lock scheme.

If you can do it for 1 file you can do it for N with a for-loop, no? So
is this just a genreal UI issue in git-annex where some commands don't
take lists of filenames (or git pathspecs) to operate on, or a more
general issue with locking?
