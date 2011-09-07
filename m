From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Wed, 7 Sep 2011 09:46:35 +0200
Message-ID: <CAGdFq_h3KNuGuhhY2Zv-dHWqAY4Wq3HHBGh2f53rWzDT9PzSgQ@mail.gmail.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Kyle Neath <kneath@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LgX-0000wu-7n
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab1IGRMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:12:07 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46173 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab1IGRME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:12:04 -0400
Received: by pzk37 with SMTP id 37so17842pzk.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OJE6IHBAvLP4rLgx1eaDkMqf0ZPioW5LWchCPrSoUzo=;
        b=hAXX32ZHTcZBut/A+4jdBHbC7ksfDkhllKx6JJmHrEqesoD68mhQlmR5Vto8X4Tip+
         6l3ob/c/6tgc2Dno6fXpa5WGNdfYrOEhQ/KVmLyPIuhqN0Tb55P5iPRgCM8wC0rcfJ8c
         xbpX4MVlde7bW/N+wg/8aIPNsFZrZzk8kvkrI=
Received: by 10.68.26.133 with SMTP id l5mr2705223pbg.299.1315381635053; Wed,
 07 Sep 2011 00:47:15 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Wed, 7 Sep 2011 00:46:35 -0700 (PDT)
In-Reply-To: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180873>

SGV5YSwKCk9uIFdlZCwgU2VwIDcsIDIwMTEgYXQgMDc6MzMsIEt5bGUgTmVhdGggPGtuZWF0aEBn
bWFpbC5jb20+IHdyb3RlOgo+IEknbGwgc3VtbWFyaXplIHdpdGggYSBncmFwaCBvZiBteSBvcGlu
aW9uIG9mIHdoZXJlIGdpdCdzIHBvdGVudGlhbCBmb3IKPiBhZG9wdGlvbiBsaWVzOgo+Cj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gwqAgwqAgwqAgwqAgwqAgwqBPUFBPUlRVTklUWSBGT1IgR0lU
IEFET1BUSU9OIEFDQ09SRElORyBUTyBLWUxFIE5FQVRICj4KPiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoENhY2hpbmcgb2YgaHR0cCBjcmVkZW50aWFscwo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfAo+IFs9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT18fD09
PT09XQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIEV2ZXJ5dGhpbmcgZWxzZSBpbiB0aGUgdW5pdmVyc2UKPgo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQoKSSwgcGVyc29uYWxseSwgZmluZCB0aGUgZ3JhcGggdmVyeSBj
b252aW5jaW5nIDopLgoKSnVuaW8gbWVudGlvbmVkIGluIFdDIHRoYXQgaGUgd2FudHMgdG8gc2Vl
IHNvbWUgZmVlZGJhY2sgb24gaXQncwp1c2FnZSwgcGVyaGFwcyB0aGF0IHlvdSBjYW4gaGVscCBw
cm92aWRlIHRoaXMgYnkgcHJvdmlkaW5nIGEgZ2l0CnBhdGNoZWQgd2l0aCB0aGlzIGZ1bmN0aW9u
YWxpdHkgdG8gc29tZSBvZiB5b3VyIHVzZXJzIGFuZCBzZWUgaG93IHRoZXkKcmVzcG9uZD8KCi0t
IApDaGVlcnMsCgpTdmVycmUgUmFiYmVsaWVyCg==
