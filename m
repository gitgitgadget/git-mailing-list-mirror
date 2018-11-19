Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A576A1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 11:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeKSVkr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 16:40:47 -0500
Received: from mxe2.seznam.cz ([77.75.76.34]:2256 "EHLO mxe2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbeKSVkr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 16:40:47 -0500
X-Greylist: delayed 698 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2018 16:40:46 EST
Received: from email.seznam.cz
        by email-smtpc7a.ng.seznam.cz (email-smtpc7a.ng.seznam.cz [10.23.10.195])
        id 7afef68c682c05e77aea6d2b;
        Mon, 19 Nov 2018 12:17:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1542626247; bh=sdGGL3QoUtzpxHbikjC5nxtP5jkyszhyuqHGQtpXKZ4=;
        h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=iBugsrO0p+tUk7V/BgjaH0NBaQlpic8uZSXm4x8s8kvkDF6RtFlgDAL2rEiZfQg44
         JLXG4bjjrcPpM+gdDnJh9gwgLkbs8fkXNTMwfoyMgYymsOdYBcesmAeaiA2/jzU9xH
         cyXw1sP+eDcUVsFSW3FPKXHweXlsOhyurMRc6iGI=
Received: from unknown ([::ffff:194.213.38.186])
        by email.seznam.cz (szn-ebox-4.5.346) with HTTP;
        Mon, 19 Nov 2018 12:05:48 +0100 (CET)
From:   "Mgr Georg Black" <georg.black@seznam.cz>
To:     <git@vger.kernel.org>
Subject: Big repository on Aix
Date:   Mon, 19 Nov 2018 12:05:48 +0100 (CET)
Message-Id: <BWV.5ClX.tnCYjSNZAD.1RyfaC@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.42)
X-Mailer: szn-ebox-4.5.346
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,
We have source codes in many files of 20 years development. It's approx 80=
0mb. There are many programs. Every has about 100-200 modules.
Company has 40 developers. They all works via terminal on aix.
At this time we have three folders for three versions. Everybody send chan=
ges to them via script blocking parallel work.
It's possible migrate to the Git version system. We are afraid of big loca=
l copies for every developer. We have not enough space for 40 x 800MB plus=
 history etc. Exist some less dramatic way?
Thanks for your info.
Best Regards
Georg Black
