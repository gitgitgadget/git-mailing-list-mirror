Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E664E1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 09:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeHRMlo (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 08:41:44 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:53686 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRMlo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 08:41:44 -0400
Received: by mail-it0-f54.google.com with SMTP id 72-v6so14569756itw.3
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PSY5iAVvFVsia6KlsCXY4E47PQn3NUBktbjl4JF+fJg=;
        b=lYWe4R4Ehbz5TTo8iuqkbkGKITTWFkQD9wFGhks/dfoKqeV3fx/55iixYo8xa0egyI
         ejCWujLjxIVL+00qURGh0Fke4MQQkXOph71HHOhiLY/8UNA0RWmto8pmzJ6QCPMxqGEc
         yHdsa8Cs71E/tSKTSIhnWQdQ4jcAZ7wvzXxylT8G00NTs5BSBtgVYl6d7GGH6Irhg+5X
         hy+a1rj/zMvB1/iB9XM5Qj7CBIhgK74e7eDUm5942UVEzk+Gce6pDuh3zCx3FjV6lV/A
         xijGDnTBNw4N1vmnVueRHUUxtKN7KNgNDsMalYY8frLG8jcfttKxrrGrlFZG57gyh0Yo
         wUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PSY5iAVvFVsia6KlsCXY4E47PQn3NUBktbjl4JF+fJg=;
        b=lZtbMRVhhlPYIk3VS0+XS6bBLtEcOWo+LOCUVoVSEOmWNQTl2j/P1pJ+l5rYMLEHoy
         m2upSPfCM5u7+v3peBXRM+798VPHppg2YavVr5Po/rNmYUZSiSfVGb/ho4C+YETdgn8r
         ZZB28+0stEQ5tYfVJhmIF1Infm+q6ykpEOhujUmqhgf2agZPJJ8JjGWSw7ZQyGsmgXSV
         5fM0R+VHIMoFqRfhktuaIs/1uUUPtWNMWM88Z02+4ieu8bkgGjZw/B3UBPys5PD7LgXC
         D3Y8Cg73QdKtf5u8fzCUyi4d16y4mqkoVYGbOJ6A79Y+hj06tiqXEduG4wzxyaO01lQP
         oNJw==
X-Gm-Message-State: AOUpUlHjT36owk5Sczuw09lYYZ4koI144iGnFOMKS7h5+gDhBO3Y6FmP
        8MYTHnNGfemY6QqqCueMIJojI1uaomjGOBLcm8I=
X-Google-Smtp-Source: AA+uWPyKRiUIpeee7I9jRECu+7kKUCxQx8fQMhPxt7AOjn6gLf+tY1uTqYdw6m19e0Kvtprvq/tjaGbB4vxo+eK5rME=
X-Received: by 2002:a02:6016:: with SMTP id i22-v6mr34985875jac.8.1534584882120;
 Sat, 18 Aug 2018 02:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 18 Aug 2018 11:34:29 +0200
Message-ID: <CAP8UFD1BOqGER4-gnv8VQfsRbZ3yYFEx-ScL3s_WfoKgV=rk6A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 12:44 AM Junio C Hamano <gitster@pobox.com> wrote:

> * cc/delta-islands (2018-08-16) 7 commits
>  - pack-objects: move 'layer' into 'struct packing_data'
>  - pack-objects: move tree_depth into 'struct packing_data'
>  - t5320: tests for delta islands
>  - repack: add delta-islands support
>  - pack-objects: add delta-islands support
>  - pack-objects: refactor code into compute_layer_order()
>  - Add delta-islands.{c,h}
>
>  Lift code from GitHub to restrict delta computation so that an
>  object that exists in one fork is not made into a delta against
>  another object that does not appear in the same forked repository.
>
>  What's the doneness of this topic?

All the suggestions by Peff, you, Duy, Dscho, Ramsay and Szeder Gabor
have been taken into account in the v5 that is in pu.

Except the suggestion by Duy to move 2 fields from 'struct
object_entry' to 'struct packing_data' (which is implemented in
patches 6/7 and 7/7) the suggestions have all been about relatively
small things (documentation, code modernization, regex check,
translation strings, ...) So the code is very similar to the original
code in https://github.com/peff/git/commits/jk/delta-islands which has
been used for years by GitHub in production.

FYI this has been requested from GitLab by Drupal (as well as others)
see https://www.drupal.org/drupalorg/blog/developer-tools-initiative-part-5=
-gitlab-partnership
which contains:

"The timeline for Phase 2 is dependent on GitLab=E2=80=99s resolution of a
diskspace deduplication issue, which they have committed to on our
behalf: https://gitlab.com/gitlab-org/gitlab-ce/issues/23029"
