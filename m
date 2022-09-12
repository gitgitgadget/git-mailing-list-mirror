Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16086C6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 10:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiILKCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiILKCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 06:02:19 -0400
X-Greylist: delayed 298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 03:02:16 PDT
Received: from mx.garz-fricke.com (mx.garz-fricke.com [213.23.127.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FF24BEF
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=garz-fricke.com; s=dkim-key-2022e; 
 t=1662976635; bh=gQveJL1gW3Gv7vCQAwrPBnyZZLjJ4/HuRagtNAoUJHE=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 A1zttUHmCpWbKX5d2GkJMQ7R+NovMZhq047PKNf7jT6hO8q9IA6tiECkQcaaOgIMxPh1gKRD906wrlKqL4fbBg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=garz-fricke.com; s=dkim-key-2022r; 
 t=1662976635; bh=gQveJL1gW3Gv7vCQAwrPBnyZZLjJ4/HuRagtNAoUJHE=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 d7aGfOoVc+1oWlJJCFVd6HyRTk7laoymg7v0dkCwvapOE1+XoFvvpgCRFYZvCyHEYMWyP0ctpuk0qBm+6HnzWO3HguKKa+uXT68u0cjnc4Wbw0zKhD7D8+Q+A4Q+a6qXM1Izn8eFXbl2jr+BNGAfItUcFWQPidhpZDtjaSYqUZkw8V8JhdXrDuO6W9w9M7VHJkD5c+8iO96b4YCsiVSEZX7j8tygWDuv45jYyJgzvkH1HNDiINW6GRIhe8MY0c0JDmAhPl3MB0Z3b3JRS3qVvzQod0CzOaEr/BfKkTj2rug8jKbWfBeOnwU/akiaGXhoNsZwQAoSPz7sZEwEjGK4Fw==
From:   Tim Jaacks <tim.jaacks@garz-fricke.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git diff ^! syntax stopped working for stashes in Git 2.28
Thread-Topic: git diff ^! syntax stopped working for stashes in Git 2.28
Thread-Index: AdjGjge3NTS/nWtpQ9qUvItMO6utFQ==
Date:   Mon, 12 Sep 2022 09:57:13 +0000
Message-ID: <6f729c8c43c4409faf6a11a69791f45a@garz-fricke.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: efe62198-f463-4660-b444-6761d68f1a00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sDQoNCkkgbm90aWNlZCB0aGF0IHRoZSBmb2xsb3dpbmcgc3ludGF4IHRvIHNob3cgdGhl
IGNoYW5nZXMgb2YgYSBzdGFzaCBzdG9wcGVkIHdvcmtpbmcgaW4gR2l0IDIuMjg6DQoNCiAgZ2l0
IGRpZmYgc3Rhc2hAezB9XiENCg0KSXQgc3RpbGwgd29ya3Mgb24gY29tbWl0cyBhbmQgSEVBRCwg
dGhvdWdoOg0KDQogIGdpdCBkaWZmIGYyNzk4NGReIQ0KICBnaXQgZGlmZiBIRUFEXiENCg0KQW5k
IGRpZmZpbmcgYWdhaW5zdCB0aGUgc3Rhc2gncyBwYXJlbnQgd29ya3MgYXMgd2VsbDoNCg0KICBn
aXQgZGlmZiBzdGFzaEB7MH1eMSBzdGFzaEB7MH0NCg0KSSBhc3N1bWUgdGhpcyBpcyBhIGJ1Zy4g
Q2FuIGFueWJvZHkgY29uZmlybSB0aGlzPyBJIHZlcmlmaWVkIHRoZSBiZWhhdmlvciBjaGFuZ2Ug
dHJ5aW5nIGRpZmZlcmVudCBHaXQgdmVyc2lvbnMgdmlhIGRvY2tlcjoNCg0KICBkb2NrZXIgcnVu
IC1pdCAtLXJtIC0tdXNlciAkKGlkIC11KTokKGlkIC1nKSAtdiAkSE9NRTokSE9NRTpydyAtdiAv
ZXRjL3Bhc3N3ZDovZXRjL3Bhc3N3ZDpybyAtdiAvZXRjL2dyb3VwOi9ldGMvZ3JvdXA6cm8gLXYg
JFBXRDokUFdEOnJ3IC13ICRQV0QgYml0bmFtaS9naXQ6Mi4yNy4wIGRpZmYgc3Rhc2hAezB9XiEN
Cg0KV2l0aCB2Mi4yNy4wIHRoZSBhYm92ZSBzeW50YXggd29ya3MsIHdpdGggdjIuMjguMCBhbmQg
bGF0ZXIgaXQgZG9lc24ndC4NCg0KS2luZCByZWdhcmRzLA0KVGltDQoNCi0tIA0KVGltIEphYWNr
cw0KU09GVFdBUkUgREVWRUxPUEVSDQpTRUNPIE5vcnRoZXJuIEV1cm9wZSBHbWJIDQoNClNjaGxh
Y2h0aG9mc3RyYXNzZSAyMA0KMjEwNzkgSGFtYnVyZw0KR2VybWFueQ0KVDogKzQ5IDQwIDc5MTg5
OS0xODMNCkU6IHRpbS5qYWFja3NAc2Vjby5jb20NCg0KUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IEhh
bWJ1cmcsIEhSQiAxNDg4OTMNClJlcHJlc2VudGVkIGJ5OiBEaXJrIEZpbnN0ZWwsIE1hcmMtTWlj
aGFlbCBCcmF1biwgTWFzc2ltbyBNYXVyaQ0KDQo=

