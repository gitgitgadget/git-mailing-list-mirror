Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0DA1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 00:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfAIA34 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 19:29:56 -0500
Received: from m12-16.163.com ([220.181.12.16]:52760 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfAIA3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 19:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+iG9j
        znVKckGOSlm5LB4Mol4YiCx3oJ2hz639YGqomc=; b=M3vtJmjWcCAIu+XWvBUBs
        GiQmounD97YDEmiA2mlc06Qfl+m2czcJUbHcJxt4h97afCBFzNFWreptqBBrSyrW
        IA/+KSdK8A7jdLy8wJ0yJnxvoAJK28e8qSdHvvs3gkrgIpfsqJXHLyekw8/SaXx4
        3Np7jUwm0UVjyMldzmXkWg=
Received: from localhost.localdomain (unknown [122.235.191.23])
        by smtp12 (Coremail) with SMTP id EMCowADnagVvQDVclh5IAA--.1185S3;
        Wed, 09 Jan 2019 08:29:35 +0800 (CST)
From:   16657101987@163.com
To:     gitster@pobox.com
Cc:     16657101987@163.com, git@vger.kernel.org, sunchao9@huawei.com,
        worldhello.net@gmail.com
Subject: Re: [PATCH v4 0/1] pack-redundant: remove unused functions
Date:   Wed,  9 Jan 2019 08:29:11 +0800
Message-Id: <20190109002911.78405-1-16657101987@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqzhsb3q1c.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhsb3q1c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADnagVvQDVclh5IAA--.1185S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw17JFWkJF4DGw1rCw15urg_yoWfJFXEgF
        WFyas3WryrJw47G3Z8XF45WFnIgr1UGr4YyryfZFnava4SvFs7Z3Z5Arn2qa4Yqa9agFnr
        Cw1rt34avr1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0CeHPUUUUU==
X-Originating-IP: [122.235.191.23]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/xtbBDw83glPADEykcwAAsx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 16657101987@163.com writes:
> 
>> From: Sun Chao <sunchao9@huawei.com>
>>
>> I'm particularly grateful to Junio and JiangXin for fixing the patches,
>> and I noticed Junio send a new commit to remove more unused codes and
>> suggest to SQUASH it.
>>
>> So I create this new version of patches to do this work, I also have
>> checked the left codes and remove a unused struct based on Junio's
>> last commit of `https://github.com/gitster/git/commits/sc/pack-redundant`.
>>
>> --
>>
>> Sun Chao (1):
>>   pack-redundant: remove unused functions
> 
> Is this meant to replace [v3 3/3]?

I'm Sun Chao and because my huawei email account can't send
email outside from company, so I used 163 email account to
send new path at home. I'm sorry for not explaining that.

Yes, this is meant to replace [v3 3/3], and I have noticed the
patch is applied, Thanks very much.

