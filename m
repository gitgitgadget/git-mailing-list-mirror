Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BASE64_LENGTH_79_INF,
	BAYES_00,DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D83F20195
	for <e@80x24.org>; Fri, 15 Jul 2016 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbcGOQSn (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 12:18:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:44382 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbcGOQSl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 12:18:41 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bO5oz-0003sg-Ap
	for git@vger.kernel.org; Fri, 15 Jul 2016 18:18:38 +0200
Received: from 65.222.173.206 ([65.222.173.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 18:18:37 +0200
Received: from peartben by 65.222.173.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 18:18:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ben Peart <peartben@gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
Date:	Fri, 15 Jul 2016 16:18:28 +0000 (UTC)
Message-ID: <loom.20160715T181543-821@post.gmane.org>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com> <2C31984D-310C-4E8C-927B-6D98B7D7570B@gmail.com>
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

TGFycyBTY2huZWlkZXIgPGxhcnN4c2NobmVpZGVyIDxhdD4gZ21haWwuY29tPiB3cml0ZXM6Cgo+IAo+IFRoYW5rcyBmb3IgdGhpcyBncmVhdCBzdW1tYXJ5IG9mIHRoZSBwcm9ibGVtLCBDaHJpc3RpYW4hCj4gCj4gSSB0aGluayBhIGdlbmVyaWMgcGx1Z2luIG1lY2hhbmlzbSB3b3VsZCBiZSBncmVhdCBidXQgaG93IHdvdWxkIHdlIGRvIGl0PwoKSeKAmW0gYWxzbyB2ZXJ5IGdsYWQgdG8gc2VlIHRoZSBkaXNjdXNzaW9uIGFib3V0IGNvbWluZyB1cCB3aXRoIGEgZ29vZCBwYXR0ZXJuIGZvciAKaG93IGdpdCBjYW4gaW50ZXJhY3Qgd2l0aCBleHRlcm5hbCBjb2RlLiAgSSBoYWQgYWxzbyBub3RpY2VkIGFsbCB0aGUgaW4tZmxpZ2h0IAp0b3BpY3MgYXMgSSB3YXMgc2VhcmNoaW5nIGZvciBhIGdvb2QgcGF0dGVybiB0byBhZG9wdC4KCj4gCj4gV2UgY291bGQgZHluYW1pY2FsbHkgbG9hZCBsaWJyYXJpZXMgYnV0IHRoaXMgd291bGQgZm9yY2UgdXMgdG8gZnJlZXplIAo+IHRoZSBBQkkgYXMgbWVudGlvbmVkIGJ5IER1eToKPiBodHRwOi8vYXJ0aWNsZS5nbWFuZS5vcmcvZ21hbmUuY29tcC52ZXJzaW9uLWNvbnRyb2wuZ2l0LzI5ODQ2Mwo+IAoKSSB3b3VsZG7igJl0IGJlIHRvbyBxdWljayB0byBkaXNtaXNzIGR5bmFtaWNhbGx5IGxvYWRlZCBsaWJyYXJpZXMgYXMgdGhlcmUgYXJlIApzb21lIGRpc3RpbmN0IGFkdmFudGFnZXMgb3ZlciB0aGUgb3RoZXIgcGF0dGVybnMgZXNwZWNpYWxseSBwZXJmb3JtYW5jZSBhbmQgCnNpbXBsaWNpdHkuICBJIHJlYWxpemUgaXQgcmVxdWlyZXMgdXMgdG8gdmVyc2lvbiB0aGUgQUJJIGJ1dCB0aGVyZSBhcmUgCmVzdGFibGlzaGVkIHBhdHRlcm5zIHRvIG1hbmFnZSB0aGlzLiAgSXQgYWxzbyBpc27igJl0IHRoYXQgbXVjaCBkaWZmZXJlbnQgdGhhbiB1cyAKaGF2aW5nIHRvIGZyZWV6ZSBvciB2ZXJzaW9uIHRoZSBwcm90b2NvbCBmb3IgY29tbXVuaWNhdGluZyB3aXRoIGEgcmVtb3RlLWhlbHBlci4KCg==

