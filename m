Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB02E1F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 07:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfH3HTS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 03:19:18 -0400
Received: from eml2-img03-day.reyrey.com ([206.180.2.13]:11525 "EHLO
        eml2-img03-day.reyrey.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfH3HTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 03:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=reyrey.com; i=@reyrey.com; q=dns/txt; s=reyrey.com;
  t=1567149556; x=1598685556;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eAo6aPIMELDDwTWoP+CkePMa2TOHxZGRE2QnLVuiSP4=;
  b=JMYtB1d5zXnE0vYv9/YFw6/c2F8NbhctBCPwxjB9JaDKzADIazNNIS0w
   fUgF/MQVI1eMaJyuDgs66XpMPp3fkP03MHnx4CA/mzb5jGMyAKxrejBuY
   6aD6MWo05c3zCBKMZsJDEp2GSJvpBtWOCBLK5r07HhSnZk6VA8K7pNQGg
   k=;
IronPort-SDR: NVi+WoQyXKSw4lA97y4BTsB8FGb051O7Mgh8mxFiP6j6yub7jqS2J0UzABsZJ06CjB7k1ypWP/
 7hkyGvHHQrNe62gxrxa3uAUmgcMWj7e+aRP2UbJb1jgEIFEa44Wf5jmcrZwqb/eE54Ndk/DAqL
 RaWkj1HfGgwUDMVeDxOezpwUvgYddYMSxacxvFBvFoDm0gmvcpOH5jp/yYao4MXwOpedt8jRCt
 u3jLcVk7p1N/U/5X3zoZ/opVSQZVoexLK6bPKNRdMQthnQbkOCtmR4E7IS2ZhwMYGcWO+AYyU/
 Cnw=
X-CrossPremisesHeadersFilteredBySendConnector: EML-MBX09-DAY.ad.reyrey.com
From:   "van den Berg, Kasper" <Kasper_vandenBerg@reyrey.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git range-diff <range1> <range2> throws Segmentation fault
Thread-Topic: git range-diff <range1> <range2> throws Segmentation fault
Thread-Index: AdVe/Yxl4Q1g4P2RTlmn5jhPmEBLHw==
Date:   Fri, 30 Aug 2019 07:19:14 +0000
Message-ID: <6802cf61dcbf438cb2e01cd390c57390@EML-MBX11-DAY.ad.reyrey.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.95.6.35]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OrganizationHeadersPreserved: EML-MBX09-DAY.ad.reyrey.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sDQoNCmBnaXQgcmFuZ2UtZGlmZiA8cmFuZ2UxPiA8cmFuZ2UyPmAgcHJpbnRzICJzZWdt
ZW50YXRpb24gZmF1bHQiIHRvIHRoZSBjb25zb2xlIGFuZCBub3RoaW5nIGVsc2UuICBJdCBoYXBw
ZW5zIGluIGdpdCB2ZXJzaW9uIDIuMjMuMC53aW5kb3dzLjEgYW5kIG9ubHkgb2NjdXJzIGZvciBz
b21lIGJyYW5jaGVzIGluIG15IHJlcG9zaXRvcnkuICBJIGhhdmUgbm90IGV4YWN0bHkgZGV0ZXJt
aW5lZCB3aGVuIGl0IGRvZXMgaGFwcGVuIGFuZCB3aGVuIGl0IGRvZXMgbm90IChJJ20gbm90IGZh
bWlsaWFyIHdpdGggZ2l0J3MgY29kZWJhc2UpLiAgVGhlc2UgYXJlIG15IHJlc3VsdHM6DQoNClN0
YXR1cwlWZXJzaW9uCQkJQ29uZmlnCQkJCQkJCQkJCQkJUmVzdWx0DQrinJgJMi4yMy4wLndpbmRv
d3MuMQk2NC1iaXQsIGxvY2FsCQkJCQkJCQkJCQlTZWdtZW50YXRpb24gZmF1bHQNCuKcmAkyLjIz
LjAud2luZG93cy4xCTY0LWJpdCwgbG9jYWwsIGRpZmZlcmVudCByYW5nZXMgcmVsYXRlZCB0byBt
eSBjdXJyZW50IHdvcmsJCQkJCVNlZ21lbnRhdGlvbiBmYXVsdA0K4pyUCTIuMjMuMC53aW5kb3dz
LjEJNjQtYml0LCBsb2NhbCwgZGlmZmVyZW50IHJhbmdlcyBjb21wbGV0ZWx5IGRpZmZlcmVudCBm
cm9tIG15IGN1cnJlbnQgd29yawkJCUV4cGVjdGVkIHJhbmdlLWRpZmYgb3V0cHV0DQrinJgJMi4y
My4wLndpbmRvd3MuMQlSZW1vdGUgY29ubmVjdGlvbiB0byBzYW1lIHdvcmtkaXIJCQkJCQkJCVNl
Z21lbnRhdGlvbiBmYXVsdA0K4pyUCTIuMjMuMC53aW5kb3dzLjEJNjQtYml0LCBsb2NhbCwgZnJl
c2ggY2xvbmUsIGRpZmZlcmVudCByYW5nZXMgY29tcGxldGVseSBkaWZmZXJlbnQgZnJvbSBteSBj
dXJyZW50IHdvcmsJRXhwZWN0ZWQgcmFuZ2UtZGlmZiBvdXRwdXQNCuKcmAkyLjIzLjAud2luZG93
cy4xCTMyLWJpdCwgbG9jYWwJCQkJCQkJCQkJCVNlZ21lbnRhdGlvbiBmYXVsdA0K4pyUCTIuMjEu
MC53aW5kb3dzLjEJNjQtYml0LCBsb2NhbAkJCQkJCQkJCQkJRXhwZWN0ZWQgcmFuZ2UtZGlmZiBv
dXRwdXQNCuKclAkyLjIxLjAud2luZG93cy4xCTY0LWJpdCwgcmVtb3RlY29ubmVjdGlvbiB0byBz
YW1lIHdvcmtkaXIJCQkJCQkJRXhwZWN0ZWQgcmFuZ2UtZGlmZiBvdXRwdXQNCg0KQm90aCA8cmFu
Z2UxPiBhbmQgPHJhbmdlMj4gY29tcHJpc2UgYmV0d2VlbiAyMTMgYW5kIDI3MCBjb21taXRzOyBn
aXQgZ2MgY291bnRzIDE0MDM5NCBvYmplY3RzIChUb3RhbCAxNDAzOTQgKGRlbHRhIDExMDYzOCks
IHJldXNlZCAxMzcyNzUgKGRlbHRhIDEwNzc5OSkpLiAgSSBoYXZlIG5vdCBwcmVzZXJ2ZWQgdGhl
IG9mZmVuZGluZyBicmFuY2ggbmFtZXMuICBIb3dldmVyLCB0aGV5IGNvbnRhaW4gMiBvciBtb3Jl
IHNsYXNoZXMgYW5kIHBlcmhhcHMgYW4gYXQtc2lnbiAoZS5nLiAnZmVhdHVyZS8nPGZlYXR1cmVu
YW1lPiwgJ3RtcC9vbGRAeyc8aT4nfS9mZWF0dXJlLyc8ZmVhdHVyZW5hbWU+LCAnZGV2ZWxvcCcs
IGFuZCAndG1wL3Byb2plY3QtYmFzZScpLg0KDQpUbyBhdm9pZCB0aGUgcHJvYmxlbSBJIHJldHVy
bmVkIHRvIHVzaW5nIGdpdCB2ZXJzaW9uIDIuMjEuMC53aW5kb3dzLjENCg0KSSB0aGVyZSBzb21l
dGhpbmcgSSBzaG91bGQgdGFrZSBpbnRvIGFjY291bnQgd2hlbiBkb2luZyBgZ2l0IHJhbmdlLWRp
ZmZgIG9uIGEgd29ya2RpciBvciBvbiBhIHJhbmdlcyBvZiBjb21taXRzPyAgV2hhdCB0aGluZ3Mg
c2hvdWxkIEkgbG9vayBmb3I/ICBIb3cgY2FuIEkgcmVwYWlyIHRoZSBicm9rZW4gcmFuZ2VzPyAg
V2h5IGRvZXMgdmVyc2lvbiAyLjIxLjAud2luZG93cy4xIHdvcmsgd2hpbGUgdmVyc2lvbiAyLjIz
LjAud2luZG93cy4xIGRvZXMgbm90Pw0KDQpXaXRoIGtpbmQgcmVnYXJkcywNCkthc3BlciB2YW4g
ZGVuIEJlcmcNCg==
