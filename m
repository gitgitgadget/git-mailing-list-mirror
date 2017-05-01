Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0531B1F78F
	for <e@80x24.org>; Mon,  1 May 2017 14:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424445AbdEAOz1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 10:55:27 -0400
Received: from fallback10.m.smailru.net ([94.100.178.50]:60660 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1166007AbdEAOzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 10:55:24 -0400
X-Greylist: delayed 6623 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 May 2017 10:55:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From; bh=AW6OJiI2E8vfuXMjTFAauM64JbGT9kyWZdeU7Bjtt1w=;
        b=PZnhckb7oZHYKHr+WBrgh0mkHNePA4hryrO/hGtDhRG/qCGW2g5Rl3K1vuLY2g3HZW9uZAw6yD7hn14Ko9ffxkwBpxYgIShsuM5BFYLZc81YA3Pjzn1fKB513gpMLkB/67S2lDgrj78120ClSU2oATxZ2DKTvhpkfJuGIVJgS6M=;
Received: from [10.161.60.75] (port=46114 helo=f346.i.mail.ru)
        by fallback10.m.smailru.net with esmtp (envelope-from <fatemail@mail.ru>)
        id 1d5B0b-0002NI-SN
        for git@vger.kernel.org; Mon, 01 May 2017 16:04:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From; bh=AW6OJiI2E8vfuXMjTFAauM64JbGT9kyWZdeU7Bjtt1w=;
        b=PZnhckb7oZHYKHr+WBrgh0mkHNePA4hryrO/hGtDhRG/qCGW2g5Rl3K1vuLY2g3HZW9uZAw6yD7hn14Ko9ffxkwBpxYgIShsuM5BFYLZc81YA3Pjzn1fKB513gpMLkB/67S2lDgrj78120ClSU2oATxZ2DKTvhpkfJuGIVJgS6M=;
Received: by f346.i.mail.ru with local (envelope-from <fatemail@mail.ru>)
        id 1d5B0Y-0006aB-O8; Mon, 01 May 2017 16:04:54 +0300
Received: by e.mail.ru with HTTP;
        Mon, 01 May 2017 16:04:54 +0300
From:   =?UTF-8?B?TmlraXRhIE9ybG92?= <fatemail@mail.ru>
To:     =?UTF-8?B?S2V2aW4gRGF1ZHQ=?= <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: =?UTF-8?B?UmVbMl06IGdpdCBsb3NlcyBhIGNvbW1pdCBhZnRlciByZW9yZGVyaW5nLg==?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
Date:   Mon, 01 May 2017 16:04:54 +0300
Reply-To: =?UTF-8?B?TmlraXRhIE9ybG92?= <fatemail@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <1493643894.701604094@f346.i.mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-7FA49CB5: 0D63561A33F958A5E3AEBB75D5E49FEA52F2BB183B6BC3C58A3E7DBA4A6F6450725E5C173C3A84C376B12FEE68107A2B92190CC2D513758DC2546860BDEA057BC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F2AF38021CC9F462D574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: 44DC0583D106627AA556E9A109B2BFD8592E5067CE4202A33D235CB8AAC642C030795CA8E27087A080683B1EBFD6753FB1152D1B4D482D2298F48FF2F4DE4FBB41A61023B3127A56F291BAC6EE93304399D53F0D51A6ADE1B4A721A3011E896F
X-Mras: OK
X-Spam: undefined
In-Reply-To: <20170429225642.GA25902@alpha.vpn.ikke.info>
References: <1493278996.239768474@f402.i.mail.ru>
 <20170429225642.GA25902@alpha.vpn.ikke.info>
X-7FA49CB5: 0D63561A33F958A5A0A9FF26A1794B11E384E11437D6519D9D50F60BC2915965462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pk9uIFN1biwgMzAgQXByIDIwMTcsIDE6NTYgKzAzOjAwIGZyb20gS2V2aW4gRGF1ZHQgPG1lQGlr
a2UuaW5mbz46Cj5Ob3Qgc3VyZSBpZiB0aGlzIGlzIHRoZSBjYXNlIGhlcmUsIGJ1dCBpdCBhdCBs
ZWFzdCBjb25maXJtcyB0aGF0IHJlYmFzZQo+LS1wcmVzZXJ2ZS1tZXJnZXMgd2FzIG5vdCBtZWFu
dCB0byByZW9yZGVyIGNvbW1pdHMuCj4KPlNlZSBbdGhpc11bMV0gdGhyZWFkIGZvciBtb3JlIGJh
Y2tncm91bmQgb24gdGhpcyBsaW1pdGF0aW9uLgo+Cj5bMF06IGh0dHBzOi8vZ2l0LXNjbS5jb20v
ZG9jcy9naXQtcmViYXNlI19idWdzCj5bMV06IGh0dHBzOi8vcHVibGljLWluYm94Lm9yZy9naXQv
MW10dmV1NC4xOWx2Z2kxYzBobWhhTSUyNWxpc3RzQGhhbGxlci1iZXJsaW4uZGUvCgpUaGlzIGlz
IGl0LiBBcyBJIHVuZGVyc3RhbmQgZ2l0LXJlYmFzZS0taGVscGVyIGlzIGFuIGF0dGVtcHQgdG8g
Zml4IHRoZSBidWcuCkJ1dCBpdCdzIHN0aWxsIGluIGRldmVsb3BtZW50LCBpc24ndCBpdD8KCklz
IHRoZXJlIGEgc2ltcGxlL3RoZSByaWdodCB3YXkgaG93IHRvIGRvIHJlb3JkZXJpbmcgd2l0aG91
dCBsb3NpbmcKbWVyZ2UgY29tbWl0cyBub3c/IEUuZy4sIEkndmUgZG9uZSBpdCBieSBnaXQtY2hl
cnJ5LXBpY2sgZHVyaW5nIGludGVyYWN0aXZlIHJlYmFzaW5nLgoKVGhhbmtzLgoKLS0KTmlraXRh
IE9ybG92Cg==
