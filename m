Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6050C1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH2Rdp (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 13:33:45 -0400
Received: from sonic302-25.consmr.mail.gq1.yahoo.com ([98.137.68.151]:36562
        "EHLO sonic302-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbfH2Rdp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 13:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1567100024; bh=/nCtU/t6WF1MKaZ3INsLbhuZ1mNs5lypiajxSZh8cBg=; h=From:To:Subject:Date:From:Subject; b=O2jxKqFoaGb12y8Y5sqPVkCiNbSmwMBs8aafl1va6+5ka2B/7yMIdsxbe8+bkzQOsUtxLI+5BjwKwQr7F82M6G2F7kCujNWDEM18aaTbnGkJp9KA5LAEZDKAHTwGfmlUB7XzbUNa3CYfZP4TM2DIDtcmDI0Iy0dPx2vYcLfDl1qHqe2lIfNIeqwhgNxKawnWx1QXZSBSw9FcZmY/MLWS3lL/YQKKUdT/ieiZeXY+gpWhnedX0gW6/JHTTesz0j9YIdxDgwlOZK99HmUuBvMkXLG1DlaN/iV75s/c307YEJNCYC5Oh/+bvFsKjaPsUXT90aWAqHNumA/StijpRHnHEg==
X-YMail-OSG: LMPuYJsVM1nupaTMWBJgm8zbSqU.SWV.VEb8iBpNJTI4EO0HKbG_9Dp28rzkZFV
 Xqs5OZZNFSfpGstBH30JhMFrYg88CUfdNTbm01QR2dfAuBNxBWpqjdddjKvo0Fg2VYmCBQzkow_r
 rwEE89UK3iLY.HjBPSjM5NqCk3ERuT3CCuGZ_ifNWIVzqOO_xSr.eF_XFlHTukZb4tyHR78tuKGg
 pt21JstSyLw.PElVDOfQ53y9314ZsGSXcZlKJZnMmq9nTAwvWAyiS5EdSPIeNAZoiwKQPNLwUhHd
 ByLhOHPeZHbHVDdTFw1nRO2k_XdEF2D3_0Q2dsKNpog2gcDdYXqRYYJ2gLFC9aEgB65Vfi5hbZE6
 O55RvwonoVlQNQDBdmacsKBv5ubL0TqpSaFopB7bESqDXzW7ycjpvzx_pSWAHqv5w_m5dgugsRiH
 xyC10VpMwu5.UGYrTAtlBBp7q9CIXmyhptcVVDijb.p6EmzYOg72jSaalUyc4gcf_TjGx62AiC5f
 wlHLoriIskL36V8ucTIV2eaVALzyq8OPgePvgrF6nLYnNVSL7Y9cGlhMJwCtX5xTJ9YDJ0ylcD0Y
 zADDcwF9drhEIafU.pPZrWcCudS737MbrhZeK4kjNEK_d56bPFcO1kvP3ypjWm1AuHbr0p0MUCRp
 kwdYsOMUtTx1KrAVwm6RePA5x7NYEyYf3AugPDYj0UAlsLtcMLjYoj3a._oJLRfp842DC0u9z70.
 7hWcQOq.YC5HxobGVCCEIgBPueX_l1myGP5g.V.lqkU_0WoonI7ittcOtNZ0o2j68iAZc85N0Xrq
 ekTwlDSCi_BtHqpkoHaYYQyAEVoMWoe_cr.LOSPmAXdvWZqaPTl4OkmLNp4ToMGs3zBdLEYjCT7h
 KYIAOgfOsdajaQGB63CkssvsvWQhY.GA.N2hFkEq6xn92s.IkZKa0lTuXD0SOhi2oljAq9hIpCdo
 odvKhyF0vXPbVDSL_9Aiqx9qiST4Sff2q51y0Mn8OmQ6kQBd5q5ot7JLrko66cse_J3eCQdhfsYI
 pa8yrBjZOWNH.PgTzbUVcEqwHgDzQAPPYeAgcDusH35QFJcBM5keQkjM2XjGYYBHgRQn52WwGz_9
 5m58Pzfzo180xBNpisDT9IEq1QgFqoBRqAcrHRtPfiSErvVN0MPrGvI5vYs6yV20MJXJ7.BYb1Fh
 yteWvPzM1484ljEKJpZ1xkaq7DrJyn6Y2U.N8bpL8djRdIl_ixaUazotF7iidfq_W7rthXgMLIIv
 y6WcnghQu2dJ8W_._MPJtzA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 29 Aug 2019 17:33:44 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 47843a25c683645b7056a7b2c61e7892;
          Thu, 29 Aug 2019 17:33:39 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     <git@vger.kernel.org>
Subject: [BUG} stash show does not show untracked files stashed (reposted)
Date:   Thu, 29 Aug 2019 13:33:36 -0400
Message-ID: <002901d55e8f$e4a4af70$adee0e50$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdVejiyPVT6EXU4+R6iXrfdLmdkSvg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't know whether this is new behaviour following changes to stash, but
here goes.

Suppose I have files a,b,c,d modified, but only file d is in the index.
After stash push  (or save) --include-untracked, stash show only displays
file d. A subsequent pop will restore files a,b,c,d. So functionally push
and pop are fine, but stash show appears to ignores files in the stash. The
git log below shows a previous commit (dce2e3e) to the WIP stash (ab0834c)
that does contain the untracked files, and git diff is happy to show the
contents when using the ref directly. It is just counterintuitive for stash
show not to display all entries previously pushed. I would have expected
symmetry. This is not new.

*-.   ab0834c (refs/stash) WIP on master: bf223fc Updated known
|\ \
| | * dce2e3e untracked files on master: bf223fc Updated known
| * a5ad1ef index on master: bf223fc Updated known
|/
* bf223fc (HEAD -> master) Updated known
* db0efd4 (origin/master, origin/HEAD) initial

This on git 2.23.0. I have the same behaviour on the Windows build of git
2.12.3.

builtins/stash.c show_stash() does not look like it accounts for multiple
paths when calling setup_revisions, so I think it is missing the path to the
untracked file ref (dce2e32). I am guessing.

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



