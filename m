Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511671F461
	for <e@80x24.org>; Sun,  1 Sep 2019 11:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfIALHj (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 07:07:39 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:38385 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfIALHj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Sep 2019 07:07:39 -0400
Received: from [IPv6:2001:980:2408:1:8139:40de:f3e0:55c9] ([IPv6:2001:980:2408:1:8139:40de:f3e0:55c9])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id 4NhpilYyRDqPe4NhqiYImJ; Sun, 01 Sep 2019 13:07:38 +0200
To:     git@vger.kernel.org
From:   Reino Wijnsma <rwijnsma@xs4all.nl>
Subject: Retrieve version-string on shallow clone
Message-ID: <26d7f32e-2df5-ce39-cd20-8cd82dc8587c@xs4all.nl>
Date:   Sun, 1 Sep 2019 13:07:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLlkaqT1QYwNQqhZQBk2q+iXrqzaqGlp6C1FlL3IKEN6AHbnkVPItYAJeh9XeNRz/IEMpFXl8uT30r0PfrjoLP+OPIfvxkM/hkfgKXxEl0P37yPNGunO
 GAXYwiye13mZ3LmvgDokatFhRumKmKjppmT58/xZ+itI7bnKpbh8SBrm6b4PNb7dPW/wjqTGHFmeyeZCY0TYQYPXUfR3MGmVCEuf1K4MUYja7wVKl1GW9hLl
 UL5XNw5/d9ipDjsVzdpmJhYPZPmw153ARc4DE28d1VA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git@vger.kernel.org,

Two days ago I started https://github.com/mstorsjo/fdk-aac/issues/107, asking how to retrieve the fdk-aac version-string on a shallow clone.
My question was of course not fdk-aac related, so Martin Storsjö suggested I'd try here. It basicly comes down to this:

git clone https://github.com/mstorsjo/fdk-aac.git
[...]

git describe --tags
v2.0.0-185-gcc5c85d

git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git

git describe --tags
fatal: No names found, cannot describe anything.

The tags get lost while doing a shallow clone.
I'm not an expert git user, so I was wondering if anyone could tell what my options are here.
I'd figure one of these options would be to clone everything from tag v2.0.0 onward, but if so how would I do that?
As another option I was thinking; maybe it's possible to do git describe --tags on the remote repo?

Thanks!

-- Reino
