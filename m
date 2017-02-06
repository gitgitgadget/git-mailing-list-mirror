Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399031FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbdBFXfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 18:35:36 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35383 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBFXff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 18:35:35 -0500
Received: by mail-qt0-f179.google.com with SMTP id x49so119965763qtc.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 15:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=59sRBUNhF5QawS5VfY99ImUZqSbIYR3B5cBDZSJAVME=;
        b=fY34YhfR0AXlfiukaKXfsTkQ1tICxM6+mjbrBTJYxcj694Oz1g5gQhNnlailQzSzw5
         7ZhnPAq3Ommnsf0BxfGoQwRnaxYhA2dtSogqcCex+icPypIT1kaHP6iQUsnLU3Qn2ekL
         RT3I/bxYCVqLIyNRPFr9Dd8dYp5OPbvYIaiHYt0C8BvqKfdvc5ItTLjlKOpktr/3yDyK
         CuhwOilRzvl5zo8nxJvXT/umDcc1IgZRkdSGKcORweDk2i0Xt0rF89vFwH2tew4tVX/+
         ZwSI++gILM1yo+M1VLT7nf9KkWdr8i7SIhs8xehdENgUmRXOaqipPMAfGCDIoh7+56pt
         e/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=59sRBUNhF5QawS5VfY99ImUZqSbIYR3B5cBDZSJAVME=;
        b=FWuNeaNHg3hKudvY/LzphKc9pRbGSx2QHdU1mecNy7hZx9+sWnRiv+7UlVjEb1MAZb
         tCz/jOOOTu+0C5R0rk1Ak/FOvYcqRcG/QVsKfzczNAEBsAHuX3LyECKlZsn3ECsFSHag
         X3Z+w8S4WIp2jTb7jUutu7jWXr7tXQ4+EdJ+h00TX5rzwa7sqwgEEq1zP981/Rw+joIm
         cLy214CM/BqR9nHZyi6z5pVwdp7AEVE2ftd/t/pOMUs65CUgiXI4l2iOWJGm1c+evigV
         ucH7X03U+0P+gRDjAm5Ma+dsmGwKnL9nj/aKQIEXxIwhtVYtTmW3PiAxBrLobjcYv/zv
         0cWA==
X-Gm-Message-State: AMke39ni5xYYxELzyIckLeD5Kl2votDdyePm61QcKw59FMdt9wlCHhESJ/YCcBUJsABglYN3jveKsyU4YLGglA==
X-Received: by 10.200.54.84 with SMTP id n20mr12909338qtb.79.1486424134163;
 Mon, 06 Feb 2017 15:35:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.47.7 with HTTP; Mon, 6 Feb 2017 15:35:33 -0800 (PST)
From:   Ron Pero <rpero@magnadev.com>
Date:   Mon, 6 Feb 2017 15:35:33 -0800
X-Google-Sender-Auth: 03BXH6-nE-7_ye05lqvbS99RXts
Message-ID: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
Subject: Request re git status
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I almost got bit by git: I knew there were changes on the remote
server, but git status said I was uptodate with the remote.

This page explains it well.

http://stackoverflow.com/questions/27828404/why-does-git-status-show-branch-is-up-to-date-when-changes-exist-upstream

That page also contains a good suggestion:

Why ... not design it to [optionally] DO a fetch and THEN declare
whether it is up to date? Or change the message to tell what it really
did, e.g. "Your branch was up-to-date with 'origin/master' when last
checked at {timestamp}"? Or even just say, "Do a fetch to find out
whether your branch is up to date"?

Thanks, and best wishes,

Ron
