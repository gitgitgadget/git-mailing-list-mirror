Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54AC201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 20:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbdGCU2A (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:28:00 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35020 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCU17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:27:59 -0400
Received: by mail-vk0-f45.google.com with SMTP id 191so100877681vko.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2focQX+8Xe18OuZ9Zab5YNYlMkzDozY+zRv9vrv8xn8=;
        b=Lu30jIek/LqBakMWgUnXOXf5XHHbjNs0lZvgX6y3L9PUSrFoKUyN3wJb+YRKItRmY2
         zUXQLGrdt9ZFkLWurDTNPviecprtkXT9HQJhqo/jne2hHjtF7CBnMVHu+F8g8cikiTKL
         KTBJkNJcZl6oIsQioy5BTb7f42bAk4icV1RREo/PQ/SIt6NgTYQAm5VaJ5kMQPaFltCT
         khvbSdycVF6widuawNrQFO1000lr1GUw+APJWcW4jk5TriWAZUCf/qV2rVTmo2TYc01f
         H4VBP/K4kmtwystL7DCxsLQaiWDVAucQerFWOIZNaVnUxpY7QZa98zpYUnalzpCCN6eX
         9tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2focQX+8Xe18OuZ9Zab5YNYlMkzDozY+zRv9vrv8xn8=;
        b=gRjopDCn2GW+ZEm7OUxay/mUKTHOJtQaAYEIa3SlEWaFiqfQsBwizq1Ea37coYq3J1
         eIv7mIMWz7lEQkN9lcLhZlVQOHE0mx36u0mpZmHBobYDSZle6tjHJwQsy1tLT0FMf3M+
         6/uM/2Bn2Kdi/yGFn7AdKBQmJZV+C3qGQUHACL7C2Yn5xR5d6Y46Gd0agq7AaW8NFO5z
         EVn+i7lZbHopbCayeNdjfyhbrr1VX0eZrZ5pITejGyOB3LTzCV+DYetS9J4xS+acBPYm
         5egL7HCVtLqqzDCi1w2tbCyAGwo0+QJ5vSCuqP5A/ttqt8uS9GTzDJmnp40uycU8Ql1j
         Q5SA==
X-Gm-Message-State: AKS2vOwngpRE0lukbBN9th5YKGvhvTKfwPlSSou4hsgx9sVHULX1rGS5
        P12wF+bDP9qj0DuKMGUiCB01d5SpGLPz
X-Received: by 10.31.89.4 with SMTP id n4mr17334329vkb.135.1499113678465; Mon,
 03 Jul 2017 13:27:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.77.139 with HTTP; Mon, 3 Jul 2017 13:27:58 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 4 Jul 2017 01:57:58 +0530
Message-ID: <CAME+mvVRSovmXLDUzz8dNiruvLrXFv3iUifqXDm+HwQDu1mJpQ@mail.gmail.com>
Subject: [GSoC] Update: Week 7
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

1. sync and status: The patches are updates after the last
   discussion, and will be posted with this update, along
   with the patches of the function get_submodule_displaypath()
   and for_each_submodule_list().

2. deinit: The patch was discussed in the last update, and
   I still have to make the required changes to this patch.

3. summary: I'm still working on debugging this patch as
   the are still some part where the patch isn't working as
   expected.

4. foreach: Most of the time was spent in reading the repo-object
   patch series. Also, currently I'm still confused about the
   approach I have to take for carrying this out.

PLAN FOR WEEK-8 (4 July 2017 to 10 July 2017):

The main focus for this week will be to get the reviewed code merged
by sending new version after their review. Hence, I've attached
the patches which were recently review, after adding the
suggested changes, with this update. Other than that, there is still
lots of work related to porting left as follows:

1. foreach: I'll try to come up with an approach for the present
   problem in the foreach patch, and get this discussed with
   mentors as well as with Brandon Williams so that I can
   get this subcommand ported.

2. summary: Currently, I'm still on debugging the patch. There are
   parts of the patch which aren't running as expected and hence
   it is taking more time to figure it out.

3. deinit: The patch was reviewed in the last update and I'm yet to
   work on the improving the patches as suggested.

Apart from this, there still lie two submodule subcommands: 'add' and
'update' unported.
I'll try to completed as much as work related to porting but will
also, focus on improving the code completed so that it becomes good
for merging.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/

Thanks,
Prathamesh Chavan
