Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66D41FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 21:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdFSVlJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 17:41:09 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34727 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdFSVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 17:41:08 -0400
Received: by mail-vk0-f53.google.com with SMTP id g66so59719079vki.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Sr616cKmR1PfzbRIELwpxJIsMAhyv9Jw1ytrtJGE2YQ=;
        b=YpiI2B3Y3FfygXbTb/2aKxrJ2nqByqjGu8ihKrRLwAbB7wEWECj1WhLPSxTReSRMtr
         EKmrN3EWcpIKwEUWcQKtU+HV8QXa2mVotnpfySrpmo/iR96MtHB25uolhSKwbE6e4/6u
         YxhGFalDjbk3nI3xFmGCQqTyh69lXaKSiX+9ZY/LgTINd3baugsYf1t+R5J1hh+V4i4n
         37eDYd8oxAFDu9j7Ros5cX2V8DYzUoGHqF29OvPryutOQRS4QC4oiNGrGCfvSPj/iHVZ
         t9a7HIQT1j6mktd6PY2fZbAeO77jI99QScCycBnYFUpHwXFhiXHrt2HlHdgmQy40RF3V
         qI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Sr616cKmR1PfzbRIELwpxJIsMAhyv9Jw1ytrtJGE2YQ=;
        b=Kax/XNkcmUGc9USP4EVOMXemmqPgwCbsoF3QOuGy29q243AtEvXrVhBSAzzOcEolXV
         fKtgYUdSE3hvt+vnxkvdzIXVIZfEQH7jyCvTDgSMMu7enjjb/LRpeKGdeG7PtkXy/tUU
         /AQQ2m23su2rdOb4I0G0VwFbG8YT0NUjBQ7ZxhVysujavXfDKL/imVJqH5D10XKKbcnJ
         5Cn9cuX3XNPtEXV63RJYQCuxoUG+8FDTGZn1zEOmEfdM66WmULPFhBgW41hjmwaU7NoU
         hukg8TwJqy1OHnlNJL3mxHyisJQlYN718VHR7whAAp5E2ynyXBW/SbIi5GVrrsOWv22V
         Emiw==
X-Gm-Message-State: AKS2vOxlZ6aOHyxenu7a9duCFJiU+Lbn4gMHuXnbTYrdRNdKISNkpMd2
        qVGG03kI9yDYFf8QfIB+C/AMxmzY4OHv
X-Received: by 10.31.9.204 with SMTP id 195mr14827190vkj.115.1497908467287;
 Mon, 19 Jun 2017 14:41:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.77.160 with HTTP; Mon, 19 Jun 2017 14:41:06 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 20 Jun 2017 03:11:06 +0530
Message-ID: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
Subject: [GSoC] Update: Week 5
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

2. deinit: The patch is finally debugged, and is ready to be
   discussed. It is also attached with this update.

3. summary: While porting the subcommand, I underwent certain
   issues. After getting them clarified from my mentors, I
   have resumed working on it. I'm aware of the time I have
   taken for porting this subcommand is more than the previous
   ones. Hence will try my best to finish this in this week.

4. foreach: As stated in the previous update, the subcommand was
   ported without resolving the bug, and simply translating the
   present code, and adding a NEEDSWORK tag to the comment for
   mentioning the reported bug as well.
   But as communicating between child_process is still an issue
   and so there was no simple was to current carry out the
   porting. And hence, a hack was used instead. But after
   discussing it, instead using the repository-object patch
   series will help to resolve these issues in this situation.

PLAN FOR WEEK-6 (20 June 2017 to 26 June 2017):

1. summary: Mostly I'll be working on this and post the patch
   for discussion as soon as possible.

2. foreach: As it was decided that unblock the conversion of
   this submodule subcommand, the original cmd_foreach was
   ported without including the BUG-FIX patch here.
   Hence, for this week I will try to utilize the
   'repository-object' series by Brandon Williams.

3. deinit: I will be working on improvising this patch as it was
   recently debugged and posted for discussion.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/

Thanks,
Prathamesh Chavan
