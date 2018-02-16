Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9381F404
	for <e@80x24.org>; Fri, 16 Feb 2018 23:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbeBPXaM (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 18:30:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:54973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeBPXaL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 18:30:11 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MexaL-1fAgw40hNR-00OYR0; Sat, 17 Feb 2018 00:30:09 +0100
Date:   Sat, 17 Feb 2018 00:30:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git-for-windows@googlegroups.com
cc:     git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Please test Git for Windows' latest snapshot
Message-ID: <nycvar.QRO.7.76.6.1802170018250.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q/oaxyaGjnLOvzKPG5yKG4PPIE23YgRm7ARXcpMZFbSwlRzPCFu
 wga/XvAOB378HMkdkXpomp5WvS35RxHfqXpSGcQM4HVI6un26/XQGabf0uohuxkeOuibZAP
 xV7HATHWFQ6TKIRuRlqn7cRJHWXUYfggnkKSeOui6zjeEtkm3cYoYscSw6npTTaEQ44kOPI
 gxd0vx1yM9AsBnytfXYLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O79YkBe7wek=:ciq3q64hMGIuc5xKb0RpZl
 kxDsNCpxrA1O0e/4tLbYPGAtULTnacrNKcQnqV1WyXe9WzUuagjORi4Hs5mVeWlIPaxDxHXd+
 FhpY5N/48iRYsG7fSv2D8i+zr9EHfru33L3x0SxBb3tSPNPDPOEui4DBBR3X4h7OxAWq2+2/5
 8mbZgdwPxsecIP9G3yN3LoZ1p6vDaOW1dYYLnjIxsyQ3JcSFHdF5hmUbf8V4O+V0M2RKapDGi
 /vbgVBpvVWZ1XWcZQODj0kSMAgGilBCNfnVAsTPxOZEjLWKbBJnqMiE7QtvQYoBih+AR9zzeq
 tSjBrnmJmI5NnDQZyt2A17REsB4sykym2BgP4Yt7jIlhAc9gugX6TRs8PlCrbhxs8BGVMnpe+
 moGjcvmi95W6H9gx4wP3PnCtx0og9Qmslm8lLlcGyA1xvoSKnIHJHJsu7AIgbwq0NnVuINe4/
 2TEYrlivyTF6DDB7LvQqPbI346BZn6v0haUykR3nMpEhdQ7aC9Xn7aeZ1uogz8HXO2NTUEPAg
 sIzT/yIpDSZK3TenMb3mdC0EW7KlXFzzAwU9V4ytjJxgAscsLKHqQSNSrXbGkazKd+u+YYovm
 C9jAfgHHa1eYU8aGwxx7/9JE1Jv5cUO73AmkqYTw0FZy8u6lJktIuaot/zE1zMtB6raFSJyVA
 yWr67BkIzWKbFMM5n9FK+V6lD5VSTL5i6Fq3INXd0hF7LIhrz1ZSu6oVqG7YryiIQ+M3xiwbz
 h4jq/SFtrTLhsYHdk8jp6OAhsuwtswT7h9O3v84Qn84i62usxtTYfmQ6ulCZ2jqaMgt0OQBip
 nZatOQFlXS30pqcYyDe4QQ9Fp2DrKfN0eJlf/pkZ3LpWh6bJHM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

I am unwilling to release Git for Windows v2.16.2 on a Friday night, but I
have something almost as good. There is a snapshot available here:

	https://wingit.blob.core.windows.net/files/index.html

That snapshot brings quite a few updated components apart from Git proper
(such as an updated MSYS2 runtime), and I would love to ask y'all to give
this snapshot a proper "tire kicking".

Think of it as a release candidate. A real one, this really is the
revision that I would like to release as Git for Windows v2.16.2 on Monday
(with the only change being the version number).

Thank you for your help!
Johannes
