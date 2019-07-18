Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83EA91F461
	for <e@80x24.org>; Thu, 18 Jul 2019 23:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGRX4T (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 19:56:19 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:54914 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGRX4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 19:56:18 -0400
Received: by mail-ua1-f73.google.com with SMTP id c21so2844994uao.21
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pcfzpxORGK9w/Zb5nFWqoYao7IYWYTFPeWc1cuXmjmk=;
        b=jeiDmviMxqxt/DzaR3kZhMKlhKwJS5hPs6B2s4tKt4Owdjdl7o9u9Ot23gsw4p3Izg
         ZGriqNanzjhJKQVoI7Kq2ukuSKxSyge0yHejwFfK5iIwsRcTk5QL0aRRGu+IS5/jAfEv
         LkY9AifG4+UdtTrr0RX6TxvMrp+PC/IY02/iG7KqL3IVHU6P2qCV4uRu3R5+CoEnu2xJ
         j3slq8k/f5bfsuxSrVZnVTEWrbbg0T6w+n4BzYWSAdyxw9GzZp0XIQjAcaAPR6Wgtkxi
         AdrtQ4jKNRMz58I9apgT+kRIWKmUUO6234Qr8qf1KKxEMi7yf45VXAonuMUJAVlBbcUk
         yGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pcfzpxORGK9w/Zb5nFWqoYao7IYWYTFPeWc1cuXmjmk=;
        b=fxyLSrrvPwwRCSXPVMbvd2RKDac3GehNH3oOZwv7hYSpeU6P6RJiSW2MAobiRpdZOE
         nImZ8kQtQeROyLRjPm/oAjS/Jh1CYPJTYAeL41CnQ8vdIP8DHGJ3crAyyqoT8XigOXNJ
         kuouOMKs6BdV8U75je+bbVMb5ONMfAXPELIRaDL/Ux+Bg4FRMejL6rhZyYKAs4sUF4BV
         H7t9Qi2kHKXRaa6nnq0VVHvDgtvArLwL14CSxfs0CepGnHKU7Tjgun8sRL0kv3Abz4y8
         k4UKXyOcU1G+QCJ2FqixsQ1iq3VRb/a963rM9tTPnzEzihedy74mxMmq9WjUwxeJpJew
         AzfA==
X-Gm-Message-State: APjAAAVTPOpf/iUAc1jGjG8KHSR9FHKotYLwxqAMMMQWSZeuibBH/2I8
        bTkLwGnmBJBPx4/bEWlyVe8jIH+nf+1EKGG14B5fo9dBpt4ItwGVkmbc+XMGYfa20PyQBoR3hP1
        09X5uvrvShbxY4MhZy5aG74emQSINeL0dFImjkbkYOAOcoJP3t6+Y1qFBCdUQWiI=
X-Google-Smtp-Source: APXvYqxW2qlZNRyBpW3ZW/gUqBrrTfcSKKSkhwdTlP/BrWRjaJl/YSEMB0a9BbPTnamLykAWC7nYWQ2/e0LkZw==
X-Received: by 2002:ac5:ccda:: with SMTP id j26mr2087163vkn.43.1563494177670;
 Thu, 18 Jul 2019 16:56:17 -0700 (PDT)
Date:   Thu, 18 Jul 2019 16:56:15 -0700
In-Reply-To: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
Message-Id: <cover.1563490164.git.steadmon@google.com>
Mime-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 0/4] pre-merge hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, stefanbeller@gmail.com,
        martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I'm resending this cover letter with fixed Message-Id so that threading
@ public-inbox works properly. Sorry for the noise.)

I would like to revive discussion on this series; I have addressed most
of the review comments on the original series sent by Michael, with the
following exceptions:

* Martin's objection on 1/4 that the sample hook would always exit
  successfully is (I believe) incorrect. To test this, I ran
  "/bin/true && exec test 0 == 1" in a /bin/sh subshell, and it
  correctly had a non-zero exit status.

* I'm not sure that I understand Stefan's objections on 4/4 regarding
  the hook's exit status. I am also not familiar with "the same
  (unsolved) issues [as] commit-msg".

I have noted my changes in each commit message in "[js: ...]" sections.

Michael's original series description is below:

Now that f8b863598c ("builtin/merge: honor commit-msg hook for merges",
2017-09-07) has landed, merge is getting closer to behaving like commit,
which is important because both are used to complete merges (automatic
vs. non-automatic).

This series revives an old suggestion of mine to make merge honor
pre-commit hook or a separate pre-merge hook. Since pre-commit does not
receive any arguments (which the hook could use tell between commit and
merge) and in order to keep existing behaviour (as opposed to the other
patch) this series introduces a pre-merge hook, with a sample hook that
simply calls the pre-commit hook.

commit and merge have very similar code paths. f8b863598c implemented
"--no-verify" for merge differently from the existing implementation in
commit. 2/4 changes that and could be first in this series, with the
remaining 3 squashed into 2 commits or 1. I've been rebasing and using
this series for years now, 2/4 is the new-comer which fixed the breakage
from f8b863598c that I encountered because of the no-verify
implementation.

Michael J Gruber (4):
  git-merge: Honor pre-merge hook
  merge: do no-verify like commit
  merge: --no-verify to bypass pre-merge hook
  t7503: add tests for pre-merge-hook

 Documentation/git-merge.txt                   |  2 +-
 Documentation/githooks.txt                    |  7 ++
 Documentation/merge-options.txt               |  4 ++
 builtin/merge.c                               | 18 ++++-
 ...> t7503-pre-commit-and-pre-merge-hooks.sh} | 66 ++++++++++++++++++-
 templates/hooks--pre-merge.sample             | 13 ++++
 6 files changed, 105 insertions(+), 5 deletions(-)
 rename t/{t7503-pre-commit-hook.sh => t7503-pre-commit-and-pre-merge-hooks.sh} (67%)
 create mode 100755 templates/hooks--pre-merge.sample

-- 
2.22.0.657.g960e92d24f-goog

