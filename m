Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E5CC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0687760F57
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 10:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhJKK0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 06:26:48 -0400
Received: from sender4-pp-o93.zoho.com ([136.143.188.93]:25330 "EHLO
        sender4-pp-o93.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhJKK0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 06:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633947884; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QjXs+tK2m5/iElapc8Nzn2GzUwvxF76XTyw7WxpeYT0gp+9KT74ecn2jVKFk2BAzrBlEGhRWIo9mopCGRDG9PdZDmlfIHbljmG5A457/a3SR7PxIMWEhkV2bu/H9MyJgWQ8iJFra4TLFPz+q7OjS0I/6sbjBVDLqhGUPaGDNKts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1633947884; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CFK+7+Sy3iyWS1LxgABRGKe6KFpZeaYwS7VAeXb2XTE=; 
        b=fu3NnDoam5pQpHkOk0y9iJBIama4GEJQYFENcrGVgF190fbO4k8KfmoHlm7lG8Ih4hBvLbXeYKlQrP9XUYmPBF1+LLIdQYFUICUDMJOnG74IBfTtO42kJiXq01cNcXh9AO4pdRFmEMUtZxRXFJOvwAiOQEqhhwLUR48RpRFZC0g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ToddAndMargo@zoho.com;
        dmarc=pass header.from=<ToddAndMargo@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:from:to:cc:references:in-reply-to:content-type; 
  b=Zq/ddEymHmuZPsd4Q5uJy13xKV8bGz2ww8MGEYa1neDern4jIk5wufCaZKkAo6CthiptWZNCJ9wB
    tjxzXxwv7iBN3RP0yx1zPGJtIXl9HtBZ/heODH/teiI5HhYsgCnL  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633947884;
        s=zm2020; d=zoho.com; i=ToddAndMargo@zoho.com;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=CFK+7+Sy3iyWS1LxgABRGKe6KFpZeaYwS7VAeXb2XTE=;
        b=Mke3dP8+Fh6eotsnQDeSK0cfg3zwHUlErzsfnRxxX26vIbY0D8RdVJA5Da6Ls2qh
        ++xQDESiEr19tlGon9jwKbVxUTo/c8Z9OrJTLxfRx46DnzOygmp5M4jE8rVTmapM4/o
        9gZeE4nIKHTNg9ORyKR+RK/28SQzTmYsuHs+eUTQ=
Received: from [192.168.250.117] (50-37-29-217.grdv.nv.frontiernet.net [50.37.29.217]) by mx.zohomail.com
        with SMTPS id 1633947881795319.0837399911635; Mon, 11 Oct 2021 03:24:41 -0700 (PDT)
Message-ID: <afd8890e-0042-8fc6-523d-f69aa6ed7af3@zoho.com>
Date:   Mon, 11 Oct 2021 03:24:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: I just want the revision
Content-Language: en-DE
From:   ToddAndMargo <ToddAndMargo@zoho.com>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
 <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com>
 <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com>
In-Reply-To: <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ZohoMailClient: External
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMTAvMTEvMjEgMDM6MDksIFRvZGRBbmRNYXJnbyB3cm90ZToNCj4gT24gMTAvMTEvMjEg
MDI6NDUsIENocmlzdGlhbiBDb3VkZXIgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiBNb24s
IE9jdCAxMSwgMjAyMSBhdCA0OjU3IEFNIFRvZGRBbmRNYXJnbyA8VG9kZEFuZE1hcmdvQHpv
aG8uY29tPiANCj4+IHdyb3RlOg0KPj4+DQo+Pj4gSGkgQWxsLA0KPj4+DQo+Pj4gSSBhbSB0
cnlpbmcgdG8gd3JpdGUgYSBzY3JpcHQgdG8gdGVsbCBtZSB0aGUgbGF0ZXN0IHJldmlzaW9u
DQo+Pj4gc2hvd2luZyBvbg0KPj4+DQo+Pj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Au
b3JnL3NwaWNlL3dpbjMyL3NwaWNlLW5zaXMvLS90cmVlL21hc3Rlcg0KPj4+DQo+Pj4gd2hp
Y2ggaXMgJ3ZpcnRpby13aW46IHJlYmFzZSBvbiAwLjE2NCIsIGJ1dCBJIGNhbiBvbmx5IHNl
ZSB0aGlzDQo+Pj4gZnJvbSBhIHdlYiBicm93c2VyLCBhcyB0aGUgcGFnZSBpcyBkeW5hbWlj
Lg0KPj4+DQo+Pj4gSSBkbyBoYXZlIGFjY2VzcyB0byB0aGUgZ2l0IGxpbmsgb24gdGhhdCBw
YWdlOg0KPj4+DQo+Pj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL3NwaWNlL3dp
bjMyL3NwaWNlLW5zaXMuZ2l0DQo+Pj4NCj4+PiBEb2VzIGdpdCAob3Igc29tZSBvdGhlcikg
aGF2ZSBhIHdheSBvZiB0ZWxsaW5nIG1lDQo+Pj4gSlVTVCB0aGUgcmV2aXNpb24gd2l0aG91
dCBoYXZpbmcgdG8gZG93bmxvYWQgdGhlIHR1cmtleT8NCj4+DQo+PiBJZiB5b3UganVzdCB3
YW50IHRoZSBjb21taXQgSUQsIHlvdSBjYW4gdXNlIGZvciBleGFtcGxlOg0KPj4NCj4+ICQg
Z2l0IGxzLXJlbW90ZQ0KPj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL3NwaWNl
L3dpbjMyL3NwaWNlLW5zaXMuZ2l0DQo+PiByZWZzL2hlYWRzL21hc3Rlcg0KPj4gZjZhZDQ0
ZjM1ZjVjYWVlYzUxYjcwMDIxNjk5NzcyNzJkODU3MDFhM8KgwqDCoMKgwqDCoMKgIHJlZnMv
aGVhZHMvbWFzdGVyDQo+Pg0KPj4+IElmIEkgY291bGQgZ2V0IHNvbWV0aGluZyB0aGF0IGNv
bnRhaW5lZA0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgdmlydGlvLXdpbjogcmViYXNlIG9uIDAu
MTY0DQo+Pj4gSSBjb3VsZCBkaWcgb3V0IHRoZSByZXZpc2lvbg0KPj4NCj4+IFlvdSBtaWdo
dCBhbHNvIHdhbnQgdG8gdGFrZSBhIGxvb2sgYXQgdGhlIEdpdExhYiBBUEkgZG9jcywgZm9y
IGV4YW1wbGU6DQo+Pg0KPj4gaHR0cHM6Ly9kb2NzLmdpdGxhYi5jb20vZWUvYXBpL2NvbW1p
dHMuaHRtbA0KPj4NCj4+IEJlc3QsDQo+PiBDaHJpc3RpYW4uDQo+Pg0KPiANCj4gSGkgQ2hy
aXN0aWFuLA0KPiANCj4gSSBkbyBub3QgbWVhbiB0byBiZSBkZW5zZSwgYnV0IGhvdyBkbyBJ
IGdldA0KPiAidmlydGlvLXdpbjogcmViYXNlIG9uIDAuMTY0IiBvdXQgb2Y6DQo+ICIgZjZh
ZDQ0ZjM1ZjVjYWVlYzUxYjcwMDIxNjk5NzcyNzJkODU3MDFhM8KgIHJlZnMvaGVhZHMvbWFz
dGVyIj8NCj4gDQo+IFBlcnBsZXhlZCwNCj4gLVQNCg0KDQpGb3VuZCBzb21ldGhpbmcgdGhh
dCB3b3JrZWQ6DQoNCiQgY3VybCAtLXNpbGVudCANCidodHRwczovL2dpdGxhYi5mcmVlZGVz
a3RvcC5vcmcvc3BpY2Uvd2luMzIvc3BpY2UtbnNpcy8tL2NvbW1pdHMvbWFzdGVyJyANCnwg
Z3JlcCAgcmViYXNlDQoNCjxhIGNsYXNzPSJjb21taXQtcm93LW1lc3NhZ2UgaXRlbS10aXRs
ZSBqcy1vbmJvYXJkaW5nLWNvbW1pdC1pdGVtICIgDQpocmVmPSIvc3BpY2Uvd2luMzIvc3Bp
Y2UtbnNpcy8tL2NvbW1pdC9mNmFkNDRmMzVmNWNhZWVjNTFiNzAwMjE2OTk3NzI3MmQ4NTcw
MWEzIj52aXJ0aW8td2luOiANCnJlYmFzZSBvbiAwLjE2NDwvYT4NCg0KPGEgY2xhc3M9ImNv
bW1pdC1yb3ctbWVzc2FnZSBpdGVtLXRpdGxlIGpzLW9uYm9hcmRpbmctY29tbWl0LWl0ZW0g
IiANCmhyZWY9Ii9zcGljZS93aW4zMi9zcGljZS1uc2lzLy0vY29tbWl0L2Q2ODM2Zjc5YmE4
ZGVlZWY1Yjc3MTlmZDk0Y2MyMDhiODFlYjcwZGYiPnZpcnRpby13aW46IA0KcmViYXNlIG9u
IDAuMTY0PC9hPg0KDQoNCg==
