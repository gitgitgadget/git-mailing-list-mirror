From: Jonathan Gossage <jgossage@gmail.com>
Subject: Newbie .gitignore problem
Date: Wed, 22 Sep 2010 12:41:01 -0400
Message-ID: <AANLkTin=BwgjqWQ3NfNdL9a1fUnVnFMrmAsmnZjHS=gL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 18:41:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OySNb-0004FJ-RM
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 18:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab0IVQlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 12:41:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54453 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab0IVQlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 12:41:04 -0400
Received: by bwz11 with SMTP id 11so595472bwz.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=CfLizPYCDcdGdhyGlITp/QKhyB77LApCJJlRxB8eyHk=;
        b=bxTmihbvwWSy+4UVwsitCjV5lELbZ9vOE3KIH4PvgZgQ3NtokjiPswgJ3us0aQIuoy
         OyADuMRqhQMuB0BDlJAy0UyC43e7XZ1z+gJe0b42Keuiqrj8wau97q6WZJvdE7UiDbwB
         YucktdLLNwQ7qCbzxRstLDlHU0u0r+nFRNQEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nRYNdzeNsOajksgp8mmwpUcBpSEszZVbI1xzWoFHFinPfr5raFxMq5dz/NCHzARIoM
         i979R/6I1N4fva7rK6TFbg0zij9ym71AzmW8W7ERhfaRbjLI1mKJDvKyYZI+5hhOOp3e
         mKF77JXnGNYjfVis/9rWV4LcgL0sTE7xTEG+c=
Received: by 10.204.126.223 with SMTP id d31mr231751bks.146.1285173661806;
 Wed, 22 Sep 2010 09:41:01 -0700 (PDT)
Received: by 10.204.152.219 with HTTP; Wed, 22 Sep 2010 09:41:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156809>

SSBhbSBoYXZpbmcgYSBwcm9ibGVtIHNwZWNpZnlpbmcgLmdpdGlnbm9yZSBmaWx0ZXJzIHByb3Bl
cmx5CkkgaGF2ZSBhIGRpcmVjdG9yeSBzdHJ1Y3R1cmUgYXMgZm9sbG93czoKCsKgwqAgwqAgwqAg
wqAgwqByZXBvLXJvb3QKwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8CsKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQrCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8CiDCoCDCoCDCoCDCoCDCoCB8CsKgwqAgwqAgwqAgwqAgwqAgwqAgwqBk
aXIxIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcjIgwqAoc3ltbGluaykKwqAgwqAgwqAgwqAgwqAg
wqAgwqBkaXIzCsKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8CsKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHwKwqDCoCDCoCDCoCDCoCDCoG1hbnkgZGlyZWN0b3JpZXMgYW5kIGZp
bGVzIMKgIMKgIMKgIMKgIMKgIMKgIMKgICAgIGRpcjQKCk15IHByb2JsZW0gaXMgdGhhdCBJIHdh
bnQgdG8gZXhjbHVkZSBhbGwgZmlsZXMgYW5kIHN1Yi1kaXJlY3RvcmllcyBpbiBkaXIyCmV4Y2Vw
dCBmb3IgZGlyNCBmcm9tIGNvbnRyb2wgYnkgR2l0LgpJIHRyaWVkIGEgbnVtYmVyIG9mIHZhcmlh
dGlvbnMgb24gdGhlIGZvbGxvd2luZyAuZ2l0aWdub3JlIGZpbGUgaW4gZGlyMiBidXQKZWl0aGVy
IGV2ZXJ5dGhpbmcgd2FzIGV4Y2x1ZGVkIG9yIGV2ZXJ5dGhpbmcgd2FzIGluY2x1ZGVkLiBJIHRl
c3RlZCB1c2luZwpnaXQgYWRkIC11YWxsIC1uCgpUaGUgZmluYWwgLmdpdGlnbm9yZSBmaWxlIHdh
cwoqCiovKgohZGlyNAoKCkhvdyBzaG91bGQgSSBnbyBhYm91dCB0YWNrbGluZyB0aGlzLiBUaGUg
LmdpdGlnbm9yZSBtYW4gcGFnZXMgd2VyZQp1bmNsZWFyIHRvIG1lLgoKSm9uYXRoYW4gR29zc2Fn
ZQo=
