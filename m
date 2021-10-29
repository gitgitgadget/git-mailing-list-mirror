Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB3CC433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A7761184
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhJ2Qd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 12:33:59 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:29121 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJ2Qd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 12:33:58 -0400
IronPort-SDR: svNtqQBMPs5QNSi3w8P+MAkpM4DJikiwTbI3gOKFK8OScIC1SZTHIjYfwYTYGkEzp5b8mAqOF6
 bRYL5OpVoyWDk5cMc71zIBK4V1EcDPXXn3j5FQqcYgADHuo+xWgFa2oIYBy8KrpDsjD3BgYjOT
 EaxevZaw09Onq/1/gnSJJyNBvGY0ikmdQ29Usac2A5nUe6DE1BB4MMniVPBMT4xjND0tKg7SxL
 OlggPGKx3YivqwGxRiPurWiszjhgtiV5clkb5FfC5eTFBxa/fwIx4p/Ji/LOxHV3f2B+DAeYre
 GmySO68zZnER7SVe9SvrIyQq
X-IronPort-AV: E=Sophos;i="5.87,193,1631606400"; 
   d="scan'208";a="67645094"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 29 Oct 2021 08:31:29 -0800
IronPort-SDR: q1xEyk/DtURkSCYmwbNaI/Ow16fBLtgyAA60V7w1mQ4ziPQvK1yjSEZG+vbSmtGaROd4hAySmm
 YnyWE/qYIfaSea4kAJvqEZupWJup6DeB2df4FQfDZLRDnMtDm9yPGzYtBbJKWVDnCWMBDGyNVf
 +us4uZ+cGxLOvJAXDNQ89XHAb0iHO7YXhSl15SxzfqSw7CY9wzjZ2f8dy5lPr/DnI4YpD6spfE
 yvAZOUG13AG3CUEVH+gHhw1afcNsHBxrh7H1R7yCglX/nbGOa0nZHYvVJ9isNdGzF1fEYKJe8w
 PyI=
Date:   Fri, 29 Oct 2021 16:31:23 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
CC:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Libc-alpha <libc-alpha@sourceware.org>,
        "tech@openbsd.org" <tech@openbsd.org>,
        Klemens Nanni <kn@openbsd.org>,
        Benoit Lecocq <benoit@openbsd.org>, <git@vger.kernel.org>
Subject: Re: Is getpass(3) really obsolete?
In-Reply-To: <865e5899-b991-918d-8bc6-ced65a67a566@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110291627330.1788146@digraph.polyomino.org.uk>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com> <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com> <211029.86r1c43uwj.gmgdl@evledraar.gmail.com> <865e5899-b991-918d-8bc6-ced65a67a566@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-09.mgc.mentorg.com (139.181.222.9) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Oct 2021, Alejandro Colomar (man-pages) via Libc-alpha wrote:

> The broader context is that I was trying to make the deprecation notices more
> consistent in the Linux manpages, by using the [[deprecated]] attribute where
> appropriate.  While doing that, I found a few cases where the
> deprecation/obsoletion is not so clear to me, such as this one
> ([as]ctime[_r](3) is another one, since it is deprecated by POSIX, but not by
> the C standard, but I'll start a different thread with that; and isascii(3) is

See the discussion of deprecation starting with 
<https://sourceware.org/pipermail/libc-alpha/2021-May/126356.html> (C2X 
has also deprecated those functions).  The comments in that thread 
supported marking the functions deprecated, but it needs someone to send a 
patch and I don't know what breakage might result in applications using 
those functions.

-- 
Joseph S. Myers
joseph@codesourcery.com
