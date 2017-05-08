Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5473C1FDEA
	for <e@80x24.org>; Mon,  8 May 2017 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbdEHLRC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 07:17:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:51759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbdEHLRB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 07:17:01 -0400
Received: from virtualbox ([95.208.59.245]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8eAd-1duxOj1nnv-00wH89; Mon, 08
 May 2017 13:16:58 +0200
Date:   Mon, 8 May 2017 13:16:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Prathamesh Chavan <pc44800@gmail.com>
cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC] Project Selected: Incremental rewrite of git-submodules
In-Reply-To: <CAME+mvXtA6iZNfErTX5tYB-o-5xa1yesAG5h=iP_Z2_zL_kOnQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705081316220.146734@virtualbox>
References: <CAME+mvXtA6iZNfErTX5tYB-o-5xa1yesAG5h=iP_Z2_zL_kOnQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2yCcJzE/ZAykKzOEsieG2NvCZLkYArfwBRXovYdZ/i0LhukJVP5
 apFkWaXTFUTIUBaJkSPY9qPQ3JRyd+eFrfqGIqlYPWtdwNFcMaZYMKAo1Cmta8Uu8DUDwq6
 +JpIuXV/Um1+SrQneh0NCAptUoKUMlTrj9bBvbH0J4ig0lKdaXKEtvHd8Z/fAQacmhHCOf1
 lldRGnLLNszbGes+zn1CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3tXiW/eTIEE=:DnZEt6AMeEt+4tPDjHr5lO
 8qT/X4Qt1LqkXSxAjvAfgCxm+ARDA7HvdXuBjoopIPQl+J/Uxgd1vTHCKMcChtyqbM7ike1rW
 4r/SIJdwnly1jQk9ZagNRCiqPN2O6lruhfxgaJsP7uwxmnFbOkzhUa3EuVtUGZ2PlejWV1lzU
 ES4D8VbfrIw2UnyZQqIMvWn051p4wNa8Gc/gqwCa3ZJDtU5xNww2Qnwcy3Af2FrKoRQxZ7464
 JJ3jYMGzuBS4FuME6RAuh4TRYsXFl/E+039aa+r3C0CEHRpJAtw5H0OgLv58nqx5kK/c9K908
 ioxVFgbCeNk2gEjMw8gfgJXM0/I75q9xpmvzZJ20vikdqwMAAVkQMsECG4g4HuJo8XpFWI67g
 vBBnMtvsNs/X7pGY8lT2UMolG7aqfUdIzVYqFKJ0gvSSNyrNCSHjt3WMgMbtCBoEW5pTcq9cs
 Oor3VO5yiL13TDswav63sHIHkoVNWUE3NqqDPitEpIrhIPjhWzTTYoPjpsV7as+wLPotkM7e9
 6Mzx628gjfr5g/DkfgFCBWO8WWnD0M96yrIoTpjZ+G3wesYme9v/D9Xdkb1p5Zpwi8x7dLvz4
 G9LG5RFUiprQ8Txn/arzsebnhd90OxtNsXUgIFJZwUn2zHwxlcnp660pTRIJFKuu7rV4nrgNW
 ts36YrGwpthYqZz4xD1tffGE94ETahDTX8TXDXomXZZF7bytVReg3M5jdnpKwI7ZNpkHGudIg
 sJzD1VdWbvyIML3QnY18ttSAJ3znIMlkUgoxKQM5FiH2sIxCIkGlUrXvgKGl4MicVvjfsEeFT
 uLffxBO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 May 2017, Prathamesh Chavan wrote:

> I am Prathamesh Chavan, an undergraduate student from the department
> of Computer Science and Engineering, at Indian Institue of Technology,
> Kharagpur. I applied for Google Summer of Code 2017 and my project
> "Incremental rewrite of git-submodules" has been selected.
> This project will be done under the guidance of the mentors:
> Stefan Beller and Christian Couder.
> 
> [...]

Welcome! Glad to see you here, and looking forward to your contributions.

Ciao,
Johannes
