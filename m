Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7770201A7
	for <e@80x24.org>; Mon, 15 May 2017 20:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933527AbdEOU0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 16:26:40 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35568 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933188AbdEOU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 16:26:39 -0400
Received: by mail-vk0-f49.google.com with SMTP id h16so54853607vkd.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SrHBT4b0a2QrqHgygRiIe/SOIEjMwTFTcwswkiR2Fr8=;
        b=t+7l25hOw5NFF80FbTl1xSZJ4iAxklJ8SpwUy/ia7SmFTF5QOdTxXVtY1abahEq/uh
         b8hidJ0QzorJWiM33uiBp7Uayy82vc07ixksUeA1kaWhDWMO+WRIRBKmAxGHh6iCT1MC
         t+ghnTMCVjV7oVLE+q0rHcECkj8j3dmfjLWaUt9Fz4cjHW/MTRzAbA5VsXEly7QmgXCc
         c+Jvn5XP8VLduwVUDGnLnVn8iggO6NJ7+mpuMQiPTbp7OgXPMW+uT9GnQxruRcrln4fz
         Hc3nJwabOyhrS3lMi2RdrR7o8EIgXPOYEkCCn9W+wrMT/p++iJNafAaV/bQLPOF3SACb
         Sylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SrHBT4b0a2QrqHgygRiIe/SOIEjMwTFTcwswkiR2Fr8=;
        b=U/o9tCEFerhnl52rmrHQ0O3tVvQ9RXQ03N2k7SxdGB7ms99050iiuiiX2PGTLMw7Rp
         26UaWh0h6Jod72Qdt1RSMuGkPfMgUhgTNpuu+j8/mfDrxrZg+6A6BOHIyAknF3bneSHo
         rc4Tmgqt/qj1+c4PY1sKvSkjnOGueuOXBN0ECcMCzYPgB9WcgM1oId8eNqE3iSWckn7e
         V+LeHPnE3KlXnrXFMKEpZondR4c0TlK7AYRPlO7ecUKEn1u7ZlyHpOAfgDYzPV3IBdOo
         nMPmUJBVA0YTUskqqyP9+j0BsH7WPNyI14DGu8zYcHfQ/izMHIWhP6u2DcaT5DzThF1N
         Kasg==
X-Gm-Message-State: AODbwcCInWoSXgMXj7XmDAfbghIt8UZxSV2FUwI8jql9hjbv9RT5Kpbm
        N4Bkndn40AdrEbjZROLwraRWlU3W4g==
X-Received: by 10.31.9.204 with SMTP id 195mr3894757vkj.115.1494879998216;
 Mon, 15 May 2017 13:26:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.38.44 with HTTP; Mon, 15 May 2017 13:26:37 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 16 May 2017 01:56:37 +0530
Message-ID: <CAME+mvUxNQToNOsaqAzabmMuACKyDeviZ5CBZHjvm3yXTEmrZw@mail.gmail.com>
Subject: [GSoC] Update: Week 0 (Community Bonding Period)
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

As proposed, till 15th May I mostly spend my time updating my information
about the codebase.

Along with this, I even spend some time working on the patch:
submodule: port subcommand foreach from shell to C[2]
I even updated my patch by sending v3, and adding a test[3] to
the existing ones. Currently, the patch passes all the test,
except the newly added one.

PLAN FOR WEEK-1:

As proposed, I would be starting to code officially from 16th May
(tomorrow), and hence have plans for working as follows:

Improvise submodule: port subcommand foreach from shell to C patch,
as suggested and also work on getting the newly added test passed.
I have recently received review from Brandon Williams <bmwill@google.com>
and my mentor Stefan Beller <sbeller@google.com> which I am really
thankful for, and wish to implement these suggestions as soon as
possible.

Adding to this, I am also waiting for the community's review on the
issue regarding the $path variable, which I added along with the
patch[2]. This issue is also highlighted by the new test[3] added.
Any suggestion would be of huge help to work further on getting
all the tests clear.

Along with this, I plan to port submodule subcommand status.
This required first porting of the function set_name_rev from
shell to C, and then later port the subcommand.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/edit
[2]: https://public-inbox.org/git/20170512114404.10008-2-pc44800@gmail.com/
[3]: https://public-inbox.org/git/20170512114404.10008-1-pc44800@gmail.com/
