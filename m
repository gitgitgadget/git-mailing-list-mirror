Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E765E1F419
	for <e@80x24.org>; Tue, 12 Dec 2017 09:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdLLJaz (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 04:30:55 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:44186 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdLLJax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 04:30:53 -0500
Received: by mail-it0-f49.google.com with SMTP id b5so22984094itc.3
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IuQDe0NyCuOKTHkN4FiEOLAHlOPnNy1dF/ljqc2qpKk=;
        b=NCS/7cYTrlOmw/GGVTvOjkuTIkfxwT0VW8Yaxy61ZV9u4mWzttI16D1xeGV0RZTwkZ
         F1CjDZnNpAlhPWJZ1JzILI/cpwe7cV/SrHOdDB+PIkwE+kLOVp9XA+0DsZtaBoqk+97O
         E70Yi2vzQAlGp6Nz8pX23BTF/+qKeivflveP6+LB/FvsIjMYdY0616AMyZDAtreXainR
         t0I4d66tmHcP8xC81PpObGx2mOuOIguzoHblCDiIhZ7NKonn03KJCkSkruYjWHh7syGZ
         DqfcBc2yLwgMqDGcBBN6O6C2a9HBzbYE6xeykheeZ1Tkutf7Kl8i3LiN9JG84f8F8o52
         hxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IuQDe0NyCuOKTHkN4FiEOLAHlOPnNy1dF/ljqc2qpKk=;
        b=BfzuPGN0eH5k7R+C/hu0RSUMUqgICHbVZ/4N4A9adRJryZRWYAomr7HlBltrqx7yTv
         X6H0V/DKTTNOBpfmKdHsQn61Ug2GH20sQE6S/8/knWX8fUVfOh1Ew/qG8lSdyZD2qnBH
         mzIv08jgCmNfLMQIoNylDOOVFkFTyN3ZDqoK3eg9fAcMiV6oGPFLOKefWk5AQR6SmDzG
         KFbudKBAz+I7+4PE6SuIjg72N2GM5lV2v4J7MqZNTvqa5VGvnB3vjeUWyScVOUEqDGgT
         bXnqYWmamHWztUEbnvEw76De8Wwb/C3IQE6t6P9Zn9a+zvwis/T108yQwU4yYN9zZkX7
         fT1w==
X-Gm-Message-State: AKGB3mIbwylltGaXadDFS4NbxjwmiOy2zbuCdLSCHT/wMGMElYvVyOgb
        /RsepeB+kA3HJ0pf0a7cYR4tVidF76hHEWOoAKseyGZn
X-Google-Smtp-Source: ACJfBouRkMog88DuBZQSqQX/jy8Pg3/XX7G8jwzH1Lrxkk3unbUWjJwFVkeFd0sLT0qeYwyH+aQVDqVvoZE/3e50MzU=
X-Received: by 10.107.69.3 with SMTP id s3mr2580381ioa.67.1513071052863; Tue,
 12 Dec 2017 01:30:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Tue, 12 Dec 2017 01:30:52 -0800 (PST)
In-Reply-To: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 12 Dec 2017 10:30:52 +0100
Message-ID: <CAP8UFD3Jt+0Lq9Yx_7x3sJD+jG+A25bAgDg7zp+dZV43+1-vow@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * jh/object-filtering (2017-12-05) 9 commits
>   (merged to 'next' on 2017-12-05 at 3a56b51085)
>  + rev-list: support --no-filter argument
>  + list-objects-filter-options: support --no-filter
>  + list-objects-filter-options: fix 'keword' typo in comment
>   (merged to 'next' on 2017-11-27 at e5008c3b28)
>  + pack-objects: add list-objects filtering
>  + rev-list: add list-objects filtering support
>  + list-objects: filter objects in traverse_commit_list
>  + oidset: add iterator methods to oidset
>  + oidmap: add oidmap iterator methods
>  + dir: allow exclusions from blob in addition to file
>  (this branch is used by jh/fsck-promisors and jh/partial-clone.)
>
>  In preparation for implementing narrow/partial clone, the object
>  walking machinery has been taught a way to tell it to "filter" some
>  objects from enumeration.
>
>
> * jh/fsck-promisors (2017-12-05) 12 commits
>  - gc: do not repack promisor packfiles
>  - rev-list: support termination at promisor objects
>  - fixup: sha1_file: add TODO
>  - fixup: sha1_file: convert gotos to break/continue
>  - sha1_file: support lazily fetching missing objects
>  - introduce fetch-object: fetch one promisor object
>  - index-pack: refactor writing of .keep files
>  - fsck: support promisor objects as CLI argument
>  - fsck: support referenced promisor objects
>  - fsck: support refs pointing to promisor objects
>  - fsck: introduce partialclone extension
>  - extension.partialclone: introduce partial clone extension
>  (this branch is used by jh/partial-clone; uses jh/object-filtering.)
>
>  In preparation for implementing narrow/partial clone, the machinery
>  for checking object connectivity used by gc and fsck has been
>  taught that a missing object is OK when it is referenced by a
>  packfile specially marked as coming from trusted repository that
>  promises to make them available on-demand and lazily.

I am currently working on integrating this series with my external odb
series (https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/).

Instead of using an "extension.partialclone" config variable, an odb
will be configured like using an "odb.<odbname>.promisorRemote" (the
name might still change) config variable. Other odbs could still be
configured using "odb.<odbname>.scriptCommand" and
"odb.<odbname>.subprocessCommand".

The current work is still very much WIP and some tests fail, but you
can take a look there:

https://github.com/chriscool/git/tree/gl-promisor-external-odb440
