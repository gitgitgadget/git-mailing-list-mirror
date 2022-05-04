Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8BC433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 16:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353580AbiEDQrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbiEDQrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 12:47:25 -0400
X-Greylist: delayed 2967 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 09:43:48 PDT
Received: from mail2.pdinc.us (mail2.pdinc.us [67.90.184.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F43343EC8
        for <git@vger.kernel.org>; Wed,  4 May 2022 09:43:48 -0700 (PDT)
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 244FsJgN001671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 4 May 2022 11:54:20 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 244FsJgN001671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1651679660; bh=Sn/LR9R5DtHJ7Qxxwkf7PSfpoyoQgetyBob6nHZoW8E=;
        h=From:To:Subject:Date:From;
        b=N03tHPLVlhIn2y5sv87hXRx4DJKWA8GJSghSjDvyDgJbjYJ0MFOJnGR9Vr43UQqPw
         xnipCz3KtrWAyAEQUzsWXYGqJ/jTKJsOvkr2YYarZqnc4iFko3SWH4luZ6fP1599g6
         kBV7gvWssTVk8sV1ib2dctdRYDOkjCgn9mBgLs2sECxUP/0yFtdh6O3Rv1+1CeG1ls
         mdWQLo5FGHLPzySt0VD0YAK80A+kzEAYsV0mQMcncsJoTvO4y7YXVADu6w29idaszF
         +2JdPL4llV4oQahRcDpx5elyKb+OAk3Bi+2OEbauPYTFQDcndxlD/soXIWhzTfcK7P
         q+AJCpsDsz2aA==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: is there a short cut - cloning kernel - resolving deltas 3+ hours and going...
Date:   Wed, 4 May 2022 11:54:16 -0400
Organization: PD Inc
Message-ID: <15ea01d85fcf$356462f0$a02d28d0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdhfzwujuZIAvnO0TlyJPEKLa+pfoA==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am on a 4 core ARM system 1GB ram...

remote: Enumerating objects: 8716377, done.
remote: Counting objects: 100% (748/748), done.
remote: Compressing objects: 100% (748/748), done.
remote: Total 8716377 (delta 4), reused 740 (delta 0), pack-reused 8715629
Receiving objects: 100% (8716377/8716377), 3.54 GiB | 6.85 MiB/s, done.
Resolving deltas: 100% (7232922/7232922), done.

Helpful thoughts? Or do I just need more patience.

-JAson

--
Jason Pyeron  | Architect
PD Inc        | Certified SBA 8(a)
10 w 24th St  | Certified SBA HUBZone
Baltimore, MD | CAGE Code: 1WVR6
 
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397



