Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD5A1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 07:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfI0Hbn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 03:31:43 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45135 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfI0Hbn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 03:31:43 -0400
Received: by mail-pg1-f172.google.com with SMTP id q7so2971220pgi.12
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=szHqFyKNZJ+NZoy44mrTbzntlp1rqAKwkTJddx29qFE=;
        b=E9KF6/eFfyWEPalFb5NX0/t2Gvs1yssegkSZPA2d/2GtpX4JXnq7P7vEcFyDxt7ikt
         UfoVaZu1rzZbn4MsGjy61n171kiYz/y1+4TzCGs+1TTnsy7/2ktc3mAhKwmcTiFB6gz+
         uH9tyBBw0WKLS4lVl8ycC8Jezyav+O4I9vwO3ASm4hZ839wOzyZ5Q29qfx1g8CssCBpD
         Ya9JwlljyoPngRMd2l3N3wY1CWjw30UGBKWFGB2DKZ3feXcn79FnRLk+G7JKz5mTHRZv
         NGq6MRjq4o8Goc+CbHA4Zd3jVsvGKeDuBz1/vr/mIj0+qvEr3X0XDH0AXNFIWmo7I4z4
         ReiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=szHqFyKNZJ+NZoy44mrTbzntlp1rqAKwkTJddx29qFE=;
        b=pBL22cnRtxfuLmWyp2W3o2EBDB2/U6poVPSxLct/Pq9poew13/DD2J0BVcmjsccEwF
         6vLBFe9ATmMYFXDJHkl+z7L6RXbvbg93ylVEORbcOmDFsLnjmJKVI5VM1L86fY387q5w
         9oy2wOmHOWfJIMOzXs8qLqVeaD6ePLK9BX7v3V6/iBllQM2i0rGnHOvwFy5+qySBBkn9
         eD73j2tzMiR3bPM7s97/r7intj6WzcKVwa88QPiA9A4xJsvycnFKmYABs3xsmCfJxbZN
         MYQPFCViOZto5evgGrqt31x4LSoMOrAoFO+GltVZSeJRkezl1nFnGK+vEsQLcK/hdJMM
         Qvng==
X-Gm-Message-State: APjAAAVI+Ef6pGtZ/XJDLI6qfYkkBcAzYm89eWKY1qwEENvxUhZp/drd
        lVU60nWr0Cvoz5nL6xOT84dQdoWLwsX55Dxs/6dStUNf
X-Google-Smtp-Source: APXvYqxE3Slfr/kp8Red3XXDiTIrvX3xUKs9DlVsM9JbeexvEPijC+p5UVWQeOtHkNbsIPrZ8qdMpA0Z7wijjaQq3Rg=
X-Received: by 2002:a62:1717:: with SMTP id 23mr2572235pfx.20.1569569502567;
 Fri, 27 Sep 2019 00:31:42 -0700 (PDT)
MIME-Version: 1.0
From:   Beyondhorizon Zheng <byndhorizon@gmail.com>
Date:   Fri, 27 Sep 2019 15:31:31 +0800
Message-ID: <CAP2YDYhfA__VYe-Kt3FwjPMzJ1jVo8X9eQ-pHR4MhQWypkrkKQ@mail.gmail.com>
Subject: [git issue] git am failed for patches of converting the format of
 source codes from dos to unix
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[git issue] git am failed for patches of converting the file format of
source codes from dos to unix

Git version: git version 2.23.0
Host PC: ubuntu 16.04.10
Reporter: Shuang Zheng

I have submitted a patch which convert the file format of source file
from dos to unix with command:
dos2unix misc/acrn-config/config_app/controller.py
then submit a patch with this change:
        git add controller.py
        git commit -m =E2=80=9Cchange file format=E2=80=9D
        git format-patch HEAD~1
        git am 0001-change-file-format.patch
errors as below:
Applying: change file format
error: patch failed: misc/acrn-config/config_app/controller.py:1
error: misc/acrn-config/config_app/controller.py: patch does not apply
Patch failed at 0001 fix format
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
