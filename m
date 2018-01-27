Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478501F404
	for <e@80x24.org>; Sat, 27 Jan 2018 19:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeA0TmR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 27 Jan 2018 14:42:17 -0500
Received: from rhcavspool01.kulnet.kuleuven.be ([134.58.240.193]:32840 "EHLO
        cavspool01.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751375AbeA0TmQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Jan 2018 14:42:16 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jan 2018 14:42:15 EST
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [134.58.240.130])
        by cavspool01.kulnet.kuleuven.be (Postfix) with ESMTP id DC56614BB3F
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 20:35:54 +0100 (CET)
X-KULeuven-Envelope-From: filip.jorissen@kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: BD936120023.A5AF9
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id BD936120023
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 20:35:49 +0100 (CET)
Received: from ICTS-S-EXMBX21.luna.kuleuven.be (icts-s-exmbx21.luna.kuleuven.be [10.112.11.56])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPS id B9B2F2003B
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 20:35:49 +0100 (CET)
Received: from ICTS-S-EXMBX28.luna.kuleuven.be (10.112.11.63) by
 ICTS-S-EXMBX21.luna.kuleuven.be (10.112.11.56) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 27 Jan 2018 20:35:49 +0100
Received: from ICTS-S-EXMBX21.luna.kuleuven.be (10.112.11.56) by
 ICTS-S-EXMBX28.luna.kuleuven.be (10.112.11.63) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 27 Jan 2018 20:35:49 +0100
Received: from ICTS-S-EXMBX21.luna.kuleuven.be ([fe80::40ed:b1c6:4ef8:3c88])
 by ICTS-S-EXMBX21.luna.kuleuven.be ([fe80::40ed:b1c6:4ef8:3c88%23]) with mapi
 id 15.00.1320.000; Sat, 27 Jan 2018 20:35:49 +0100
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Filip Jorissen <filip.jorissen@kuleuven.be>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Cloned repository has file changes -> bug?
Thread-Topic: Cloned repository has file changes -> bug?
Thread-Index: AQHTl6YIDoeABjxIm0WpBifuwOpiiQ==
Date:   Sat, 27 Jan 2018 19:35:49 +0000
Message-ID: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
Accept-Language: nl-NL, nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.112.50.1]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15062970138ABC489AF47CD17C36412B@luna.kuleuven.be>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I think our git repository is bugged. The reason why I say this is the following. When cloning the repository, the newly cloned repository immediately has file changes. Steps to reproduce and illustration is at the end of this email. Git checkout does not work to remove the file changes. This behavior seems to be reproducible across multiple computers. Is this a bug? How can I fix the repository?

Thanks in advance for the support!

Filip


MacBook-Pro-van-Filip:git filip$ git clone git@github.com:open-ideas/IDEAS.git
Cloning into 'IDEAS'...
remote: Counting objects: 48419, done.
remote: Compressing objects: 100% (198/198), done.
remote: Total 48419 (delta 134), reused 217 (delta 97), pack-reused 48108
Receiving objects: 100% (48419/48419), 42.32 MiB | 1.81 MiB/s, done.
Resolving deltas: 100% (32847/32847), done.
MacBook-Pro-van-Filip:git filip$ cd IDEAS
MacBook-Pro-van-Filip:IDEAS filip$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
	modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Utilities_Psychrometrics_Functions_Examples_SaturationPressure.txt

no changes added to commit (use "git add" and/or "git commit -a")
