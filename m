Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15A92042F
	for <e@80x24.org>; Wed, 16 Nov 2016 19:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932177AbcKPThK (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 14:37:10 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:35995 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbcKPThJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 14:37:09 -0500
Received: by mail-it0-f46.google.com with SMTP id l8so85238739iti.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 11:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cakoose-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=BfGjZpz9kBw5+S9EjXTCqkwGWF70DiXVftUdNpgXXJg=;
        b=YWqhSwU+kHJJk9b/yA0vffdJ6mylWTYS+JfLcJyAjPDQ6AdLJXzEOa4sj2f92MR392
         KKCp+QuNWLv2yCkO34Xiq6n/35szZW4ehGWm8DD7z9t2p5UJ5J5Xker+32oN4lzNC9UW
         LL+o81OAunA9Z0sgUqXamXr+qM+dvFihvjxt4O6m4sFiJLslRWuwkyhXxwahmxZtNgqs
         p51wXnwMbU4Xinh1tMgGu3bnNU/ScsIWGQFdEk0Lktsc6FELPFScNk4u5u/OPBIkeeRT
         B92NcCQ2w7ATUUpLzAs3/zVEff2ibJNNyUET3+eK2Yaqnu6rAKOH2Epm9uPS2u9xOB+q
         yoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BfGjZpz9kBw5+S9EjXTCqkwGWF70DiXVftUdNpgXXJg=;
        b=Oi3E4/eMU4K/zD/R03S2Zbdkrawchmgtmo2MjnNiCZJwZz0t3bp1/K/81NO45uzMoQ
         anxed1q1TooZGFjCBuP7Tm0wHVOCV99vvGt7DG0XjvrxTSjiM1NNgEyLMjwf+sg+nr0Y
         ZoRBmOmFv5MoalL7/ILEHj95xmSq4VWWAhHa875s9tZn011ikSXesxBba1aW5Mc1Ieei
         Iw4XaMM+hjeeEUqrRzMXdwwSNoqHOJzRliZ/tPFotMDgGusbECE8afGwQNRufROMC+6R
         FdocZNyjP5gYJ9xsWiqiHnyG8+4biZolz855XS1zcCNgULnGy7jb5ixo2yCDCP37Ppda
         6x1g==
X-Gm-Message-State: ABUngveAZgZGsffsihFZlNdTAjjPASh4a/Bhfdu7QDBVoUlwy1c8A+bjWuTc2aR2IKBGUMCoy14+4LwjBY7v7A==
X-Received: by 10.107.37.198 with SMTP id l189mr3907229iol.181.1479325028865;
 Wed, 16 Nov 2016 11:37:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.8.225 with HTTP; Wed, 16 Nov 2016 11:37:08 -0800 (PST)
From:   Kannan Goundan <kannan@cakoose.com>
Date:   Wed, 16 Nov 2016 11:37:08 -0800
Message-ID: <CAM7aVoVP2+v5G2f7NUt14j9NKJvJxxSFXZLANP5UqiYEQgbBqQ@mail.gmail.com>
Subject: Can I squash the merge created by "git subtree add"?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I do a "git subtree add", I get two commits.

    df7e8f5 Merge commit '6de34775ea846c90e3f28e9e7fdfe690385c068b' as
'go/src/gopkg.in/ns1/ns1-go.v1'
    6de3477 Squashed 'go/src/gopkg.in/ns1/ns1-go.v1/' content from
commit 1d343da

Unfortunately, in the environment I'm currently working in, merge
commits aren't allowed.

Is it safe to squash these two commits into a single commit?  Will
future "subtree" commands still work correctly?
