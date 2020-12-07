Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3092EC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA29D23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgLHAj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:39:26 -0500
Received: from mail-gw.thundermail.uk ([149.255.60.71]:44754 "EHLO
        mail-gw.thundermail.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgLHAjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:39:25 -0500
X-Greylist: delayed 765 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 19:39:24 EST
Received: from mailgw01.thundermail.uk (mail-gw.thundermail.uk [149.255.60.66])
        by mail-gw.thundermail.uk (Postfix) with ESMTPS id D84E46004248
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 00:21:27 +0000 (GMT)
X-ASG-Debug-ID: 1607353230-0554130f651f9dec0001-QuoKaX
Received: from cloud208.unlimitedwebhosting.co.uk (cloud208.unlimitedwebhosting.co.uk [149.255.62.11]) by mailgw01.thundermail.uk with ESMTP id LK16fDJOGPOmMHkr (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO) for <git@vger.kernel.org>; Mon, 07 Dec 2020 15:00:30 +0000 (GMT)
X-Barracuda-Envelope-From: nau@epochgames.co.uk
X-Barracuda-Effective-Source-IP: cloud208.unlimitedwebhosting.co.uk[149.255.62.11]
X-Barracuda-Apparent-Source-IP: 149.255.62.11
Received: from webmail.epochgames.co.uk (localhost [IPv6:::1])
        by cloud208.unlimitedwebhosting.co.uk (Postfix) with ESMTPSA id D39F7C74ED4
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 15:00:29 +0000 (GMT)
Authentication-Results: cloud208.unlimitedwebhosting.co.uk;
        spf=pass (sender IP is ::1) smtp.mailfrom=nau@epochgames.co.uk smtp.helo=webmail.epochgames.co.uk
Received-SPF: pass (cloud208.unlimitedwebhosting.co.uk: connection is authenticated)
MIME-Version: 1.0
Date:   Mon, 07 Dec 2020 10:00:29 -0500
From:   Matthew Norman <nau@epochgames.co.uk>
To:     git@vger.kernel.org
Subject: Smudge Error: Smudge Filter LFS Failed during Git Pull
User-Agent: Roundcube Webmail/1.4.8
X-ASG-Orig-Subj: Smudge Error: Smudge Filter LFS Failed during Git Pull
Message-ID: <b58450627125b2eb3cae726e9a82e56b@epochgames.co.uk>
X-Sender: nau@epochgames.co.uk
Organization: Epoch Games
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <20201207150030.1238698.35470@cloud208.unlimitedwebhosting.co.uk>
X-PPP-Vhost: epochgames.co.uk
X-Barracuda-Connect: cloud208.unlimitedwebhosting.co.uk[149.255.62.11]
X-Barracuda-Start-Time: 1607353230
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://149.255.60.66:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundermail.uk
X-Barracuda-Scan-Msg-Size: 533
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1.9 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.86362
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello GIT-SCM Mailing List,

Maybe you guys can help me with a "smudge filter lfs failed" error my 
development team and I are receiving when we are pulling from a branch 
of our Git Project?

The details behind this question can be found on StackOverflow.com:
https://stackoverflow.com/questions/65182585/smudge-error-smudge-filter-lfs-failed-during-git-pull

I don't know if this is a Bug with Git, Git LFS or something else 
entirely.

-- 
Matthew Norman
Operations Director, Producer and Co-Founder of Epoch Games
