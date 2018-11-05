Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C751F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbeKFDbI (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 22:31:08 -0500
Received: from mout.web.de ([212.227.15.3]:52461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387595AbeKFDbI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 22:31:08 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgHKO-1fh8rb0efc-00ndpK; Mon, 05
 Nov 2018 19:10:15 +0100
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgHKO-1fh8rb0efc-00ndpK; Mon, 05
 Nov 2018 19:10:15 +0100
Date:   Mon, 5 Nov 2018 19:10:14 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Adri=E1n?= Gimeno Balaguer <adrigibal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181105181014.GA30777@tor.lan>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104170729.GA21372@tor.lan>
 <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:tdDiiSXaoYHja3JHXmiK4POcaL54nIPEwnY6Lat9hx5uDdapa/c
 QT2W7ThLe15K1bAkPzPKgVT/4Jy0id1BmN/4WdgmOzZyqyTfjnB8Vza4IPpMhU6BvvV5tb4
 /LWDTqM0sG9SiOHM71VSe2oaceNa8eC1wt6os28aNOYg/6JkT7/0D5TMDJcceZDuznnG+p6
 MD1tqtGxp3t2c5A2h3MIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dq/7kS3IvZo=:Qf1+nLNb4T4K7VeWLInkQ2
 Vv6bhd2JqIzXZe2ahsYDWrDpQYyRY/GHbONDg+ECIc78Q8nCRtNRBmo82xd/vGaIc09kQBUhX
 +Qz+sQRiz/nRF1R3ESO3rk3BeA/UFueZpKG8G/q1XiBv1J0NoyZ3ywLc+7gm+JA08/8zGU+vt
 4BMgFVObp0NQZO0A6Zglkon/REbqyBpMfTCgbMqkyn2KazTDwsfF9ENlNMBGKbhMqKOkyX+Zu
 hZeQOO/npSwUyAE2h5YJHAaTLsGqU1Jjps+vD624paKlLmApPM6tWV6MiWCXONVULmoFjr801
 FXyn4pmiQqPvMB6IirbmI3XytGC5H82OWeyB6n2lWrNN+4DyX13GUe33Q8CBgQI5F5NWM0hPw
 crjz9W0kaFFzy34GNIWcAGKfG3MuZvsdGZqkjs7uwL0sx9upnf9rfN8k5qXw9HMjBZ60MlJZH
 sC3vNY7VpsGhHhKzRrW2kfhxWrvPLnv2i9XqSMaDlFW9SW6MlKXkkXSn8xT8hgmzdBO+VcnjF
 b3YhvYiHRAKbQ8HfEGRUIpVDVdCF+KOa8XMKuXJ22RwIPWQEdMA4kxfIS/OkmcpnO/D9P8HG2
 s+jI1RIGGwQVVwvHdCzDhYZmXvpdZgG7DwlgBhQsYGE8RZ9nHaTq6wvjCC8mPka6QYfQ43wXy
 WfGjbODTb9htKNnkOgNwfw0+xQOLKN8AQ9exTgKL/NB53SWGVECPlp7gMDFIk4iv1wgOSnN9p
 fOCzxV1d4fJSCz/0EkJDeLLAyoR8BnbYwIjFqTLfSSjyWNSCdkS+LSKlBMtHTryyFcTX1dR97
 ppwYvAxqzx68+ur4qTi4+5H8/5tZd2gF4SAcF2eYxnFNM5OfNGuujsloXsMv/j+zj8R2D1FEY
 WB+cJOrhi1IPbL5AMwKf/x/VG9NVL3uOirJUOnhzo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 05, 2018 at 05:24:39AM +0100, Adrián Gimeno Balaguer wrote:

[]

> https://github.com/git/git/pull/550
 
[]
 
> This is covered in the mentioned PR above. Thanks for feedback.

Thanks for the code,
I will have a look (the next days)

> 
> -- 
> Adrián
