Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BASE64_LENGTH_79_INF,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23E620195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbcGLWuW (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:50:22 -0400
Received: from plane.gmane.org ([80.91.229.3]:59169 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbcGLWuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:50:18 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bN6VB-0000b7-6t
	for git@vger.kernel.org; Wed, 13 Jul 2016 00:50:05 +0200
Received: from 73.109.61.20 ([73.109.61.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 00:50:05 +0200
Received: from zhzexi by 73.109.61.20 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 00:50:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Jesse Zhuang <zhzexi@gmail.com>
Subject: windows 10 git 2.9.0 with vim 7.4.1023 display editing bug
Date:	Tue, 12 Jul 2016 22:44:58 +0000 (UTC)
Message-ID: <loom.20160713T004406-291@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 73.109.61.20 (Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

SSBhbSB1c2luZyBnaXQgMi45LjAud2luZG93cy4xIGluIHdpbmRvd3MgMTAuIFdpdGggY29yZS5lZGl0b3Igc2V0IHRvIAp2aW0uCgpWaW0gd2FzIGRvd25sb2FkZWQgZnJvbSB2aW0ub3JnIGxhdGVzdCB2ZXJzaW9uIGJpbmFyeTogVklNIC0gVmkgSU1wcm92ZWQgCjcuNC4xMDIzICgyMDEzIEF1ZyAxMCwgY29tcGlsZWQgSmFuIDIgMjAxNiAxNDoyNDozNSkgTVMtV2luZG93cyAzMi1iaXQgCmNvbnNvbGUgdmVyc2lvbgoKV2hlbiBJIGRvIGEgZ2l0IGNvbW1pdCBpbiBhIGNtZCB3aW5kb3csIGl0IGdvZXMgaW50byBhIHZpbSByaWdodCBpbiB0aGUgCmNvbW1hbmQgd2luZG93LgoKQnV0IHRoZSBkaXNwbGF5IGlzIGluY29ycmVjdCwgcGxlYXNlIGNoZWNrIHRoZSBmaXJzdCBpbWFnZSBpbiB0aGlzIGFsYnVtIApodHRwOi8vaW1ndXIuY29tL2EvVlNmdWrigIsgd2l0aCB0aXRsZSAiZ2l0Mi45LjAtdmltNy40LjEwMjMtMSIuCgpOb3RpY2UgdGhhdAoKMSwgdGhlIHNjcm9sbCBiYXIgb24gdGhlIHJpZ2h0IGlzIHdheSB0b28gbG9uZyB0aGFuIGl0IHNob3VsZCBiZS4KMiwgYWZ0ZXIgSSBwcmVzc2VkIGkgdG8gaW5zZXJ0IGFuZCBpbnNlcnRlZCAidGVzdCIsIG5vdGljZSBob3cgdGhlIGZvdXIgCmxldHRlcnMgd2VyZSBraW5kIHBvc2l0aW9uZWQgYXMgYSBmYWxsaW5nIGxhZGRlci4gdGhlIGJlaGF2aW9ycyBvZiB1c2luZyAKaGprbCBrZXlzIHRvIG5hdmlnYXRlIHRoZSBmaWxlIGlzIGFsc28gaW5jb3JyZWN0LgoKVGhlIGFsYnVtIGFsc28gY29udGFpbnMgc29tZSBvdGhlciBpbWFnZXMgd2l0aCBnaXQgdmVyc2lvbnMgc3Bhbm5pbmcgCjIuNy4wLCAyLjguMCwgMi45LjAuIEp1c3QgZm9yIHlvdXIgcmVmZXJlbmNlLCB0aGVyZSB3YXMgYW4gaXNzdWUgd2l0aCAKdGV4dCBjb2xvciBpbmNvcnJlY3Qgd2l0aCB2ZXJzaW9ucyAyLjcgYW5kIDIuOC4gVGhlIGRpc3BsYXkgaXNzdWUgd2FzIApwcm9iYWJseSBwcmVzZW50IGluIHRob3NlIGVhcmxpZXIgdmVyc2lvbnMgdG9vIGJ1dCBJIGFtIG5vdCAxMDAlIHN1cmUgCmJlY2F1c2Ugb2YgdGhlIGJsYWNrIHRleHQgb24gYmxhY2sgc2NyZWVuIGlzc3VlLiBJIHdhbnQgdG8gZm9jdXMgb24gdGhlIApidWcgd2l0aCB2ZXJzaW9uIDIuOS4wLgoKU3RhcnRpbmcgdmltIHVwIGZyb20gdGhlIGNvbW1hbmQgbGluZSBpcyB0b3RhbGx5IGZpbmUuIElmIEkgdXNlICJnaXQgCmJhc2ggaGVyZSIsIHZpbSBiZWhhdmVzIHRvdGFsbHkgZmluZS4KClRoYW5rcyBpbiBhZHZhbmNlIGZvciBldmVyeW9uZSB3aG8gd2lsbCBsb29rIGludG8gdGhpcyBidWcuCgpKZXNzZQoKSmVzc2UgWmh1YW5nCmh0dHA6Ly9qZXNzZXpodWFuZy5naXRodWIuaW8=

