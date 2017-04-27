Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC9A207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 08:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937626AbdD0IYQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 04:24:16 -0400
Received: from fallback15.m.smailru.net ([94.100.179.50]:39128 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934383AbdD0IYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 04:24:09 -0400
X-Greylist: delayed 2441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Apr 2017 04:24:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:To:From; bh=jj8EsuVQ41FbuDgdA3TEkFUg+RqPP4YcHl755QFWkrI=;
        b=PK5h21SkNw2GnzW454NRqIdhTDYuhb5eJex4zUspz6Tj/54VndRy4FUxIKE0eWclLplgl3a/iT+kF/DFgB/rgpp+n2++EplokuDDaL+nIhen38NFpcTeNDp5IN01KsEtc5LzIyyo5Hmlhw+pO5ksOY/pdR0paphOEsSwlBAMdbw=;
Received: from [10.161.63.25] (port=45090 helo=f402.i.mail.ru)
        by fallback15.m.smailru.net with esmtp (envelope-from <fatemail@mail.ru>)
        id 1d3e5E-0004Tg-0o
        for git@vger.kernel.org; Thu, 27 Apr 2017 10:43:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:To:From; bh=jj8EsuVQ41FbuDgdA3TEkFUg+RqPP4YcHl755QFWkrI=;
        b=PK5h21SkNw2GnzW454NRqIdhTDYuhb5eJex4zUspz6Tj/54VndRy4FUxIKE0eWclLplgl3a/iT+kF/DFgB/rgpp+n2++EplokuDDaL+nIhen38NFpcTeNDp5IN01KsEtc5LzIyyo5Hmlhw+pO5ksOY/pdR0paphOEsSwlBAMdbw=;
Received: by f402.i.mail.ru with local (envelope-from <fatemail@mail.ru>)
        id 1d3e56-0008NV-VD
        for git@vger.kernel.org; Thu, 27 Apr 2017 10:43:17 +0300
Received: by e.mail.ru with HTTP;
        Thu, 27 Apr 2017 10:43:16 +0300
From:   =?UTF-8?B?TmlraXRhIE9ybG92?= <fatemail@mail.ru>
To:     git@vger.kernel.org
Subject: =?UTF-8?B?Z2l0IGxvc2VzIGEgY29tbWl0IGFmdGVyIHJlb3JkZXJpbmcu?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
Date:   Thu, 27 Apr 2017 10:43:16 +0300
Reply-To: =?UTF-8?B?TmlraXRhIE9ybG92?= <fatemail@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <1493278996.239768474@f402.i.mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-7FA49CB5: 0D63561A33F958A5C96D20351BD09DB888637F543DE7B7CEAD6BCC8F775474CA725E5C173C3A84C3FFCBA205665D830A31599A29F601418B26B9191E2D567F0EC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F2AF38021CC9F462D574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: CC47F90F31E6EBC2D6EA5BB8262986BE9AB3DF8FB794258DFC09AB2512FAECA61D0473EF4C5A87F280683B1EBFD6753FB1152D1B4D482D2298F48FF2F4DE4FBB41A61023B3127A56F291BAC6EE93304399D53F0D51A6ADE1B4A721A3011E896F
X-Mras: OK
X-Spam: undefined
X-7FA49CB5: 0D63561A33F958A552019A6B30D70642821AC8E5B3AA5B2DFFE7B80E09006C92462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sIG15IG5hbWUgaXMgTmlraXRhIChtYWxlKS4KCkNvdWxkIHlvdSBleHBsYWluIHRoaXMg
KHN1YmplY3QpIGlzIGEgYnVnIG9yIGEgZmVhdHVyZT8KCkkgZm9sbG93IFBybyBHaXQgUmVvcmRl
cmluZyBDb21taXRzIChodHRwczovL2dpdC1zY20uY29tL2Jvb2svZW4vdjIvR2l0LVRvb2xzLVJl
d3JpdGluZy1IaXN0b3J5KSB0byByZW9yZGVyIGNvbW1pdHMgYW5kIGxvc2Ugb25lIHdpdGhvdXQg
YW55IGNvbmZsaWN0LgoKSSd2ZSBnb3QgZ2l0IHVuZGVyIFdpbmRvd3MgMTAgRW50ZXJwcmlzZSA2
NC1iaXQgaW5zdGFsbGVkIHRocm91Z2ggQ2hvY29sYXRleS4KCj4gY2hvY28gbGlzdCAtbCBnaXQK
Q2hvY29sYXRleSB2MC4xMC41CmNob2NvbGF0ZXkgMC4xMC41CmdpdCAyLjEyLjIuMgpnaXRwYWQg
MS4yCm1zeXNnaXQgMS43LjEwLjIwMTIwNTI2CjQgcGFja2FnZXMgaW5zdGFsbGVkLgoKJCBnaXQg
LS12ZXJzaW9uCmdpdCB2ZXJzaW9uIDIuMTIuMi53aW5kb3dzLjEKCkV4YW1wbGUuCgpUaGVyZSBh
cmUgdHdvIGJyYW5jaGVzOgotIG1hc3RlcgotIGZlYXR1cmUtYnJhbmNoCgpmZWF0dXJlLWJyYW5j
aCBpcyBvbiBtYXN0ZXIuCgpNeVBDIE1JTkdXNjQgL3BhdGgvdG8vcmVwb3NpdG9yeSAoZmVhdHVy
ZS1icmFuY2gpCgokIGdpdCBsb2cgLTkgLS1vbmVsaW5lCjUwNDVkMWVjYSBNZXJnZSBicmFuY2gg
J2ZlYXR1cmUtMycgaW50byAnZmVhdHVyZS1icmFuY2gnCjAwNmZjNTQ5ZCBEb25lIFRhc2sgMwph
MmE1MjQ0MWUgTWVyZ2UgYnJhbmNoICdmZWF0dXJlLTInIGludG8gJ2ZlYXR1cmUtYnJhbmNoJwpl
NzM1MjcxMTUgRG9uZSBUYXNrIDIKZjA0NTQ2ODVlIE1lcmdlIGJyYW5jaCAnZmVhdHVyZS0xJyBp
bnRvICdmZWF0dXJlLWJyYW5jaCcKM2FiODJlNGM2IERvbmUgVGFzayAxCmYxNTAzN2Q2NCBTb21l
IGluZGVwZW5kZW50IGNoYW5nZXMgMgpjYmEzZWJiNGUgU29tZSBpbmRlcGVuZGVudCBjaGFuZ2Vz
IDEKYmMxOTQ3M2NmIEhlYWQgb2YgbWFzdGVyCgokIGdpdCByZWJhc2UgLWkgLXAgbWFzdGVyCgpJ
IGNoYW5nZSB0aGUgcmViYXNlIHNjcmlwdCBmcm9tOgoKcGljayBjYmEzZWJiNGUgU29tZSBpbmRl
cGVuZGVudCBjaGFuZ2VzIDEKcGljayBmMTUwMzdkNjQgU29tZSBpbmRlcGVuZGVudCBjaGFuZ2Vz
IDIKcGljayAzYWI4MmU0YzYgRG9uZSBUYXNrIDEKcGljayBmMDQ1NDY4NWUgTWVyZ2UgYnJhbmNo
ICdmZWF0dXJlLTEnIGludG8gJ2ZlYXR1cmUtYnJhbmNoJwpwaWNrIGU3MzUyNzExNSBEb25lIFRh
c2sgMgpwaWNrIGEyYTUyNDQxZSBNZXJnZSBicmFuY2ggJ2ZlYXR1cmUtMicgaW50byAnZmVhdHVy
ZS1icmFuY2gnCnBpY2sgMDA2ZmM1NDlkIERvbmUgVGFzayAzCnBpY2sgNTA0NWQxZWNhIE1lcmdl
IGJyYW5jaCAnZmVhdHVyZS0zJyBpbnRvICdmZWF0dXJlLWJyYW5jaCcKCnRvOgoKcGljayBmMTUw
MzdkNjQgU29tZSBpbmRlcGVuZGVudCBjaGFuZ2VzIDIKcGljayBjYmEzZWJiNGUgU29tZSBpbmRl
cGVuZGVudCBjaGFuZ2VzIDEKcGljayAzYWI4MmU0YzYgRG9uZSBUYXNrIDEKcGljayBmMDQ1NDY4
NWUgTWVyZ2UgYnJhbmNoICdmZWF0dXJlLTEnIGludG8gJ2ZlYXR1cmUtYnJhbmNoJwpwaWNrIGU3
MzUyNzExNSBEb25lIFRhc2sgMgpwaWNrIGEyYTUyNDQxZSBNZXJnZSBicmFuY2ggJ2ZlYXR1cmUt
MicgaW50byAnZmVhdHVyZS1icmFuY2gnCnBpY2sgMDA2ZmM1NDlkIERvbmUgVGFzayAzCnBpY2sg
NTA0NWQxZWNhIE1lcmdlIGJyYW5jaCAnZmVhdHVyZS0zJyBpbnRvICdmZWF0dXJlLWJyYW5jaCcK
Ck5vIGFueSBjb25mbGljdCBhbmQgSSBzZWU6ClN1Y2Nlc3NmdWxseSByZWJhc2VkIGFuZCB1cGRh
dGVkIHJlZnMvaGVhZHMvZmVhdHVyZS1icmFuY2guCgokIGdpdCBsb2cgLTkgLS1vbmVsaW5lCjQ3
ZTU3OWNlMCBNZXJnZSBicmFuY2ggJ2ZlYXR1cmUtMycgaW50byAnZmVhdHVyZS1icmFuY2gnCmE3
YzZiOGI4ZSBEb25lIFRhc2sgMwo1ZGY3Y2UxMDUgTWVyZ2UgYnJhbmNoICdmZWF0dXJlLTInIGlu
dG8gJ2ZlYXR1cmUtYnJhbmNoJwowMTk3Nzk3ZDcgRG9uZSBUYXNrIDIKZTY4MDQ4OGZlIE1lcmdl
IGJyYW5jaCAnZmVhdHVyZS0xJyBpbnRvICdmZWF0dXJlLWJyYW5jaCcKNzMxYTU3NTgwIERvbmUg
VGFzayAxCjEwZGE5Y2Q4NSBTb21lIGluZGVwZW5kZW50IGNoYW5nZXMgMgpiYzE5NDczY2YgSGVh
ZCBvZiBtYXN0ZXIKZDkxOTQ3YWJkIENvbW1pdCB1bmRlciB0aGUgaGVhZCBvZiBtYXN0ZXIKCiJT
b21lIGluZGVwZW5kZW50IGNoYW5nZXMgMSIgaXMgbWlzc2VkIGFuZCBpdHMgY2hhbmdlcyBhcmUg
bWlzc2VkIGFzIHdlbGwuCgpJIHRyaWVkIHRvIG1vdmUgYW5vdGhlciBjb21taXQgdG8gYSBmYXJ0
aGVyIGRpc3RhbmNlIGJlbG93IGJ1dCB0aGVyZSB3YXMgc3RpbGwgb25seSBvbmUgbWlzc2VkIGNv
bW1pdC4KCkNvdWxkIHlvdSBleHBsYWluIGl0PwoKVGhhbmsgeW91IGluIGFkdmFuY2UgYW5kIHNv
cnJ5IGZvciBteSBFbmdsaXNoLgoKQmVzdCwgTmlraXRhCg==
