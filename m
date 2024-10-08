Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE13FB9F
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358993; cv=none; b=PKEf5zpcSfmKTarcpOshYijjcUlOcmojgBA0ycFs0LfuWAubqnpHte8gJy0lh2eH4dy/MUWYBNbnI8F6/KQowYLhnGL/tDFRp/P4x5u03aMjsSXUA0YpIImERVG8TEvH81Vd3BLOcasVnfBIr1om4bPyy3/Zj+1KVGmzQF1hTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358993; c=relaxed/simple;
	bh=iA7ty1WW+bI3q317JV6oNmgQ2RC38RPtGzRo7GaN1SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=H56KIdSr0i+DfdytZMddkDtwX3pdBnF1uQ7JKFYyv4NbEKVgg9ATbg+8OcelzeX2Pqlnr5rPKU52TkjaFjcJUOncU1GlqrxfhouSForyFSkQYxf9D7uXuulpmLefZ9jxxVfwmvJq07gVaLB7XJuemxPd/4dF43dqOfgb4v74JwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Pp/J4KNB reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Pp/J4KNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=4izUfZyWzhJ4doE+/szQwHXHx2MzDFdvW0VIKGaAaWs=; b=P
	p/J4KNBCwed2YD6rE0bpNURSqrrLzHgC1VfZOdq+77yNkoHYwbqL3Lv8vtotAGyG
	jr6qet4xbHd7i4uxgyaIGMjOWaaYL4E5vgek/lJlz8lfRDxLIUj2rpSsbeuCWJKp
	KXHBzkE/uXOykRsKel3jBH77336bxx19CB7R5rQZL4=
Received: from bupt_xingxin$163.com ( [240e:694:e21:b::2] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Tue, 8 Oct 2024 11:42:45 +0800 (CST)
Date: Tue, 8 Oct 2024 11:42:45 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "blanet via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Brandon Williams" <bmwill@google.com>, 
	"Jonathan Tan" <jonathantanmy@google.com>
Subject: Re:Re: [PATCH v2 0/5] Support server option from configuration
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZwOaZkxETwdId9Qg@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
 <ZwOaZkxETwdId9Qg@pks.im>
X-NTES-SC: AL_Qu2ZCv+et0Et4yKdZOkXn0oVhe85UMW2ufsg3YReP500tyTsxQ0LbW9AOFTI+s6LKRqhoAi8dRR/9dRqf6BhVoeSDWLgAZRK8egrUlXZiuGK
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2d736d9e.4c15.1926a38e006.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aSgvCgDXX1I1qgRnDIgHAA--.49104W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiRQNybWcEpsJeLgABsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0xMC0wNyAxNjoyMzowMiwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6Cj5PbiBNb24sIFNlcCAyMywgMjAyNCBhdCAxMjoxNzo1M1BNICswMDAwLCBibGFuZXQg
dmlhIEdpdEdpdEdhZGdldCB3cm90ZToKPj4gV2UgaGF2ZSBtdWx0aXBsZSBpbnRlcm5hbCByZXBv
c2l0b3JpZXMgY29uZmlndXJlZCB3aXRoIGEgaHVnZSBudW1iZXIgb2YgQ0kKPj4gdGFza3MsIGVh
Y2ggcmVxdWlyaW5nIGNvZGUgcHJlcGFyYXRpb24gKGVpdGhlciB2aWEgY2xvbmUgb3IgZmV0Y2gp
LiBUaGVzZSBDSQo+PiB0YXNrcywgdHJpZ2dlcmVkIGJ5IHBvc3QtcmVjZWl2ZSBob29rcywgb2Z0
ZW4gZmV0Y2ggdGhlIHNhbWUgY29kZSAodXN1YWxseQo+PiB1c2luZyAtLWRlcHRoPTEpIGNvbmN1
cnJlbnRseS4KPj4gCj4+IFRvIHJlZHVjZSBwZXJmb3JtYW5jZSBpbXBhY3RzIG9uIHRoZSBnaXQg
c2VydmVyIGNhdXNlZCBieSB0aGVzZSB0YXNrcywgd2UKPj4gd2FudCB0byBkZXBsb3kgYSBzcGVj
aWFsIGRlc2lnbmVkIHBhY2stb2JqZWN0cy1ob29rLiBUaGlzIGhvb2sgd291bGQgYWxsb3cKPj4g
dGhlIHBhY2tzIGdlbmVyYXRlZCBieSBnaXQtcGFjay1vYmplY3RzIHRvIGJlIHJldXNlZC4gU2lu
Y2Ugbm90IGFsbAo+PiBjbG9uZS9mZXRjaCBvcGVyYXRpb25zIHdpbGwgYmVuZWZpdCBmcm9tIHRo
aXMgY2FjaGluZyAoZS5nLiwgcHVsbHMgZnJvbQo+PiBkZXZlbG9wZXJzJyBlbnZpcm9ubWVudHMp
LCBjbGllbnRzIG5lZWQgdG8gcGFzcyBhIHNwZWNpYWwgaWRlbnRpZmllciB0bwo+PiBpbmRpY2F0
ZSB3aGV0aGVyIGNhY2hpbmcgc2hvdWxkIGJlIGVuYWJsZWQgZm9yIGEgcGFydGljdWxhciBvcGVy
YXRpb24uIFVzaW5nCj4+IHNlcnZlciBvcHRpb25zIGlzIGEgc3VpdGFibGUgbWV0aG9kIGZvciB0
aGlzLgo+PiAKPj4gSG93ZXZlciwgc2VydmVyIG9wdGlvbnMgY2FuIG9ubHkgYmUgc3BlY2lmaWVk
IHZpYSB0aGUgY29tbWFuZCBsaW5lIG9wdGlvbgo+PiAodmlhIC0tc2VydmVyLW9wdGlvbiBvciAt
byksIHdoaWNoIGlzIGluY29udmVuaWVudCBhbmQgcmVxdWlyZXMgQ0kgc2NyaXB0Cj4+IG1vZGlm
aWNhdGlvbnMuIEEgY29uZmlndXJhdGlvbi1iYXNlZCBhcHByb2FjaCBpcyBlYXNpZXIgdG8gcHJv
cGFnYXRlIChieQo+PiBjaGFuZ2luZyB0aGUgZ2xvYmFsIGNvbmZpZ3VyYXRpb24gfi8uZ2l0Y29u
ZmlnKSBhbmQgYXZvaWRzIGlzc3VlcyB3aXRoIG9sZGVyCj4+IEdpdCB2ZXJzaW9ucyB0aGF0IGRv
bid0IHN1cHBvcnQgLS1zZXJ2ZXItb3B0aW9uLgo+PiAKPj4gVGhpcyBwYXRjaCBzZXJpZXMgaW50
cm9kdWNlcyBhIG5ldyBtdWx0aS12YWx1ZWQgY29uZmlndXJhdGlvbiwKPj4gcmVtb3RlLjxuYW1l
Pi5zZXJ2ZXJPcHRpb24sIHNpbWlsYXIgdG8gcHVzaC5wdXNoT3B0aW9uLCB0byBzcGVjaWZ5IGRl
ZmF1bHQKPj4gc2VydmVyIG9wdGlvbnMgZm9yIHRoZSBjb3JyZXNwb25kaW5nIHJlbW90ZS4KPj4g
Cj4+ICAqIFBhdGNoIDF+MyBpcyB0aGUgbWFpbiBjaGFuZ2UgZm9yIGludHJvZHVjaW5nIHRoZSBu
ZXcgY29uZmlndXJhdGlvbi4KPj4gICogUGF0Y2ggNCBmaXhlcyBhIGlzc3VlIGZvciBnaXQtZmV0
Y2ggbm90IHNlbmRpbmcgc2VydmVyLW9wdGlvbnMgd2hlbgo+PiAgICBmZXRjaGluZyBtdWx0aXBs
ZSByZW1vdGVzLgo+PiAgKiBQYXRjaCA1IGlzIGEgbWlub3IgZml4IGZvciBhIHNlcnZlciBvcHRp
b25zLXJlbGF0ZWQgbWVtb3J5IGxlYWsuCj4KPlNvcnJ5IGZvciB0YWtpbmcgdGhpcyBsb25nIHRv
IGdldCBiYWNrIHRvIHRoaXMgcGF0Y2ggc2VyaWVzLiBJJ3ZlIGdpdmVuCj5pdCBhbm90aGVyIGNh
cmVmdWwgcmVhZCBhbmQgaGF2ZSBhIHNpbmdsZSBwcm9wb3NhbCBmb3IgaW1wcm92ZWQgZG9jcwo+
dGhhdCB5b3UgbWF5IHdhbnQgdG8gYWRkcmVzcy4gQnV0IG90aGVyIHRoYW4gdGhvc2Ugbml0cyB0
aGlzIHZlcnNpb24KPmxvb2tzIGdyZWF0IHRvIG1lLCB0aGFua3MhCgoKVGhhbmtzIGZvciB5b3Vy
IGtpbmQgaGVscCEgSSBqdXN0IGdvdCBiYWNrIGZyb20gaG9saWRheSwgc28geW91ciByZXBseSB3
YXMKcGVyZmVjdGx5IHRpbWVkLiA6LSkKClhpbmcgWGluCg==
