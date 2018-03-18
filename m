Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557811F404
	for <e@80x24.org>; Sun, 18 Mar 2018 22:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeCRWPp (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 18:15:45 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:43225 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbeCRWPo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 18:15:44 -0400
Received: by mail-lf0-f44.google.com with SMTP id v207-v6so2884153lfa.10
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=55B/eIK0vz9KApBYOTF/ab/pJh/AkdW7gW7YAyZgKg8=;
        b=p1qBhAIOW5az/j55OkWQ/wtvq2SS8QijWzyNelcptvmz/wrgWivesyWqsSC824oOU4
         3Qu73v0h53L1U8WZ8KFdltPFAC4AO+JhnfRl+zbb8DfT7n/Ke6ZqfkXvkiFR2rTZlVBC
         gmh/7EdAlml5VU22hOcPaGnzFQbpqROWBpOLZCeT5HF25D+us8/FhFvQr+v0JbbFoa7Y
         bjv1tcqsn9PdqmLPvphl7lRWm8N26Ubj+oeyIGtWRuaJpsGaMA2mKKCxXn9V75RsD+nH
         KNNI7HH7J71cO/hL1HqXHb6qHS+ggk1vP3K97IY0azXqJp8G24uAJToMD471tepHIjVr
         ILGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=55B/eIK0vz9KApBYOTF/ab/pJh/AkdW7gW7YAyZgKg8=;
        b=UrdHAaXvhv0z+uFXOesYlJa5g7sTdPUEyR4aIAFh5TM2Dc2OpcXgExiDRFjnt9C9e8
         1PMwzjQt5qoPUKDb26cP8vFgAacV19NWY0vzyCk9jq9WjfHmtcaXvlMkgH5ClqbwLY2o
         bXaf4Q6g7c0FJkbyb5IT79acpzmlxjlzHa6o1uE/eoYBj6qNLWU0mdqRwHgSN2jjYlO7
         Q2IKosy8/vHXrFoVINysj1MZtKlkSHGWe2q1nX8Z2YAJ7faQOuEu4DJhcNRiJQNfrwki
         kpb8MisCeoGz52d969lNndtxM+/4tc0SYmqV/QX/kUxxrecULLI7H15Pgm7E+mkecEG9
         Htuw==
X-Gm-Message-State: AElRT7E9svQE+Lrfm/3EUth4n6plbjj2S8bPQzF3ElNtT+Y1DF9h26nJ
        MteA51o2T5V1TPUUy2NCaDkE3+6SEpSrMPpeI8NTEQ==
X-Google-Smtp-Source: AG47ELviQg+DB14goer0iJMuMB3busz7b4BqFPnJp8tJ2h7abpPxmZPugiGdTvw/vUQiFRn2DVBCwnnUhcLoSFvcAsQ=
X-Received: by 10.46.71.12 with SMTP id u12mr10471lja.36.1521411342422; Sun,
 18 Mar 2018 15:15:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b42:0:0:0:0:0 with HTTP; Sun, 18 Mar 2018 15:15:42
 -0700 (PDT)
From:   Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Date:   Mon, 19 Mar 2018 00:15:42 +0200
Message-ID: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
Subject: [GSoC] Regarding "Convert scripts to builtins"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am interested in the "Convert scripts to builtins" project. I have
recently started to analyze it better and see exactly what it entails
and a few questions came to my mind.

First of all, I find it difficult to pick which scripts would benefit
the most by being rewritten. I am thinking of git bisect, git stash
and git rebase since these are maybe some of the most popular commands
of Git. However, on the other side, scripts like
git-rebase--interactive.sh and git-bisect.sh are also subject of other
GSoC projects. Should I steer away from these projects or can I
consider them?

Secondly, what is too little or too much? On one hand, I do want to do
my best and help the Git community as much as I can. On the other
hand, I do not want to have too much on my plate and not be able to
finish my project. Considering that mentors have already decided that
git rebase --interactive and git bisect are enough for two projects,
how could I quantify the time required for each command? Looking back
at the previous editions of GSoC I noticed that most projects were
focused on only one command.

From my research, these are the scripts that could be subject of this
project. Which ones do you think could be the best choice for a
project of this kind?

 * git/git-add--interactive.perl
 * git/git-archimport.perl
 * git/git-bisect.sh -- there is a project about this
 * git/git-cvsexportcommit.perl
 * git/git-cvsimport.perl
 * git/git-cvsserver.perl
 * git/git-difftool--helper.sh
 * git/git-filter-branch.sh
 * git/git-instaweb.sh
 * git/git-merge-octopus.sh
 * git/git-merge-one-file.sh
 * git/git-merge-resolve.sh
 * git/git-mergetool--lib.sh
 * git/git-mergetool.sh
 * git/git-quiltimport.sh
 * git/git-rebase--am.sh
 * git/git-rebase--interactive.sh -- there is a project about this
 * git/git-rebase--merge.sh
 * git/git-rebase.sh
 * git/git-remote-testgit.sh
 * git/git-request-pull.sh
 * git/git-send-email.perl
 * git/git-stash.sh
 * git/git-submodule.sh -- there was a project about this
 * git/git-svn.perl
 * git/git-web--browse.sh

I look forward to hearing from you. I will also submit a draft of my
proposal soon enough.

Best regards,
Paul Ungureanu
