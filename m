Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C1E20437
	for <e@80x24.org>; Thu, 12 Oct 2017 08:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdJLI4J (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 04:56:09 -0400
Received: from mail96.atlas.de ([194.156.172.86]:55235 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdJLI4J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 04:56:09 -0400
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Oct 2017 04:56:08 EDT
X-IPAS-Result: =?us-ascii?q?A2C2AwBlK99Z/wXKxApdHAEBBAEBCgEBhVaDeqQIj3wKE4U?=
 =?us-ascii?q?oHIUPFAECAQEBAQEBAYEThR0BKRFXARkDAQIDAiYCBB8LBhUCAQUKBA0GAgEBi?=
 =?us-ascii?q?gIDqViCJ4dBDYNsMoEOgh+FbYVdgj41gkeCYQWKFpZwPIFtjgOQVYczjHuBCod?=
 =?us-ascii?q?ggTk2gS94XocddopsAQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 12 Oct 2017 10:45:32 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3yCPZ44D5kz2yWS3; Thu, 12 Oct 2017 08:45:20 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3yCPYr42ntz2yWS2
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 08:45:20 +0000 (UTC)
Received: from msexsrv1.atlas.de ([10.200.102.56])
  by MGW202DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Oct 2017 10:45:20 +0200
Received: from MSEXSRV5.atlas.de ([169.254.3.60]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0351.000; Thu, 12 Oct 2017 10:45:20
 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <git@vger.kernel.org>
Subject: Bug or feature: format-patch breaks long subject lines
Thread-Topic: Bug or feature: format-patch breaks long subject lines
Thread-Index: AQHTQzZuFoGZz2xm30WL6cr/TPSiRA==
Date:   Thu, 12 Oct 2017 08:45:19 +0000
Message-ID: <3405d79e-f7be-322c-615e-fd7d8987c0cf@atlas-elektronik.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Content-Type: text/plain; charset="utf-8"
Content-ID: <292462B41F072C42A824F265B91A244A@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gbGlzdCwNCg0KZ2l0IGZvcm1hdC1wYXRjaCBicmVha3MgKG9yIGJldHRlcjogd29yZC13
cmFwcykgbG9uZyBzdWJqZWN0IGxpbmVzLg0KDQpUaGlzIGlzIG9uIFdpbmRvd3MgNyB3aXRoDQoN
CiQgZ2l0IC0tdmVyc2lvbg0KZ2l0IHZlcnNpb24gMi4xNC4yLndpbmRvd3MuMg0KDQpSZXByb2R1
Y2Ugd2l0aCAoc29tZSBvdXRwdXQgb21pdHRlZCk6DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
JCBnaXQgaW5pdCB0ZXN0LWZvcm1hdC1wYXRjaA0KJCBjZCB0ZXN0LWZvcm1hdC1wYXRjaA0KJCB0
b3VjaCBmaWxlDQokIGdpdCBhZGQgZmlsZQ0KJCBnaXQgY29tbWl0IC1tIjAxMjM0NTY3ODkwMTIz
NDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODki
DQokIGdpdCBmb3JtYXQtcGF0Y2ggLTEgLS1zdGRvdXQNCkZyb20gZWM3MTFjY2EzMzBmMTAzMmQy
ODYxMTQ5MzJhOTA0ODg1NDJmMWRhMiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IFN0
ZWZhbiBOYWV3ZSA8c3RlZmFuLm5hZXdlQGdtYWlsLmNvbT4NCkRhdGU6IFRodSwgMTIgT2N0IDIw
MTcgMTA6MzY6NTIgKzAyMDANClN1YmplY3Q6IFtQQVRDSF0NCiAwMTIzNDU2Nzg5MDEyMzQ1Njc4
OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTIzNDU2Nzg5DQoNCi0t
LQ0KIGZpbGUgfCAwDQogMSBmaWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZmlsZQ0KDQpkaWZmIC0tZ2l0IGEvZmlsZSBiL2Zp
bGUNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5lNjlkZTI5DQotLQ0KMi4x
NC4yLndpbmRvd3MuMg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCklzIHRoaXMgdGhlIGV4cGVj
dGVkIGJlaGF2aW91cj8NCg0KVGhhbmtzLA0KICBTdGVmYW4NCi0tIA0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KL2Rldi9y
YW5kb20gc2F5czogSSBIYXZlIFRvIFN0b3AgTm93LCBNeSBGaW5nZXJzIEFyZSBHZXR0aW5nIEhv
YXJzZSENCnB5dGhvbiAtYyAicHJpbnQgJzczNzQ2NTY2NjE2ZTJlNmU2MTY1Nzc2NTQwNjE3NDZj
NjE3MzJkNjU2YzY1NmI3NDcyNmY2ZTY5NmIyZTYzNmY2ZCcuZGVjb2RlKCdoZXgnKSIgDQpHUEcg
S2V5IGZpbmdlcnByaW50ID0gMkRGNSBFMDFCIDA5QzMgNzUwMSBCQ0E5ICA5NjY2IDgyOUIgNDlD
NSA5MjIxIDI3QUY=
