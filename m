Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A5E1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbcLEUeD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:34:03 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34693 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbcLEUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:34:02 -0500
Received: by mail-yw0-f169.google.com with SMTP id t125so259786352ywc.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=W0kBG+aXrVk33ZvR80FgxqQzz2sAp2t7WawvQdN6xJ0=;
        b=Y8QspklY7OtiK+dz4OTuJFEtxKM3ekqbRwRlYIUjx8DwTBqJSZG8r35tMZ7rhcxzaX
         TMiiceY/AN8zWGu7bDRYzzSJhBnLzpMlcOohOUnIPNjx2Crs/hBG3LMFYK8J7PX0Z7pK
         SNh/HyFBleKVUsdMmhsNuB4w7H5BRpZBgeOrnHScFbVTHhK1uhMs6pWhYTiZdbT/yT7k
         DGl1QlnfUo/Fmo4vAZ8h73L3RmLRNBgnjb6+vEvDCdtq88UfExiSVu6nKUE5l6PoLPvs
         FEfYNBPj2S7TR9E1k+Vtihl2mLK7FJg2CIKQez/qVv3nyK2W74d3Z7xVh+UlvPmcuGDi
         9N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W0kBG+aXrVk33ZvR80FgxqQzz2sAp2t7WawvQdN6xJ0=;
        b=i1CY2Z+LtdaYomifq2re5IVg90FOMShInSB50/78pYaB54Zv5T+qK002S2DB2znj+8
         DCkjThmjDpbRjw5uOy/60oHW6RkTP/IFP7f1p5V6KKXyTeaLw87xL4hjx0W9hL1WGzb4
         fmVNRdcQU6EEmDYiLkVqINjIzGXZIymOKuh0Y90e7vdj3e76s19SU83U2zNiR88wI3gO
         1zwwZwHjHvQVebugqbMpsmLNvtME5TudBv9wf72PP3xwhJrPL3dCiTB/MUhENSqotc42
         KrCGc/ETu7M5d1cyOZt6hjpB78S0cVstXxJkCN7SBIxpsBxX8/4CvBWYu7xKAQ7M6i0G
         SajA==
X-Gm-Message-State: AKaTC006rRCCh2UeJ3xfBqRUO+Gf3eMAIa5fCoRKjotATHEOtKqqjKzfbu2Wwub6Gdgzdz28Is1YQaVeAzzVrw==
X-Received: by 10.129.91.132 with SMTP id p126mr32348927ywb.243.1480970031689;
 Mon, 05 Dec 2016 12:33:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.8.14 with HTTP; Mon, 5 Dec 2016 12:33:51 -0800 (PST)
From:   ken edward <kedward777@gmail.com>
Date:   Mon, 5 Dec 2016 15:33:51 -0500
Message-ID: <CAAqgmoO+7cLZHpX61=Mh7PjqrCUc0qyFD=C+sjVat_+KPhisbw@mail.gmail.com>
Subject: git repo vs project level authorization
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am currently using svn with apache+mod_dav_svn to have a single
repository with multiple projects. Each of the projects is controlled
by an access control file that lists the project path and the allowed
usernames.

Does git have this also? where is the doc?

Ken
