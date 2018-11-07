Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F1E1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 12:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeKGWAI (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 17:00:08 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38117 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGWAH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 17:00:07 -0500
Received: by mail-ed1-f42.google.com with SMTP id a2-v6so8676896edi.5
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 04:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1OHfbfHvI9Cso93k5j+8eiCgYLybU51eR38WCtjy6VM=;
        b=Odj0UXhGCv/9T3jjr2wIsLb4IbjWpM8g9RCR8afJp04NO3q/ik597j3nSrs2ejX+dq
         aa87QZvCXCodBOocdLA1tScTEWIfff3dlnhR1+h5MAh4gvqG5rVyMGOpYq6+w6wipFYm
         cZXkTs7hpEFpHwHap/mbvWX1V9n+kEp1Xb4u/V5u4+zIrfdBram9Lq54SVVOg3zjUVdf
         J7QfK//5j2qj+z5ocH10MLNq4k/ikO2AgRb2LK5tJmWD+VVY9R0wXAlKSmTygLzFwjoR
         e2c0MvoJzhiaHpOblrJIM1QtJH+3+aT+m8/0IGKhxe8iEnRUockI+t+Ct2QG2udNilFt
         yCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1OHfbfHvI9Cso93k5j+8eiCgYLybU51eR38WCtjy6VM=;
        b=n3ETVDqxBGMOsb55ImcAgJauCbB9VtmCfAeSkDyU0FnlT2dE47FRq4RqY1IDALySe4
         uFdSbhisNDthK8qePwUdBXHfWxYC+3cvEuGKG+UBJMggEAAF21Pc/5CoZMlor3S/jn8s
         NF7dfUjDqVJ4CJaC/0XrcC9ik7EcpqYyQTZHGoW9vw1ZswMMqplTan7Ag2OCxe44gZrn
         Jvk/HkVYGdGbuerS/tOf9Za2LCS5X+K0mFwhNHIM7kKI32XRmRcG63WSmNf0uShx1obS
         CSTqVMSg5ntX9BEX2oCKFsEk4MEX/rS09gY7Z9M/mN7926NVJaTL2iPim6vX8Sqfmq+u
         ji0w==
X-Gm-Message-State: AGRZ1gJIOll9CPPILOWhhOLdsWfOkDOQRK2BxxhjYkt35YHb1JIsWTN7
        vkZwKhUqUaVbVRmCCA6fe1g=
X-Google-Smtp-Source: AJdET5eMWC1PJ3A8Xw4mOL+jNDf+HZ026MVsLgkrGEXguBp5lsgX0SGKju+jgWOnL+RsnZjutTYVrA==
X-Received: by 2002:a50:a7a2:: with SMTP id i31-v6mr22154edc.236.1541593794683;
        Wed, 07 Nov 2018 04:29:54 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id n16-v6sm122234eja.6.2018.11.07.04.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 04:29:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 07 Nov 2018 13:29:52 +0100
Message-ID: <87sh0d5av3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 07 2018, Junio C Hamano wrote:

> * ab/range-diff-no-patch (2018-11-07) 1 commit
>  - range-diff: add a --no-patch option to show a summary
>
>  "range-diff" learns the "--no-patch" option, which can be used to
>  get a high-level overview without the actual line-by-line patch
>  difference shown.
>
>  Will merge to 'next'.

Per <20181107122202.1813-1-avarab@gmail.com> it turns out this whole
thing should have been a bugfix instead, sent a v2.

> * ab/dynamic-gettext-poison (2018-11-02) 1 commit
>  - i18n: make GETTEXT_POISON a runtime option
>
>  On hold.
>  cf. <20181102163725.GY30222@szeder.dev>

Hope to sent update soon...

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

...ditto...

> * ab/pack-tests-cleanup (2018-10-31) 3 commits
>   (merged to 'next' on 2018-11-03 at b4a39595bb)
>  + index-pack tests: don't leave test repo dirty at end
>  + pack-objects tests: don't leave test .git corrupt at end
>  + pack-objects test: modernize style
>
>  A couple of tests used to leave the repository in a state that is
>  deliberately corrupt, which have been corrected.
>
>  Will merge to 'master'.

Thanks!

> * nd/config-split (2018-10-29) 79 commits
>   (merged to 'next' on 2018-11-03 at a336559101)
>  + config.txt: remove config/dummy.txt
>  + config.txt: move worktree.* to a separate file
>  + config.txt: move web.* to a separate file
>  + config.txt: move versionsort.* to a separate file
>  + config.txt: move user.* to a separate file
>  + config.txt: move url.* to a separate file
>  + config.txt: move uploadpack.* to a separate file
>  + config.txt: move uploadarchive.* to a separate file
>  + config.txt: move transfer.* to a separate file
>  + config.txt: move tag.* to a separate file
>  + config.txt: move submodule.* to a separate file
>  + config.txt: move stash.* to a separate file
>  + config.txt: move status.* to a separate file
>  + config.txt: move splitIndex.* to a separate file
>  + config.txt: move showBranch.* to a separate file
>  + config.txt: move sequencer.* to a separate file
>  + config.txt: move sendemail-config.txt to config/
>  + config.txt: move reset.* to a separate file
>  + config.txt: move rerere.* to a separate file
>  + config.txt: move repack.* to a separate file
>  + config.txt: move remotes.* to a separate file
>  + config.txt: move remote.* to a separate file
>  + config.txt: move receive-config.txt to config/
>  + config.txt: move rebase-config.txt to config/
>  + config.txt: move push-config.txt to config/
>  + config.txt: move pull-config.txt to config/
>  + config.txt: move protocol.* to a separate file
>  + config.txt: move pretty.* to a separate file
>  + config.txt: move pager.* to a separate file
>  + config.txt: move pack.* to a separate file
>  + config.txt: move notes.* to a separate file
>  + config.txt: move mergetool.* to a separate file
>  + config.txt: move merge-config.txt to config/
>  + config.txt: move man.* to a separate file
>  + config.txt: move mailmap.* to a separate file
>  + config.txt: move mailinfo.* to a separate file
>  + config.txt: move log.* to a separate file
>  + config.txt: move interactive.* to a separate file
>  + config.txt: move instaweb.* to a separate file
>  + config.txt: move init.* to a separate file
>  + config.txt: move index.* to a separate file
>  + git-imap-send.txt: move imap.* to a separate file
>  + config.txt: move i18n.* to a separate file
>  + config.txt: move http.* to a separate file
>  + config.txt: move ssh.* to a separate file
>  + config.txt: move help.* to a separate file
>  + config.txt: move guitool.* to a separate file
>  + config.txt: move gui-config.txt to config/
>  + config.txt: move gpg.* to a separate file
>  + config.txt: move grep.* to a separate file
>  + config.txt: move gitweb.* to a separate file
>  + config.txt: move gitcvs-config.txt to config/
>  + config.txt: move gc.* to a separate file
>  + config.txt: move fsck.* to a separate file
>  + config.txt: move fmt-merge-msg-config.txt to config/
>  + config.txt: move format-config.txt to config/
>  + config.txt: move filter.* to a separate file
>  + config.txt: move fetch-config.txt to config/
>  + config.txt: move fastimport.* to a separate file
>  + config.txt: move difftool.* to a separate file
>  + config.txt: move diff-config.txt to config/
>  + config.txt: move completion.* to a separate file
>  + config.txt: move credential.* to a separate file
>  + config.txt: move commit.* to a separate file
>  + config.txt: move column.* to a separate file
>  + config.txt: move color.* to a separate file
>  + config.txt: move clean.* to a separate file
>  + config.txt: move checkout.* to a separate file
>  + config.txt: move browser.* to a separate file
>  + config.txt: move branch.* to a separate file
>  + config.txt: move blame.* to a separate file
>  + config.txt: move apply.* to a separate file
>  + config.txt: move am.* to a separate file
>  + config.txt: move alias.* to a separate file
>  + config.txt: move add.* to a separate file
>  + config.txt: move core.* to a separate file
>  + config.txt: move advice.* to a separate file
>  + Update makefile in preparation for Documentation/config/*.txt
>  + Merge branches 'bp/reset-quiet' and 'js/mingw-http-ssl' into nd/config-split
>  (this branch uses bp/reset-quiet.)
>
>  Split the overly large Documentation/config.txt file into million
>  little pieces.  This potentially allows each individual piece
>  included into the manual page of the command it affects more easily.
>
>  Will merge to 'master'.
>
>  This is a painful conversions while many other topics in flight
>  wants to add to or edit the documentation of configuration
>  variables.

Yeah the sooner this lands in master the better. I stopped deploying
internal versions of git while this is in flight. Having topics I want
to apply (based off master) + deploying next + resolving conflicts was
too painful to bother with.

