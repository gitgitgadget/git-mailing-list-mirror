Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6E2C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 01:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FED600EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 01:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhJLBFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 21:05:48 -0400
Received: from sender4-pp-o93.zoho.com ([136.143.188.93]:25392 "EHLO
        sender4-pp-o93.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhJLBFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 21:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1634000626; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BqMtbnl4nNqUfLTL6RSnm5xeO8xHx0uGDZoOFfqO58R1GI/8pXvckR4kPXvTRBIW+1scjABpbiAKmeZddQzSf84r8VweIgK2PeALdTrbYZ3tkeXMCoDYSDHhV0s87AIN9y+m3fhopJlpLTA+EFv2+yT2+wwUAeePphHSXxjJi08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1634000626; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fkSrUfNW5l5kskg5VLX12RuJsQ11oNePiXAxnr4PHQc=; 
        b=GtcYzMlTyRVoLoLgdeyeKgsSM6hRF3RdCNq1B0ffo0YRMfuT5QcEiJ+ivF1gTtJ/GidChogG06R0b6qh1U7Vo72yxh7U3IgRWgGRTZ3h+tEf2k1EhVzEfhIA1pK3wKl1spHoZaGRrYs1fDJEd/YUWzcHIfK0UIIjCDRH3wXUi1Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ToddAndMargo@zoho.com;
        dmarc=pass header.from=<ToddAndMargo@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:from:to:references:in-reply-to:content-type; 
  b=Ve6/1Wd3ceOBJm2bj/wJfPhax4sd1shVrOSwuPWX3apXaqsFOTN+lLuSOuenpXywvo54wZlIoOPo
    /zOCTSyXQu0luhbQuPZns2stPOdd1J3aowUbnX25/V7omyR7F4Xn  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1634000626;
        s=zm2020; d=zoho.com; i=ToddAndMargo@zoho.com;
        h=Message-ID:Date:MIME-Version:Subject:From:To:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=fkSrUfNW5l5kskg5VLX12RuJsQ11oNePiXAxnr4PHQc=;
        b=A6q4CkuzMWbRuBan8/8eZNLI9SwWxQpoStaJG6XT7RlsUqZgd+fzIrUvfzqcMEL5
        FyIg8k2lSX/RUVtJSsbgOHI56wO065WUBOE8EGjESbfyociq0J2IPEtNzdXAzhQHG5O
        Hcw8bNlzKDlMhhkUy4mKLXDGEo1L1Cg8xn9ixgjw=
Received: from [192.168.250.117] (50-37-29-217.grdv.nv.frontiernet.net [50.37.29.217]) by mx.zohomail.com
        with SMTPS id 1634000623027875.6567593699748; Mon, 11 Oct 2021 18:03:43 -0700 (PDT)
Message-ID: <6ad91bd9-5c3b-bbec-90e9-baa338b747e4@zoho.com>
Date:   Mon, 11 Oct 2021 18:03:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: I just want the revision
Content-Language: en-DE
From:   ToddAndMargo <ToddAndMargo@zoho.com>
To:     git@vger.kernel.org
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
In-Reply-To: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ZohoMailClient: External
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMTAvMTAvMjEgMTk6MzcsIFRvZGRBbmRNYXJnbyB3cm90ZToNCj4gSGkgQWxsLA0KPiAN
Cj4gSSBhbSB0cnlpbmcgdG8gd3JpdGUgYSBzY3JpcHQgdG8gdGVsbCBtZSB0aGUgbGF0ZXN0
IHJldmlzaW9uDQo+IHNob3dpbmcgb24NCj4gDQo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNr
dG9wLm9yZy9zcGljZS93aW4zMi9zcGljZS1uc2lzLy0vdHJlZS9tYXN0ZXINCj4gDQo+IHdo
aWNoIGlzICd2aXJ0aW8td2luOiByZWJhc2Ugb24gMC4xNjQiLCBidXQgSSBjYW4gb25seSBz
ZWUgdGhpcw0KPiBmcm9tIGEgd2ViIGJyb3dzZXIsIGFzIHRoZSBwYWdlIGlzIGR5bmFtaWMu
DQo+IA0KPiBJIGRvIGhhdmUgYWNjZXNzIHRvIHRoZSBnaXQgbGluayBvbiB0aGF0IHBhZ2U6
DQo+IA0KPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvc3BpY2Uvd2luMzIvc3Bp
Y2UtbnNpcy5naXQNCj4gDQo+IERvZXMgZ2l0IChvciBzb21lIG90aGVyKSBoYXZlIGEgd2F5
IG9mIHRlbGxpbmcgbWUNCj4gSlVTVCB0aGUgcmV2aXNpb24gd2l0aG91dCBoYXZpbmcgdG8g
ZG93bmxvYWQgdGhlIHR1cmtleT8NCj4gDQo+IElmIEkgY291bGQgZ2V0IHNvbWV0aGluZyB0
aGF0IGNvbnRhaW5lZA0KPiAgwqDCoMKgwqAgwqAgdmlydGlvLXdpbjrCoHJlYmFzZcKgb27C
oDAuMTY0DQo+IEkgY291bGQgZGlnIG91dCB0aGUgcmV2aXNpb24NCj4gDQo+IE1hbnkgdGhh
bmtzLA0KPiAtVA0KDQpUaGlzIHNpbXVsYXRlcyB3aGF0IEkgY2FtZSB1cCB3aXRoIGluIG15
IGFjdHVhbCBjb2RlOg0KDQokIGN1cmwgLS1zaWxlbnQgDQonaHR0cHM6Ly9naXRsYWIuZnJl
ZWRlc2t0b3Aub3JnL3NwaWNlL3dpbjMyL3NwaWNlLW5zaXMvLS9jb21taXRzL21hc3Rlcicg
DQp8IHJha3UgLW5lICdteSBTdHIgJHg9c2x1cnAoKTsgJHh+fnMvLio/ICJyZWJhc2Ugb24g
IiAvLzsgJHh+fnMvIA0KKCI8L2E+IikgLiogLy87IHByaW50ICIkeFxuIjsnDQoNCjAuMTY0
DQoNCg0KVGhhbmsgeW91IGFsbCBmb3IgdGhlIHRpcHMhDQo=
