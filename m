Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A441F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 13:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfACNuh (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 08:50:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:41907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfACNug (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 08:50:36 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKIEQ-1gdPEI40H8-001ha2; Thu, 03
 Jan 2019 14:50:29 +0100
Date:   Thu, 3 Jan 2019 14:50:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "Strain, Roger L." <roger.strain@swri.org>
cc:     Marc Balmer <marc@msys.ch>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
In-Reply-To: <59718f73a0a14b828a6d4fd4c8c222d1@MBX260.adm.swri.edu>
Message-ID: <nycvar.QRO.7.76.6.1901031448260.45@tvgsbejvaqbjf.bet>
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch> <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com> <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch> <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
 <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch> <59718f73a0a14b828a6d4fd4c8c222d1@MBX260.adm.swri.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o3W4caQVWmvpRqW1c+AQvCL8kDeIH9amxru2ezyHlUqMWPoU3s2
 GonwfM8NEX/nLO5OA/63iUcc73WTUXGKjmgyqiDoBIXcnNDAz/j0I/yBhlei4rvzbSmxwpw
 a7PlMzgJO3ODHTnzpSHiwc22hdbW9MbTOwGE4KlBoTRfpxbVuqhxnRRXv9IltByWRr4Py+2
 74TkxY30k4fClzjNSs6UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aKOD8+GjW1g=:WlO9Nhu3kUKdxM46kBLOav
 wZUZjhAEnJSCOIf5Vk2ctd77v32vFjD1GuKjo3kRUiod2gPgG6by4bS4UQ7J+fUHXhltpEEsP
 zfQCGPVWkNYpPo/SUwe4og7j+ASQ4Md34KVpbwknxcuyh6oRcHrLY5mXVfHOjSMOMUFkCXTdi
 6dE9iyD1sW5cQusiESAc7iN+g3y/aI57B14Io9yNYQ7aeKN+bPLYJ6Hq7t16ljeeS7WEkqd+8
 rguOIIWLLKv3hzF2ymRA1QYs2ayeVPvs4oLfwgrzju1hwoOeaC23PKFPgcCDyP+nyZsgWIMUC
 oekBkrideeILzU+UyB+Y7NFzf3GQydS7Mmzx+0ckScnzTuwRFHDsmFSeUTRnmiyDjV0cXqiAy
 q65f/eLVgS21CDN4rl5BCIwSOPPCM4c3klD8XiLOL45Kkg906fd+5drUL8kXR2b7ahYghgGGV
 5HcI4N4PzRSduZFNHc+AlH17+NEn9ttg6qSr5lxKDPFGhzSL0A16fKHUTcy0CEvNLfpzZYubA
 GJv6KVK+7lZs0crnXGCBmMT7r45b/d2SilGYowfdxrkVGQTT+/+rZYzbs/WAAJJdlDZPstOcu
 2niQHgiW6vcQOK1Ijy6a/GSEFp4mduyHfs5xUtjFF3/WKISO+2DhCmG7hy2CvS7DUMmeoDbsu
 w+87++1BHR9etyilQsBQ9ezw9ZmRKI+7o6Is1P4n9OoDfLTrr4BFDXip7dI9AtjoK8A+2DKYs
 v4xr0Oor5lplxCX5DRzmJ692p0FXEcDrV4f1vNS47YbRAcENKTfD2XbO73PaJcwbYHjm20yov
 5E3kxR5pZ6bBfnkb0qOtqO3sLqzwWX65aiYo8TIPg011PrZOfmkxGq0JkbW2od0RS91e1U/Sb
 MT0b2TlfTiDROtnHbPml+OjJ8FDZwMeodrbk2bGfVeu+PLYDh0dW6GOBrLhpCCEoq00brByem
 WwOCapbdlTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Roger,


On Wed, 2 Jan 2019, Strain, Roger L. wrote:

> TL;DR: Current script uses git rev-list to retrieve all commits which
> are reachable from HEAD but not from <abc123>. Is there a syntax that
> will instead return all commits reachable from HEAD, but stop traversing
> when <abc123> is encountered? It's a subtle distinction, but important.

Maybe you are looking for the --ancestry-path option? Essentially, `git
rev-list --ancestry-path A..B` will list only commits that are reachable
from B, not reachable from A, but that *can* reach A (i.e. that are
descendants of A).

Ciao,
Johannes
