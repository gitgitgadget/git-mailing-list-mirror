Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DDF1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 22:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbcHFWhU (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 18:37:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:49564 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbcHFWhT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 18:37:19 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MRGPP-1bgAtw2FkV-00UZJa; Sat, 06 Aug 2016 10:38:19
 +0200
Date:	Sat, 6 Aug 2016 10:38:16 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Philip Oakley <philipoakley@iee.org>
cc:	Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <FAE9116880074D6FA421942CCAEC368F@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1608061036270.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CACsJy8Bzcwfvhc9dQ2EehmAJ+kGwC5VHL4d+4Z-GfmM6e2+3wg@mail.gmail.com> <FAE9116880074D6FA421942CCAEC368F@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iJfyHNBlnj7aeK6S+VZpa7FuXf8mcKi/liKq5QLcNgx4Cmy21uk
 VoXxp/M0nEtUos6CCwTkDDkl5GvRL//BWJx73XoUnEBn+EvCn5y+5kLgZ8n3oRTs+J4T1bR
 /LmLYBOPCp4Xt3DEgx8zio0TOzlcOgsLiVhZ5fSS7ASApj9B2NiZXf4e0jlfGaqQM5D/c9O
 jZfpIE/aTOiOSebU8sKJg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:hRiG58C5B9c=:xIwzsB928g7GgSCeJVjhpf
 kOCCd6AQfgZgAWWhjStPmiOpgeHHxzhYh8U3hEPsjww0CQ41hLCtWwHXRnZsidLxlb2AgX8hD
 vqx2OEmsjPDSdblfj9wNUd4hqp+Sur1Hw6ddaWrmVTVu2wFl/Nu5GJtk+qTaIsI81iQWpqnPH
 F9/yz28diR0vwfQb6DwjgtAddLgpqycaF4b4x5cOqve2tUeZExjo1GwnQKqGupbEGsiy2H7qX
 8s1+fyGsZTJ0QHJHQT++Z9BN5wWEuOIIUsj4001cI95dVGt0Dw/OGqAkviWkP8zax7MBfs+C0
 mctsw6v11++XjuAUdbFPuVq3bFycDr6n5cpXDogIICSJTy32/5Pb/OyiS/I3sqNYEzPByP9//
 ATECz6T6fy2EWXxfgm5k9r6BhyWhyeNUh7+WSdwHLBJPBQQ+yJ1xgjcUufwpT+crn0ninw3IE
 j/N/bHfPdGsMHkiYXMA75ME3awesGvdixDVHMmo+uxNrnE8FtXVFqmAV81+QA6CBbEAPd2GE6
 CNhGkkVWxkVgj9WQ5HXZhNnWiTSBOV0wez3L0IMGUkDa2/h+BPczJRH2BztvwovLufnSmhx9O
 X4k/DnqBaiLW1KDoESfTk/MIBRcPc1SddqTNHUON9GFtX6PXnxFzJYP+h0zv45YLTqws7BH0q
 cVOHwNvMqyu7cUj8EoJJTAgK7aaO/SWRGz4OUxm1dgXffQ61eO/lff3pOjDth1TGbuwRrCwn5
 Eoenb61iVngsGYYEbbPFGRspjrHhl0cFgSIikWpEfgTzf60M75U7LaGUtM1cQqZHbvIN84RD8
 IzvkfTL
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Philip,

On Fri, 5 Aug 2016, Philip Oakley wrote:

> In the same vein, I always want,with my workflow, to use "fixup!
> <short_sha1>".

Good news for you: this is already supported. See here:

https://github.com/git/git/blob/v2.9.2/git-rebase--interactive.sh#L786-L796

Ciao,
Dscho
