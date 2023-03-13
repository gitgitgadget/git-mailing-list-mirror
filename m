Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7150FC6FD1F
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 01:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCMBLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 21:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCMBLq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 21:11:46 -0400
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Mar 2023 18:11:44 PDT
Received: from mail1.pdinc.us (mail.pdinc.us [67.90.184.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694DC32529
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 18:11:43 -0700 (PDT)
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 32D18jXe015643
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 21:08:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 32D18jXe015643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1678669725; bh=qq6zhEZ5tj4HJeWZKKNl9NP0seMP/xMv9x0Bld+AnqI=;
        h=From:To:Subject:Date:From;
        b=XBWahg0felH1Eytyu85tCU5kDCUIhPiFsP+Cqy2goZbGuGmJRPLRxeVmsYqHmzaeD
         xjv7BjuSZEM/cGSNYI9I2sD8e0hcWB1QVgJY6iODerzjdy1pvRi6ppdh8MFOjivTD8
         WbXZMeo/8jK5ZHXsrUXODlM1LWyugb7aeNX9xphmeElDt2jIiXXcjfaoJgtfio1kdz
         dmP/Jlyj/33RLZRMG9CTSMu9hqEDdSaGanUufoIyRafDz9q5IN+LRbVN4N4fHtkMcl
         UylHal3FtdtKjymrTy3DXQ2uCiobhate4KF/e0LjMfUWyrme3wVbRc6flwb9fZw9Rd
         MOthwQ2CVLkOw==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: git alias for log with format - how to support --no-decorate?
Date:   Sun, 12 Mar 2023 21:08:44 -0400
Organization: PD Inc
Message-ID: <7390201d95548$5ba4bef0$12ee3cd0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlVRnfbLgSbtvhsQMmplR+I2kEkyg==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is my alias 

alias.logg=log --format="%C(auto) %h% ad%d% s%C(green)% aE" --graph --date=short

besides creating another alias, can I make the %d silent when I pass --no-decorate?

Is my only hope using a shell function / command with a ! prefix?

-Jason

--
Jason Pyeron  | Architect
PD Inc        | Certified SBA 8(a)
10 w 24th St  | Certified SBA HUBZone
Baltimore, MD | CAGE Code: 1WVR6
 
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397



