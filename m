Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BASE64_LENGTH_79_INF,
	BAYES_00,DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4390820195
	for <e@80x24.org>; Fri, 15 Jul 2016 15:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbcGOPwz (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 11:52:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:42906 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbcGOPwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 11:52:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bO5Px-00016J-VR
	for git@vger.kernel.org; Fri, 15 Jul 2016 17:52:46 +0200
Received: from 65.222.173.206 ([65.222.173.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 17:52:45 +0200
Received: from peartben by 65.222.173.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 17:52:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ben Peart <peartben@gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
Date:	Fri, 15 Jul 2016 15:52:22 +0000 (UTC)
Message-ID: <loom.20160715T175103-45@post.gmane.org>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com> <20160715121838.GA21968@sigill.intra.peff.net> <CACBZZX4TA0Ljf2aNZtZ5Sj8fFj-vhoLKq5RP5YbKSS9o9Ljg+A@mail.gmail.com> <20160715133208.GA22711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.222.173.206 (Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

SmVmZiBLaW5nIDxwZWZmIDxhdD4gcGVmZi5uZXQ+IHdyaXRlczoKCj4gCj4gT24gRnJpLCBKdWwgMTUsIDIwMTYgYXQgMDI6NDY6MjhQTSArMDIwMCwgw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gd3JvdGU6Cj4gCj4gPiBPbiBGcmksIEp1bCAxNSwgMjAxNiBhdCAyOjE4IFBNLCBKZWZmIEtpbmcgPHBlZmYgPGF0PiBwZWZmLm5ldD4gd3JvdGU6Cj4gPiA+IFNvbWUgZmVhdHVyZXMsIGxpa2UgdGhlIGluZGV4LWhlbHBlciwgYXJlbid0IHF1aXRlIHNvIGVhc3kuIE9uZSByZWFzb24KPiA+ID4gaXMgdGhhdCBpdHMgZGF0YSBuZWVkcyB0byBwZXJzaXN0IGFzIGEgY2FjaGUgYmV0d2VlbiBtdWx0aXBsZSBnaXQKPiA+ID4gaW52b2NhdGlvbnMuIEluIGdlbmVyYWwsIEkgdGhpbmsgaXQgd291bGQgYmUgbmljZSB0byBzb2x2ZSB0aGF0IGJ5Cj4gPiA+IGNvbW11bmljYXRpbmcgdmlhIG9uLWRpc2sgZmlsZXMsIHJhdGhlciB0aGFuIGEgcnVubmluZyBkYWVtb24gKGp1c3QKPiA+ID4gYmVjYXVzZSBpdCBoYXMgZmV3ZXIgbW92aW5nIHBhcnRzKS4gQnV0IHRoYXQncyBvbmx5IGhhbGYgb2YgaXQgZm9yCj4gPiA+IGluZGV4LWhlbHBlci4gSXQgbmVlZHMgdG8gbW9uaXRvciBpbm90aWZ5IHdoaWxlIGdpdCBpc24ndCBydW5uaW5nIGF0Cj4gPiA+IGFsbDsgc28gaXQgcmVhbGx5IF9kb2VzXyBuZWVkIHNvbWUga2luZCBvZiBsb25nLXJ1bm5pbmcgZGFlbW9uLgo+ID4gCj4gPiBUaGlzICptYXkqIGhhdmUgY2hhbmdlZCBpbiB0aGUgcmVjZW50IHZlcnNpb25zIG9mIHRoZSBzZXJpZXMsIGJ1dCBJJ20KPiA+IGZhaXJseSBzdXJlIGFuZCBmb3Igd2hhdCBpdCdzIHdvcnRoIHRvIHRoaXMgZGlzY3Vzc2lvbiwgdGhhdCdzIG5vdAo+ID4gd2hhdCB0aGUgaW5kZXgtaGVscGVyIGRvZXMuIEl0J3MgdGhlcmUgdG8ga2VlcCB0aGUgaW5kZXggZmlsZSBpbgo+ID4gbWVtb3J5IGluc3RlYWQgb2YgcmVhZGluZyBpdCBmcm9tIGRpc2suCj4gPiAKPiA+IEl0IGNhbiAqYWxzbyogaWYgeW91ICJnaXQgdXBkYXRlLWluZGV4IC0td2F0Y2htYW4iIHNwYXduIGEgd2F0Y2htYW4KPiA+IGRhZW1vbiBpbiB0aGUgYmFja2dyb3VuZCwgd2hpY2ggaXMgdGhlIHRoaW5nIHRoYXQnbGwgYmUgZG9pbmcgdGhlCj4gPiBpbm90aWZ5IGNhbGxzIGFuZCBuZWVkcyB0byBzdGF5IHBlcnNpc3RlbnQsIHRoZSBpbmRleC1oZWxwZXIgdGhlbgo+ID4gY29tbXVuaWNhdGVzIHdpdGggdGhlIHdhdGNobWFuIGRhZW1vbiAid2hhdCBjaGFuZ2VkIHNpbmNlIFg/IiB0bwo+ID4gY29tcHV0ZSBhIG5ldyBpbmRleCB3aGVuIHJlcXVlc3RlZC4KPiAKPiBBaCwgeWVhaCwgeW91J3JlIHJpZ2h0LiBTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbjsgSSBoYXZlbid0IGFjdHVhbGx5Cj4gZm9sbG93ZWQgdGhlIHRvcGljIGFsbCB0aGF0IGNsb3NlbHkuCj4gCj4gLVBlZmYKPiAKCgpUaGF0J3MgdmVyeSBjbG9zZS4gIAoKSW5kZXgtaGVscGVyIGN1cnJlbnRseSBrZWVwcyB0aGUgaW5kZXggYWxpdmUgaW4gbWVtb3J5IGFuZCBzaGFyZXMgaXQgd2l0aCAKZ2l0LmV4ZSB2aWEgc2htIHNvIGl0IGRvZXMgbmVlZCB0byBwZXJzaXN0IGFzIGEgZGFlbW9uLiAgT3RoZXJ3aXNlLCBpdCB3aWxsIGhhdmUgCnRvIGJlIHJ1biBhZ2FpbiBhbmQgbG9hZCB0aGUgaW5kZXggZnJvbSBkaXNrIHdoaWNoIHByZXR0eSBtdWNoIGRlZmVhdHMgdGhlIApwdXJwb3NlLiAgQ3VycmVudGx5LCBpdCB0aW1lcyBvdXQgYWZ0ZXIgYSBwcmVzY3JpYmVkIHRpbWUgb2Ygbm90IGJlaW5nIHVzZWQgYW5kIApzaHV0cyBkb3duIHRvIGp1c3QgdG8gZnJlZSB1cCB0aGUgcmVzb3VyY2VzLgoKVGhlIHdhdGNobWFuIGRhZW1vbiBuZWVkcyB0byBfYWx3YXlzXyBiZSBydW5uaW5nIHNvIHRoYXQgaXQgY2FuIG1vbml0b3IgdGhlIAp3b3JraW5nIGRpcmVjdG9yeSBmb3IgY2hhbmdlcyBhbmQgcXVpY2tseSBwcm92aWRlIHRoZSBsaXN0IG9mIGNoYW5nZWQgZmlsZXMgYW5kIApkaXJlY3RvcmllcyB0byBnaXQuICBUaGlzIGN1cnJlbnRseSBoYXBwZW5zIHZpYSBpbmRleC1oZWxwZXIgYnV0IGNvdWxkIGJlIApzZXBhcmF0ZWQgYXMgdGhlIGxvZ2ljIHRvIHVzZSB0aGUgZGF0YSBmcm9tIHdhdGNobWFuIGFscmVhZHkgZXhpc3RzIGluIGdpdC4gIEkgCmhhdmUgYW4gUkZDIG91dCB0aGF0IGRvZXMgZXhhY3RseSB0aGF0Lgo=

