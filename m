Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2294A20248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfDMFcq (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:32:46 -0400
Received: from mxb1.seznam.cz ([77.75.78.89]:58950 "EHLO mxb1.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfDMFcq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:32:46 -0400
X-Greylist: delayed 887 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Apr 2019 01:32:45 EDT
Received: from email.seznam.cz
        by email-smtpc6b.ko.seznam.cz (email-smtpc6b.ko.seznam.cz [10.53.13.165])
        id 3be58bd3293778b83bf11074;
        Sat, 13 Apr 2019 07:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1555133564; bh=Q4UZ6Rv8ki764YjDnBQkYSCeTfvhQRZOzV7gkuukZaw=;
        h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=lXewktO2f3+7mUagaEeWLM1Wmv1bzJBJoFvG3VBYq6HqJIaTakOD7z2S/dr7Ey7SG
         tdqewvnYwPoxoPF7JI8v/21OnGTNSnzQy4dtSrwrblnmtIYUgvn0IGP/Sif5TwYRUz
         Zi+PGykpLoPHC5/zqjfNmQOQMPOvZPJrCIUPpiJw=
Received: from unknown ([::ffff:93.181.124.132])
        by email.seznam.cz (szn-ebox-4.5.353) with HTTP;
        Sat, 13 Apr 2019 07:17:54 +0200 (CEST)
From:   "Mgr Georg Black" <georg.black@seznam.cz>
To:     <git@vger.kernel.org>
Subject: Repositories stucture
Date:   Sat, 13 Apr 2019 07:17:54 +0200 (CEST)
Message-Id: <5cl.5Cyq.1JuGDapDk}8.1SiN42@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.43)
X-Mailer: szn-ebox-4.5.353
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone.
We are starting knowing and working with Git. We already used some version=
 control=C2=A0 systems for parts of our work and for now we wanna to have =
one.
So how's the situation.=C2=A0
There is one big company with integration center and a few=C2=A0smaller fi=
rms which send their work there. We are developing in many languages on mo=
re projects.
People from big company(BC) wanna to have only one big repository with all=
 code in it. BC wanna have to folders structure for language and projects.=
 But for us is that idea bit uncomfortable because we rather have more rep=
ositories by language, maybe by project (in BC folders). It's useless for =
us that every developer on specific project and language have all other so=
urces in their local repository. Is it the solvable?
I looked into some ways but with nothing practical experience Could anyone=
 give me some advice which way is the best and why. 
Simplified: we want to have many repositories in our firm so every develop=
er could work with its repository with its language. Somewhere would be on=
e repository for integration man who combine all smaller repositories in f=
olders big repository for sending to BC. And this all have to work both wa=
ys. So we wanna donwnload changes from BC and copy them to our divides rep=
os. So some folder to repo.
Thanks to all for any direction or link.
Georg Black


