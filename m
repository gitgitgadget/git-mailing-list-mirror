Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B378E1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAVVCw (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:02:52 -0500
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:36805 "EHLO
        rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfAVVCw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:02:52 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 16:02:51 EST
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 8790A796F1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 21:55:26 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id 68D4122416
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 21:55:26 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Tue, 22 Jan 2019 21:55:26 +0100
Message-Id: <5C47833C020000A10002F499@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Tue, 22 Jan 2019 21:55:24 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Q: What happened to "--no-commit" merges?
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Using git version 2.16.4 on OpenSUSE Leap 15.0, it seems that "--no-commit" no
longer does what it did before (AFAIR, but I mostly did --no-ff merges in
SLES11):
Like this (sorry German):

> git merge --no-commit local/f-linux-firefox 
Aktualisiere 520aaae..c11e3da
Fast-forward
 bin/fval.xsl | 133 +++++++++++++++++++++++++----------------------------------
 1 file changed, 57 insertions(+), 76 deletions(-)

> git status
Auf Branch f-linux-firefox
nichts zu committen, Arbeitsverzeichnis unverändert

### "nothing to commit"
git log indicates the changes were committed already

Reading
https://stackoverflow.com/questions/8640887/git-merge-without-auto-commit it
seems that without "--no-ff" this ioption is effectively ignored.
If so, I suggest to tell the user that --no-commit is useless in this case, and
let him confirm that he/she wants the changes (merge) to be committed (despite
of --no-commit).

Regards,
Ulrich


