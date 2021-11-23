Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77676C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhKWB2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:28:41 -0500
Received: from zg8tmtm4lje5ny4xodqumjaa.icoremail.net ([138.197.184.20]:38193
        "HELO zg8tmtm4lje5ny4xodqumjaa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230017AbhKWB2l (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Nov 2021 20:28:41 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwCHT6zFQpxhCUy6CA--.22337S2;
        Tue, 23 Nov 2021 09:24:21 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Tue, 23 Nov 2021 09:25:26 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Tue, 23 Nov 2021 09:25:26 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Aleen <aleen42@vip.qq.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v10 1/2] doc: git-format-patch: describe the option
 --always
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <nycvar.QRO.7.76.6.2111221258440.63@tvgsbejvaqbjf.bet>
References: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
 <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
 <59bce7131dab858e8c87944ccb02eae8ba5fd459.1637567471.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2111221258440.63@tvgsbejvaqbjf.bet>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <683ecd80.13.17d4a65cf94.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgD300QGQ5xhLAIAAA--.42W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcOCFGCdOPsEAADs7
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrAF17Aw18Ww17GF15XFWkZwb_yoWxGFb_uF
        yak392kFyDZF47t3ZIgr45Zr15Jayq9FyrAw15Arn8Ja43Xan5CF1kZr93Gw4rX3yxKr98
        u3sIgasxZ34xujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBIaSBBbGVlbiwKPiAKPiBPbiBNb24sIDIyIE5vdiAyMDIxLCBBbGVlbiB2aWEgR2l0R2l0R2Fk
Z2V0IHdyb3RlOgo+IAo+ID4gRnJvbTogQWxlZW4gPGFsZWVuNDJAdmlwLnFxLmNvbT4KPiAKPiBG
V0lXIHRoaXMgaW5mb3JtYXRpb24gY29tZXMgZnJvbSB5b3VyIGNvbW1pdCwgc3BlY2lmaWNhbGx5
IGZyb20gdGhlCj4gYXV0aG9yIGluZm9ybWF0aW9uIHJlY29yZGVkIHdoZW4geW91IGNvbW1pdHRl
ZCBmaXJzdC4gVG8gcmUtc2V0IGl0IGluCj4gdGhlc2UgdHdvIHBhdGNoZXMsIHJ1biBzb21ldGhp
bmcgbGlrZSB0aGlzOgo+IAo+IAlnaXQgY29uZmlnIC0tZ2xvYmFsIHVzZXIubmFtZSAi5b6Q5rKb
5paHIChBbGVlbikiCj4gCWdpdCByZWJhc2UgLXggImdpdCBjb21taXQgLS1hbWVuZCAtLW5vLWVk
aXQgLS1yZXNldC1hdXRob3IiIEhFQUR+Mgo+IAo+IGFuZCB0aGVuIGZvcmNlLXB1c2ggdG8geW91
ciBicmFuY2guCj4gCj4gQ2lhbywKPiBEc2NobwoKVGhlIG1haW4gcHJvYmxlbSBpcyB0aGF0IGl0
IGJyb2tlIHdoZW4gSSB0cmllZCB0byBzdWJtaXQgdmlhIEdHRzoKaHR0cHM6Ly9naXRodWIuY29t
L2dpdGdpdGdhZGdldC9naXQvcHVsbC8xMDc2I2lzc3VlY29tbWVudC05NzYwODc0MjE=

