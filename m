Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A7B1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 11:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeKAUEd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 16:04:33 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40178 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKAUEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 16:04:33 -0400
Received: by mail-wm1-f47.google.com with SMTP id b203-v6so979137wme.5
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ry6uvvdUybdWv/goC8ZLgHxO+u4WUydrzh3QiV3jnGo=;
        b=H1EEOyPrzMNa+KTm2F0bx+1qNVKzJRnaGzHlfYp12NGilrvB3n3gCd0SJWi/4Keww/
         I75MZ2D37hnOr5Fxdj9liIeLjUZGfk1DYWzqMf+QLuBQ8bLqe9nAU3q8lDeaMOupsyor
         dnPddhCF+uws3Wq9Pl97SQYXoeEU1Adyc/qr7Ozd1/DwJauABPVeuu5JN/68mcZFhkoD
         FpH992yHX/kCcwARk5coMw3KM8a3AJEUFFcFYTHhxf5PXeSXqCPImswBlJTVp09cjvKt
         3WDDq666KRYXXjd2WAK+l5x8OZZES4TPt0y+22LRgdF33I9rl2aoDYsAJ/qNYJOMPJLt
         fQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ry6uvvdUybdWv/goC8ZLgHxO+u4WUydrzh3QiV3jnGo=;
        b=mHzVXI+8PDLP+wVfXIfWUjHES5xV0qq7monZMZE65Q+5lZVgFt9xLY2TR3sKbsh1MC
         xIGZj0vXnqcQZA142ssag04gqUleZ+FF9OWp/p0dsWAdAi3s0gpFD0bktv1LtUpo8vi6
         7tBeyCgdLAlTJ6aVeblR4UVpGvzgeELpcxkGarD3ktuQ+ydkJf9RSXF85F6Xu6hT0eRu
         5sV1fGVoNxZjrOaczpFX5UDnaRGthX9Id0QDJ7RIbGOFYj/mUmmY1XkKqsI8esN9LTnL
         q97Mil3edTvmC5E5DmXy/UBKIgr93aaemvawnu41EmB3a1osV5WO5qTFqG4hq+pBBrEq
         K4ag==
X-Gm-Message-State: AGRZ1gIXZndRj+ca+a/XNr6OXLHaWhnHPxcxdEFPB/HbgpiHK8pqamzi
        psTbbemSdayKJjIjrzk+fvc=
X-Google-Smtp-Source: AJdET5eN66B0lrl2DkSzi4y29hJevxcyj/h69d7jUHH59sLDsCuYCuXN6Nr+10/hckslTUAXT2wTug==
X-Received: by 2002:a1c:104:: with SMTP id 4-v6mr5024561wmb.69.1541070123469;
        Thu, 01 Nov 2018 04:02:03 -0700 (PDT)
Received: from evledraar ([2001:981:2f6f:1:6765:91b4:348a:a673])
        by smtp.gmail.com with ESMTPSA id m141-v6sm3593843wmd.14.2018.11.01.04.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 04:02:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/* topics (was: Re: What's cooking in git.git (Nov 2018, #01; Thu, 1))
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 01 Nov 2018 12:02:01 +0100
Message-ID: <8736slkqmu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, Junio C Hamano wrote:

> * ab/push-dwim-dst (2018-10-29) 9 commits
>  - SQUASH???
>  - push doc: document the DWYM behavior pushing to unqualified <dst>
>  - push: add DWYM support for "git push refs/remotes/...:<dst>"
>  - push: test that <src> doesn't DWYM if <dst> is unqualified
>  - push: add an advice on unqualified <dst> push
>  - push: move unqualified refname error into a function
>  - push: improve the error shown on unqualified <dst> push
>  - i18n: remote.c: mark error(...) messages for translation
>  - remote.c: add braces in anticipation of a follow-up change
>
>  "git push $there $src:$dst" rejects when $dst is not a fully
>  qualified refname and not clear what the end user meant.  The
>  codepath has been taught to give a clearer error message, and also
>  guess where the push should go by taking the type of the pushed
>  object into account (e.g. a tag object would want to go under
>  refs/tags/).
>
>  The last few steps are questionable.
>  cf. <87in1lkw54.fsf@evledraar.gmail.com>

Will send an update to this soon.

> * ab/pack-tests-cleanup (2018-10-31) 3 commits
>  - index-pack tests: don't leave test repo dirty at end
>  - pack-objects tests: don't leave test .git corrupt at end
>  - pack-objects test: modernize style
>
>  A couple of tests used to leave the repository in a state that is
>  deliberately corrupt, which have been corrected.
>
>  Will merge to 'next'.

Thanks!

> * ab/reject-alias-loop (2018-10-19) 1 commit
>   (merged to 'next' on 2018-10-26 at bc213f1bef)
>  + alias: detect loops in mixed execution mode
>
>  Two (or more) aliases that mutually refer to each other can form an
>  infinite loop; we now attempt to notice and stop.
>
>  Discarded.
>  Reverted out of 'next'.
>  cf. <87sh0slvxm.fsf@evledraar.gmail.com>

*nod* will try to find time to work on this soon, but treating it as
non-urgent.

Could you please pick up
https://public-inbox.org/git/20181024114725.3927-1-avarab@gmail.com/ ?
It seems to have fallen between the cracks and addressed the feedback on
v1, and looks good to me (and nobody's objected so far...).
