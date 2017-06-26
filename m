Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9062207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 23:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdFZXJQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 19:09:16 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34761 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdFZXJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 19:09:14 -0400
Received: by mail-vk0-f49.google.com with SMTP id r125so8277598vkf.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b8gxqtv6ZY+1uhYNZ9T8u9gUkolLaUfGy2iUqvGGABI=;
        b=Vh4MzWGu9LE8nvjn2zI1WawOmzgnZEXfSUDdM4EN4UVZl2QogcCMEXUnwR7oBMf+4k
         X8Ypg7lwP+N0VdHWMU4vK8gdl7KIFmkaas/452VwvUKk0IuBiRAU54tuRplRCuTZwSRM
         hcOxgQeTad7YHzlCppPIAyQ9eDwQd3C5scmbzM+qNX/wEBBDq2tWAWxxXMcG9LwjM4wq
         iG7gssxg6+/1llMT+B72BlGClgIMhuRBIzjrtvkREDBAmdp+iuRxdFdyZWyb+ijWc+8R
         iCdPpiQDEoJx43cFOB9NRMEOp+7G6E6ezmqMzGxWNna5dcBIDt/IRXmLEJubXxPPHK3y
         Ve6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b8gxqtv6ZY+1uhYNZ9T8u9gUkolLaUfGy2iUqvGGABI=;
        b=pQt1E4dRrR4sLAOVtre2B2yzrK1a9H9skvbvEB8YWZmT1erwqOu/tdHYnZqeonni2d
         v4m51KOgJNYmXEGYXFVbfMnq44EKa0hlZzJiA7GIRRQuLc4mrERVwOzVQ0rzR6D4ZvaR
         N0R0XXzxqIVdKGc4muOJHZ7Qi/EGkHV62jpiRkI/FA00KUd3uqS1RtF1fe5I2pdYy80u
         EakNQfIssszA9m0VvYdm2gEdE0j7AIuWGhfToVNQKUWa3DI64lXRB4YYe4RRXzGR6bIZ
         HkFA7ZzNv2nZVt90INrSdo9d3BS/mpOGy0xgxSxrsCIT128cVoSh7cvUVV3venKymTWC
         LcWg==
X-Gm-Message-State: AKS2vOyTw0EwBChkAjQLS1B4eUHNkvNkv47BRPVy0fYrveVCxcT5j9u3
        sn0j30ZDQjiVXW+dqVPmvAkh6mLEHdU5
X-Received: by 10.31.178.215 with SMTP id b206mr1313039vkf.79.1498518553630;
 Mon, 26 Jun 2017 16:09:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.77.139 with HTTP; Mon, 26 Jun 2017 16:09:13 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 27 Jun 2017 04:39:13 +0530
Message-ID: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
Subject: [GSoC] Update: Week 6
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

Following are the updates about my ongoing project:

1. sync and status: The patches were discussed with the mentors
   and after that, are being posted with this patch.

2. deinit: The patch is debugged, and is ready to be
   discussed. Not much discussion occurred over this patch
   and hence the patch is same as its previous version.
   It is also attached with this update.

3. summary: The porting of this submodule subcommand is
   almost completed. Things like improving the function
   names, checking for memory leakage, etc are still
   left to be taken care of. I'm updating the patch's status
   by sending the patch to the mentors off-list, so that
   an appropriate version is posted here on the list.
   Hence, it wasn't attached to the update.

4. foreach: Not much progress was done with this patch
   in particular as most of the time was used for completing
   the porting of submodule subcommand 'summary'.
   Hence its status remains same as mentioned in the
   previous update, which is reposted below:
   'As stated in the previous update, the subcommand was
   ported without resolving the bug, and simply translating the
   present code, and adding a NEEDSWORK tag to the comment for
   mentioning the reported bug as well.
   But as communicating between child_process is still an issue
   and so there was no simple was to current carry out the
   porting. And hence, a hack was used instead. But after
   discussing it, instead using the repository-object patch
   series will help to resolve these issues in this situation.'

PLAN FOR WEEK-7 (27 June 2017 to 3 July 2017):

1. foreach: Since the required changes weren't made in the last
   week in regards with this patch, in the next week I aim for
   fulfilling them first. I'll like to again mention it here:
   As it was decided that unblock the conversion of
   this submodule subcommand, the original cmd_foreach was
   ported without including the BUG-FIX patch here.
   Hence, for this week I will try to utilize the
   'repository-object' series by Brandon Williams.
   Additionally, I'll like to mention that this update
   still, doesn't depend on the 'repository-object' series,
   which I'll be trying to change in the next update.

2. summary: As mentioned earlier, since there is still a little
   work with its porting left, I'll try to finish it and debug
   the ported code as well.

3. deinit: As there is still scope of improvision and discussion
   I'll also be focussing on improving this patch.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/

Thanks,
Prathamesh Chavan
