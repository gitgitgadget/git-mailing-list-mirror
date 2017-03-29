Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6465F20958
	for <e@80x24.org>; Wed, 29 Mar 2017 14:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbdC2Ojf (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 10:39:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdC2Oje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 10:39:34 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MVZ1v-1ce65L10hT-00Z0sn; Wed, 29
 Mar 2017 16:39:24 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 0/3] name-rev sanity
Date:   Wed, 29 Mar 2017 16:39:14 +0200
Message-Id: <cover.1490798142.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.712.gba4c48c431
In-Reply-To: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
References: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:l5TQCs4Bgah25eCETPnSnuq6eHKKaiCNzcWJ0JNnK4N8RvPzkQe
 2niunt0blMkOCcXEBXUbh2XvyolGaUS6kZqUR1lWniof7xo1CPM/H4pXFJQFcu4cKEhoiTs
 pLnD53AGbXlSU24BKr4JMC2CC48HPkeOxV1BbO8w82mSrc/kFNSAVHAf9UAIqr5QsJ1qhfl
 9taZ8hLDcSjpOWXCcpqmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9gZhRYnGHOk=:e67QEXOBWLcBsrENn8MiHE
 KUuanRgJ/Fs7Z/J1ljGclbjw3BpGVsy3ZIeeAegE6eBAI6X8w4SMvN//pMJlvpHHENcJUXIBR
 mIlrjRVT8H8RNsp8Vs9OIgZEhbwJviBm4qzXdWI67WIpXR/vdnWl0FHCxAAqbRo9uHOn5+ifs
 s9ru61OYYjO3hdYO4yCUrvmry+YWOWIqmgqVphlxlws4ht3B85KqtnvERH5wdQyx007O7Ys/G
 odsAX2dMtSdY+ghHqAjqtGLM3zXw1HZGdegazHLwwomJ2ZOX9j0dR+8NSzrkw4Uf0+IOpeF0H
 2kNUZht1iohrz83ct60Q0QAUJVIZJWD89sHnB2/7MxtWDuK/+e8h1VAPgbwkNckU/csAovyzQ
 SJhNKJUM0ar9AXJ2obaNcAYwy3QTZQYcZ/wPwbFHl5Ea17ouU2+e7Vr78hx/XZSZd/XdH3yqT
 ioQKhKKXkx6dqstYWNKT4oBTgAtAGjisY2Ie7QquWnz2dED9kf0Qa8/kgQ/emqSxDIFrqvP15
 QpsQjjbOnww0pmQTYEKm9Jc2ROI1LxkgFJi9xyuvbsFF15PFQ/d8wa2qgXcxN/LAMSFofi4MU
 dOxbNqg4W25F+NK3vW2jbKq87t08QqiDb+hS02zeofTXtzpNE+wZrkgXPAEmlVNsKD8QJlfSA
 jzrl84bUw+buXrz94XeZIJrIoVgnUtWc7/WOcPJzq5E9DQq6GPfgNboBFn2IGmRLoNsc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is v2 of the name-rev series, the result of our discussions being:

Junio C Hamano (2):
  name-rev: refactor logic to see if a new candidate is a better name
  name-rev: favor describing with tags and use committer date to
    tiebreak

That second patch is slighty changed as discussed, but still mostly Junio's

Michael J Gruber (1):
  name-rev: provide debug output

This replaces the patch which documented that --debug does not work with --contains :)

 builtin/describe.c |   2 +
 builtin/name-rev.c | 117 +++++++++++++++++++++++++++++++++++++++++++++--------
 t/t4202-log.sh     |   2 +-
 3 files changed, 103 insertions(+), 18 deletions(-)

-- 
2.12.2.712.gba4c48c431

