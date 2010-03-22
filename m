From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: running "git init --shared" on an existing repo
Date: Mon, 22 Mar 2010 12:00:01 +0530
Message-ID: <2e24e5b91003212330r2f3fd118y18386ef61c28ee89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 07:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntb9R-0003QF-Sp
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 07:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab0CVGaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 02:30:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57972 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab0CVGaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 02:30:05 -0400
Received: by vws6 with SMTP id 6so270777vws.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=QaQb1mxgrW/USUmbze0Gn5DjIyHepxkOjBnsjTxjvLw=;
        b=B/b3kymR/0RQJ4hdfaeRaowUzeIsCzwF48FycJ17xcud69cc6H/UZyNgo2dsXBg2cj
         gwfDSKwEZ3VDThVV5cqkFi2aVofLYuUo1UYLwFV9qWJlkdrUG+TXr8G/fQPFBopFGP51
         KGYLls4+wvX0SP7qOkWXdquGT/fUQ25nVL1mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CzmBnxz5gx759Xe7XQVr41D+O45ZqxA9gyJCGMI+o/uXD6h1IFtxmXLn/leMptJ7Zv
         DeRdAF8DoBhJ7JgD6CfwdJom55LvKZELmkxvOUH947Z5bEXY1uasQ3w7opIDgVtPRa9t
         QV33C9hj+J6DYbxshQmaD3HoG+vsoVee0uanM=
Received: by 10.220.107.227 with SMTP id c35mr946698vcp.42.1269239401548; Sun, 
	21 Mar 2010 23:30:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142901>

SGkgYWxsLAoKSWYgeW91IGZvcmdldCB0byB1c2UgIi0tc2hhcmVkIiBvbiB5b3VyIChiYXJlKSBy
ZXBvLCBhbmQgbm93IG5lZWQgdG8KYWRqaXN0IGl0IGFmdGVyIHRoZSBmYWN0IHRvIG1ha2UgcGVy
bXMgd29yayBvaywgeW91IG91Z2h0IHRvIGJlIGFibGUKdG8ganVzdCBydW4gImdpdCBpbml0IC0t
YmFyZSAtLXNoYXJlZCIgYW5kIHRoaW5ncyBzaG91bGQgYmUgZmluZS4KCkFuZCBpdCBzZWVtcyB0
aGVyZSB3YXMgYSBiZWdpbm5pbmcgbWFkZS7CoCBidWlsdGluL2luaXQtZGIuYyBhdCBsaW5lIDIy
MCBzYXlzOgoKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBXZSB3b3VsZCBoYXZlIGNyZWF0ZWQgdGhlIGFib3ZlIHVuZGVyIHVzZXIncyB1bWFzayAt
LSB1bmRlcgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBzaGFyZWQtcmVwb3NpdG9yeSBzZXR0
aW5ncywgd2Ugd291bGQgbmVlZCB0byBmaXggdGhlbSB1cC4KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICovCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNoYXJlZF9yZXBvc2l0b3J5KSB7CsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkanVzdF9zaGFyZWRfcGVybShn
ZXRfZ2l0X2RpcigpKTsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRq
dXN0X3NoYXJlZF9wZXJtKGdpdF9wYXRoKCJyZWZzIikpOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBhZGp1c3Rfc2hhcmVkX3Blcm0oZ2l0X3BhdGgoInJlZnMvaGVhZHMi
KSk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkanVzdF9zaGFyZWRf
cGVybShnaXRfcGF0aCgicmVmcy90YWdzIikpOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KCklk
ZWFsbHksIHdlIHNob3VsZCBkbyB0aGUgc2FtZSB0bzoKCmhvb2tzCmluZm8Kb2JqZWN0cwpvYmpl
Y3RzLz8/Cm9iamVjdHMvaW5mbwpvYmplY3RzL3BhY2sKCmFsc28uICBUaGUgb3RoZXMgYXJlIGVh
c3ksIGJ1dCBkb2VzIGdpdCBpbnRlcm5hbHMgaGF2ZSBhIGRlZmluZWQgd2F5Cm9mIGRvaW5nIHRo
YXQgb2JqZWN0cy8/PyBwYXJ0IG9yIHNob3VsZCBpdCBqdXN0IGJlIHRoZSBsb25nIHdheSAoaXQn
cwpiZWVuIGFnZXMgc2luY2UgSSBkaWQgYW55IEMgYnV0IEknZCBiZSB3aWxsaW5nIHRvIHRyeS4u
LikKCi0tClNpdGFyYW0K
