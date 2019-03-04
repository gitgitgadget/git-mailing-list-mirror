Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CEA20248
	for <e@80x24.org>; Mon,  4 Mar 2019 07:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDHaq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 02:30:46 -0500
Received: from smtp63.cstnet.cn ([159.226.251.63]:45547 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfCDHaq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 02:30:46 -0500
Received: by ajax-webmail-APP-17 (Coremail) ; Mon, 4 Mar 2019 15:30:34 +0800
 (GMT+08:00)
X-Originating-IP: [114.255.44.140]
Date:   Mon, 4 Mar 2019 15:30:34 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     git@vger.kernel.org
Cc:     wanghui@bwstor.com.cn
Subject: Re: Git log print commits between a revision range (inclusive)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.5 build 20161025(89512.9021)
 Copyright (c) 2002-2019 www.mailtech.cn cstnet
In-Reply-To: <62307e7b.399f4.169479a611e.Coremail.wuzhouhui14@mails.ucas.ac.cn>
References: <62307e7b.399f4.169479a611e.Coremail.wuzhouhui14@mails.ucas.ac.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <762fc5a4.39a30.169479c8834.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 1wCowACnzCIc1HxcCLMYAA--.46722W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiCAkTAVlo-Kk-YQ
        AAsp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiB3dXpob3VodWkgPHd1emhvdWh1
aTE0QG1haWxzLnVjYXMuYWMuY24+Cj4gU2VudCBUaW1lOiAyMDE5LTAzLTA0IDE1OjI4OjEzIChN
b25kYXkpCj4gVG86IGdpdEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogCj4gU3ViamVjdDogR2l0IGxv
ZyBwcmludCBjb21taXRzIGJldHdlZW4gYSByZXZpc2lvbiByYW5nZSAoaW5jbHVzaXZlKQo+IAo+
IEhpLAo+IAo+IEkgd2FudCB0byBrbm93IGhvdyB0byBkaXNwbGF5IGxvZ3MgYmV0d2VlbiBhIHJl
dmlzaW9uIHJhbmdlIChib3RoCj4gc3RhcnQgYW5kIGVuZCBhcmUgaW5jbHVzaXZlKS4gSSBzZWFy
Y2hlZCBpdCBhbmQgb25seSBmb3VuZCBbMV0sCgpTb3JyeSBmb3IgZm9yZ2V0dGluZyBwYXN0ZSB0
aGUgbGluayBvZiBbMV06ClsxXSBodHRwczovL3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy8x
ODU5NTMwNS9naXQtbG9nLW91dHB1dHMtaW4tYS1zcGVjaWZpYy1yZXZpc2lvbi1yYW5nZQoKPiB3
aGljaCBkb2Vzbid0IHJlc29sdmUgbXkgcHJvYmxlbSBjb21wbGV0ZWx5LCBiZWNhdXNlCj4gCj4g
ICBnaXQgbG9nIDxvbGRlciBoYXNoPi4uPG5ld2VyIGhhc2g+Cj4gCj4gZG9lc24ndCBjb250YWlu
cyB0aGUgbG9nIG9mIDxvbGRlciBoYXNoPi4gU28sIGhvdyB0byBkaXNwbGF5Cj4gbG9ncyBiZXR3
ZWVuIGEgcmV2aXNpb24gcmFuZ2UgdGhhdCBib3RoIHN0YXJ0IGFuZCBlbmQgYXJlCj4gaW5jbHVz
aXZlPwo+IAo+IFBsZWFzZSBDQyBtZSwgdGhhbmtzLgo=
