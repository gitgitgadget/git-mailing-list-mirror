Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944ADC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 17:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358870AbiFVRVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344588AbiFVRVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 13:21:31 -0400
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 10:21:27 PDT
Received: from cicero3.ch-meta.net (cicero3.ch-meta.net [80.74.152.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8F1F2CB
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:21:27 -0700 (PDT)
Received: from [192.168.111.22] (localhost [127.0.0.1]) by cicero3.ch-meta.net (Postfix) with ESMTPSA id C86DC74924A9
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 19:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=king.ma; s=default;
        t=1655918003; bh=ZNc9/SmqK6beAtuQQbBRtM7VMaZgQDj1zZIummUsV/c=;
        h=To:From:Subject;
        b=LqfFXFKAcseWfTsTwc6TnQxTUcDcnDheUPtUGI6rH6VSv8hhcozuYiMFT0oLHPV1T
         ETFeshrlMZ3O6Fod1UhKKZnY6Vpu9/60Sr5GGl9vuurJrI4unezFdJwPB8HntTDJjX
         dW6SeGB0mCu++KOOJYQ8Fa/ntkYDPknNuwONGL9w=
Authentication-Results: cicero.metanet.ch;
        spf=pass (sender IP is 83.97.81.249) smtp.mailfrom=theking2@king.ma smtp.helo=[192.168.111.22]
Received-SPF: pass (cicero.metanet.ch: connection is authenticated)
Message-ID: <13e7096e-5a8b-319f-659a-914aaf8b9731@king.ma>
Date:   Wed, 22 Jun 2022 19:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: nl
To:     git@vger.kernel.org
From:   theking2 <theking2@king.ma>
Subject: main as default
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just had to install git again on a windows box and surprised to see 
that the programmer still has to choose "main" to get the noweday 
standard installation. Is there a time frame when these and others 
(Terminal in windows is not "new" anymore, windows comes with openssh 
available, use the native Windows SClib, stop installing minTTY, use sym 
links, built-in system monitor is not so experimental (or is it?)


cheers

theking2

