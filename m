Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972CCC433FE
	for <git@archiver.kernel.org>; Wed,  4 May 2022 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355537AbiEDRK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356962AbiEDRJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 13:09:51 -0400
Received: from mail2.pdinc.us (mail2.pdinc.us [67.90.184.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB0473B7
        for <git@vger.kernel.org>; Wed,  4 May 2022 09:56:43 -0700 (PDT)
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 244Gug9c011805
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 4 May 2022 12:56:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 244Gug9c011805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1651683402; bh=wMux868w+mG+8Gt7Jxiybu0vm7RZQJAsR1L9V8sm4rM=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=pg+yzBjL9454kT22/1gU3zX3vAfa2NOpshS6uleruOwzk6FsssKZifQgA/y4z00TA
         9YYHAIYNWziuJIyqBpg8MQl8E9sbXwI9en/XcmyP9R1XJ8sq+jdv20mvczBycpGxIT
         ds/pFaO3L6gLiHXRc4FHeuSt6rkDc1XgqcTHs6Lox//4kLByOU0q2ArqEgOSRyZvBT
         NBoP70/2QtMRjmgDTecyMJ87t+YYBMvLG8iD055C8PZ2fpdhJS60qzxHe6WdiIjpF0
         +U2TonL0rsyWflfgedqSVOSU1moieBGeiO7J9jsuvZU199Us9azpMAZguCGcPF/+p6
         RxfrcUsnp1dig==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
References: <15ea01d85fcf$356462f0$a02d28d0$@pdinc.us>
In-Reply-To: <15ea01d85fcf$356462f0$a02d28d0$@pdinc.us>
Subject: RE: is there a short cut - cloning kernel - resolving deltas 3+ hours and going...
Date:   Wed, 4 May 2022 12:56:38 -0400
Organization: PD Inc
Message-ID: <163301d85fd7$ec1b0230$c4510690$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLCLXhNblrukxOCvaup/zxK1ZcmK0pnfUw
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Jason Pyeron 
> Sent: Wednesday, May 4, 2022 11:54 AM
> 
> I am on a 4 core ARM system 1GB ram...
> 
> remote: Enumerating objects: 8716377, done.
> remote: Counting objects: 100% (748/748), done.
> remote: Compressing objects: 100% (748/748), done.
> remote: Total 8716377 (delta 4), reused 740 (delta 0), pack-reused 8715629
> Receiving objects: 100% (8716377/8716377), 3.54 GiB | 6.85 MiB/s, done.
> Resolving deltas: 100% (7232922/7232922), done.
> 
> Helpful thoughts? Or do I just need more patience.

1. https://www.kernel.org/cloning-linux-from-a-bundle.html
2. do that on a better system
3. copy the .git folder over via NFS...

Done 5 minutes.

-Jason

--
Jason Pyeron  | Architect
PD Inc        | Certified SBA 8(a)
10 w 24th St  | Certified SBA HUBZone
Baltimore, MD | CAGE Code: 1WVR6
 
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397


