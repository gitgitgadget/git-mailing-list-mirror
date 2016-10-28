Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44EA12035F
	for <e@80x24.org>; Fri, 28 Oct 2016 20:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761924AbcJ1Ul0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 16:41:26 -0400
Received: from ns3.impromed.com ([74.62.95.114]:34023 "EHLO ns3.impromed.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761920AbcJ1UlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 16:41:25 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Oct 2016 16:41:25 EDT
X-HSAH-MailScanner-Watermark: 1478118669.85111@DpQLejGrQ5DcPTBKWtm5mw
X-HSAH-MailScanner-To: git@vger.kernel.org
X-HSAH-MailScanner-From: srchamberlain@impromed.com
X-HSAH-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-11,
        required 5, autolearn=not spam, ALL_TRUSTED -1.00, BAYES_00 -10.00)
X-HSAH-MailScanner: Found to be clean
X-HSAH-MailScanner-ID: u9SKV41H127293
X-HSAH-MailScanner-Information: This email has been scanned by ImproMed-LLC 
 a Henry Schein Animal Health company
Received: from ex.impromed.com (cas4.impromed.com [10.13.88.155])
        by ns3.impromed.com (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id u9SKV41H127293
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 15:31:08 -0500
Received: from ES4.impromed.com (10.13.88.64) by ES4.impromed.com
 (10.13.88.64) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 28 Oct
 2016 15:31:02 -0500
Received: from ES4.impromed.com ([fe80::1d86:6fd8:634a:86d4]) by
 ES4.impromed.com ([fe80::1d86:6fd8:634a:86d4%12]) with mapi id
 15.00.1210.000; Fri, 28 Oct 2016 15:31:02 -0500
From:   "Scott R. Chamberlain" <srchamberlain@impromed.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Can't get git to stop outputting to StdErr
Thread-Topic: Can't get git to stop outputting to StdErr
Thread-Index: AdIxWdLXUBgGGNakQFmM5BW2VpA8Dg==
Date:   Fri, 28 Oct 2016 20:31:02 +0000
Message-ID: <c09d32d8ab97418d98ddf356e20a6ff5@ES4.impromed.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.13.90.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBhbSB3b3JraW5nIG9uIHNvbWUgYnVpbGQgc2NyaXB0cyB0aGF0IGdldCBy
dW4gb24gVEZTLiBEdXJpbmcgdGhlIGJ1aWxkIHByb2Nlc3MgSSBuZWVkIHRv
IGNoZWNrIGluIHRoZSBjaGFuZ2VzIHRoYXQgd2hlcmUgZG9uZSBkdXJpbmcg
dGhlIGJ1aWxkIHByb2Nlc3MgKEEgc2V0IG9mIGJpbmFyaWVzIG90aGVyIHBy
b2plY3RzIGRlcGVuZCBvbikuDQoNCkkgd291bGQgcmVhbGx5IGxpa2UgdG8g
bGVhdmUgdGhlIG9wdGlvbiAiRmFpbCBvbiBTdGFuZGFyZCBFcnJvciIgZW5h
YmxlZCBmb3IgdGhlIHNjcmlwdCBpbiBURlMsIGhvd2V2ZXIgbXkgcHVzaCBr
ZWVwcyB3cml0aW5nIHRvIHN0YW5kYXJkIGVycm9yIGV2ZW4gdGhvdWdoIEkg
dG9sZCBpdCBub3QgdG8uDQoNClRoZSBsaW5lIEkgZG8gaXM6DQoNCiAgICBn
aXQgcHVzaCAtcSBiaW5hcnlSZXBvIEhFQUQ6IiRFbnY6QlVJTERfU09VUkNF
QlJBTkNIIg0KDQpCdXQgSSBnZXQgdGhlIGZvbGxvd2luZyBpbiBteSBsb2cg
YWZ0ZXIgdGhlIGJ1aWxkDQoNCiAgICAyMDE2LTEwLTI4VDIwOjA1OjMyLjMx
Nzk0NDJaICMjW2Vycm9yXXJlbW90ZTogDQogICAgcmVtb3RlOiBBbmFseXpp
bmcgb2JqZWN0cy4uLiAoMy8zKSAoNjU3IG1zKSAgICAgICAgDQogICAgcmVt
b3RlOiBTdG9yaW5nIHBhY2tmaWxlLi4uIGRvbmUgKDQwIG1zKSAgICAgICAg
DQogICAgcmVtb3RlOiBTdG9yaW5nIGluZGV4Li4uIGRvbmUgKDQyIG1zKSAg
ICAgICAgDQogICAgDQogICAgMjAxNi0xMC0yOFQyMDowNTozMi4zMjA5NDIz
WiBEb25lDQogICAgMjAxNi0xMC0yOFQyMDowNTozMi40MDE5NDM2WiAjI1tl
cnJvcl1Qcm9jZXNzIGNvbXBsZXRlZCB3aXRoIGV4aXQgY29kZSAwIGFuZCBo
YWQgMSBlcnJvcihzKSB3cml0dGVuIHRvIHRoZSBlcnJvciBzdHJlYW0uDQog
ICAgMjAxNi0xMC0yOFQyMDowNTozMi40MDI5NDM2WiAjI1tkZWJ1Z11TeXN0
ZW0uRXhjZXB0aW9uOiBQcm9jZXNzIGNvbXBsZXRlZCB3aXRoIGV4aXQgY29k
ZSAwIGFuZCBoYWQgMSBlcnJvcihzKSB3cml0dGVuIHRvIHRoZSBlcnJvciBz
dHJlYW0uDQoNCldoeSBhbSBJIHN0aWxsIGdldHRpbmcgb3V0cHV0IHRvIHN0
YW5kYXJkIGVycm9yIHdoZW4gSSBpbmNsdWRlZCB0aGUgYC1xYCBzd2l0Y2g/
DQoNCkZvciByZWZlcmVuY2UsIGBnaXQgdmVyc2lvbmAgcmVwb3J0cyBgMi4x
MC4wLndpbmRvd3MuMWAgYW5kIEhFQUQgaXMgYSBkZXRhY2hlZCBIRUFELg0K
DQoNClNjb3R0IENoYW1iZXJsYWluDQpTb2Z0d2FyZSBFbmdpbmVlciANCklt
cHJvTWVkLCBMTEMNCg0KDQoKLS0gClJlbHkgT24gVXMuCkltcHJvTWVkIExM
QwpIZW5yeSBTY2hlaW4gQW5pbWFsIEhlYWx0aAotLQoK
