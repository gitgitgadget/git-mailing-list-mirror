From: code.sculptor@gmail.com
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 12:22:32 +0000
Message-ID: <1871454323-1301314947-cardhu_decombobulator_blackberry.rim.net-1749053087-@bda570.bisx.prod.on.blackberry>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Reply-To: code.sculptor@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "=?Windows-1252?B?xnZhciBBcm5mavZy8CBCamFybWFzb24=?=" 
	<avarab@gmail.com>, git-owner@vger.kernel.org,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 14:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4BSw-0000ZT-Uq
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 14:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab1C1MWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 08:22:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65112 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab1C1MWc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 08:22:32 -0400
Received: by iwn34 with SMTP id 34so3609223iwn.19
        for <multiple recipients>; Mon, 28 Mar 2011 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-rim-org-msg-ref-id:message-id
         :content-transfer-encoding:reply-to:x-priority:references
         :in-reply-to:sensitivity:importance:subject:to:from:date
         :content-type:mime-version;
        bh=L8utzpbQq4x9Qr/RYaV7lO7ND7K0aLe0liHz/9gyeng=;
        b=a1M0WFBqNHrou6qD9dSrD7dOjtrIhyJiX9sMMPHPL7bqX78kQUqIl1PdJ2vAckIs7O
         vSCSagWA7jq+9zrgzrJQ5WzcopXSSkUQqTRhS77XeWQI1vSJlK0G9qdv86vCV2/v+pBC
         NwBDrP2tG1QIsKC+1/An2r0lU1xJvHyoLjwho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-rim-org-msg-ref-id:message-id:content-transfer-encoding:reply-to
         :x-priority:references:in-reply-to:sensitivity:importance:subject:to
         :from:date:content-type:mime-version;
        b=FXpia4ukyUHrm9XlninhBolWyccdqyrwAXN3GiEwHu4/lx9C7GxjDcKNxAuGs6ifcu
         VYZuxDZ55g0h4pzF1kChiyiB6ZPMEArEfg7Y7erpFmPzk3G5JMmfVamwyrL7eUaSSaS0
         Ug1y8pOc6crnFsQeyYbuxIswKRM+j+lJgtb9k=
Received: by 10.231.111.209 with SMTP id t17mr3890352ibp.140.1301314952185;
        Mon, 28 Mar 2011 05:22:32 -0700 (PDT)
Received: from bda076.bisx.prod.on.blackberry (bda-67-223-82-191.bise.na.blackberry.com [67.223.82.191])
        by mx.google.com with ESMTPS id y10sm2926776iba.12.2011.03.28.05.22.29
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 05:22:30 -0700 (PDT)
X-rim-org-msg-ref-id: 1871454323
X-Priority: Normal
In-Reply-To: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Sensitivity: Normal
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170121>

VGhhdCdzIGEgcmVhbGx5IGdvb2QgcG9pbnQhIFBlcmhhcHMgd2Ugc2hvdWxkIGhhdmUgYSAtLWlu
dmVydCBmbGFnPw0KU2VudCBmcm9tIG15IEJsYWNrQmVycnkgZGV2aWNlIG9uIHRoZSBSb2dlcnMg
V2lyZWxlc3MgTmV0d29yaw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogw4Z2
YXIgQXJuZmrDtnLDsCBCamFybWFzb24gPGF2YXJhYkBnbWFpbC5jb20+DQpTZW5kZXI6IGdpdC1v
d25lckB2Z2VyLmtlcm5lbC5vcmcNCkRhdGU6IE1vbiwgMjggTWFyIDIwMTEgMTE6MzI6MjEgDQpU
bzogR2l0IE1haWxpbmcgTGlzdDxnaXRAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogV2h5IGNh
bid0IEkgdXNlIGdpdC1iaXNlY3QgdG8gZmluZCB0aGUgZmlyc3QgKmdvb2QqIGNvbW1pdD8NCg0K
U29tZXRoaW5nIHdhcyBicm9rZW4gYSAxMDAgcmV2aXNpb25zIGFnbywgaGFzIG5vdyBiZWVuIGZp
eGVkLCBidXQgSQ0Kd2FudCB0byBmaW5kIHdoZW4gaXQgd2FzIGZpeGVkLg0KDQpJJ2QgZXhwZWN0
IHRoaXMgdG8gd29yazoNCg0KICAgICQgZ2l0IGJpc2VjdCBzdGFydA0KICAgICQgZ2l0IGJpc2Vj
dCBnb29kDQogICAgJCBnaXQgYmlzZWN0IGJhZCBIRUFEfjEwMA0KICAgIFNvbWUgZ29vZCByZXZz
IGFyZSBub3QgYW5jZXN0b3Igb2YgdGhlIGJhZCByZXYuDQogICAgZ2l0IGJpc2VjdCBjYW5ub3Qg
d29yayBwcm9wZXJseSBpbiB0aGlzIGNhc2UuDQogICAgTWF5YmUgeW91IG1pc3Rha2UgZ29vZCBh
bmQgYmFkIHJldnM/DQoNCkJ1dCBpbnN0ZWFkIEkgaGF2ZSB0byBkbzoNCg0KICAgICQgZ2l0IGJp
c2VjdCBzdGFydA0KICAgICQgZ2l0IGJpc2VjdCBiYWQNCiAgICAkIGdpdCBiaXNlY3QgZ29vZCBI
RUFEfjEwMA0KDQpBbmQgdGhlbiBwcm9jZWVkIHRvIG1hcmsgZ29vZCByZXZpc2lvbnMgYXMgYmFk
LCBhbmQgYmFkIHJldmlzaW9ucyBhcw0KZ29vZC4NCg0KVGhhdCB3b3JrcywgYnV0IGl0J3MgdmVy
eSBjb25mdXNpbmcuDQoNCldoeSBjYW4ndCBiaXNlY3QganVzdCBkbyB0aGUgcmlnaHQgdGhpbmcg
aGVyZSBhbmQgYWNjZXB0IHRoYXQgeW91cg0KbW9yZSByZWNlbnQgcmV2ZXNpb24gaXMgdGhlIGdv
b2Qgb25lLCBhbmQgdGhlIG9sZCBvbmUgaXMgdGhlIGJhZCBvbmU/DQotLQ0KVG8gdW5zdWJzY3Jp
YmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGdpdCIgaW4NCnRo
ZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQpNb3JlIG1h
am9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0
bWwNCg==
