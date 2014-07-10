From: Sam McLeod <sammcj@gmail.com>
Subject: Align git push stderr output to the same as git pull
Date: Thu, 10 Jul 2014 15:33:47 +1000
Message-ID: <CAEc--nsLqVP1TfWgjcrmb=-AmURw3aOV7Na_wX0SWr9isjRVfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0102f3326c3e4004fdd02ce3
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 07:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X56zm-00081k-LB
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 07:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbaGJFeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 01:34:10 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:58699 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbaGJFeI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 01:34:08 -0400
Received: by mail-wg0-f52.google.com with SMTP id b13so8301111wgh.11
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9k/EezBOjIHLCMEqVlgFDY3vd7210wC2pUspr3iXqsE=;
        b=j7/JhUkWx0GPUkxq0PFtwdJ5DXsQUqTCbHcDxLOMvAmR9F6diVALbXz0+ldLSp6zmD
         bOApc++JCpLliKsYDANKUhHPtUPMqBBA8hSaKx/5n++2dfKe/zF8CAIrUCUAC5mN/ftQ
         SZILj/mpwrhlZoh9Tbc9NKtMCag+gzTbn7A3IimcG3hM/0zU2sYMKSQCeqz5tUHDMFUn
         d65MAkCgNEwH+9nzU5N1AsI9cnYNIWWZu7pb6Q/6vSWIQq7Q5nmwn31W9CR9SlzDKdm7
         Wl6gqJLIS7J++XHIiT+w98MkjesR5Rz7P/m4CuHAGZz+inzpjJRBe5SMEzWEp9OnAXj0
         R8WQ==
X-Received: by 10.194.104.97 with SMTP id gd1mr51056938wjb.77.1404970447152;
 Wed, 09 Jul 2014 22:34:07 -0700 (PDT)
Received: by 10.194.92.3 with HTTP; Wed, 9 Jul 2014 22:33:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253175>

--089e0102f3326c3e4004fdd02ce3
Content-Type: text/plain; charset=UTF-8

As per: https://github.com/git/git/pull/100

'For already up-to-date repos return "Already up-to-date" which is the
same message git pull returns.'

Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
  have the right to submit it under the open source license
  indicated in the file; or

(b) The contribution is based upon previous work that, to the best
  of my knowledge, is covered under an appropriate open source
  license and I have the right under that license to submit that
  work with modifications, whether created in whole or in part
  by me, under the same open source license (unless I am
  permitted to submit under a different license), as indicated
  in the file; or

(c) The contribution was provided directly to me by some other
  person who certified (a), (b) or (c) and I have not modified
  it.

(d) I understand and agree that this project and the contribution
  are public and that a record of the contribution (including all
  personal information I submit with it, including my sign-off) is
  maintained indefinitely and may be redistributed consistent with
  this project or the open source license(s) involved.

  Signed-off-by: Sam McLeod <sammcj@gmail.com>

--089e0102f3326c3e4004fdd02ce3
Content-Type: application/octet-stream; name="git-push-stderr.patch"
Content-Disposition: attachment; filename="git-push-stderr.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hxfn42gx0

ZGlmZiAtLWdpdCBhL2J1aWx0aW4vc2VuZC1wYWNrLmMgYi9idWlsdGluL3NlbmQtcGFjay5jCmlu
ZGV4IGY0MjBiNzQuLjZmYjI2NDIgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4vc2VuZC1wYWNrLmMKKysr
IGIvYnVpbHRpbi9zZW5kLXBhY2suYwpAQCAtMjc0LDcgKzI3NCw3IEBAIGludCBjbWRfc2VuZF9w
YWNrKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4KQogCX0K
IAogCWlmICghcmV0ICYmICF0cmFuc3BvcnRfcmVmc19wdXNoZWQocmVtb3RlX3JlZnMpKQotCQlm
cHJpbnRmKHN0ZGVyciwgIkV2ZXJ5dGhpbmcgdXAtdG8tZGF0ZVxuIik7CisJCWZwcmludGYoc3Rk
ZXJyLCAiQWxyZWFkeSB1cC10by1kYXRlXG4iKTsKIAogCXJldHVybiByZXQ7CiB9CmRpZmYgLS1n
aXQgYS90cmFuc3BvcnQuYyBiL3RyYW5zcG9ydC5jCmluZGV4IDU5Yzk3MjcuLjRkZDlmNzQgMTAw
NjQ0Ci0tLSBhL3RyYW5zcG9ydC5jCisrKyBiL3RyYW5zcG9ydC5jCkBAIC0xMjIwLDcgKzEyMjAs
NyBAQCBpbnQgdHJhbnNwb3J0X3B1c2goc3RydWN0IHRyYW5zcG9ydCAqdHJhbnNwb3J0LAogCQlp
ZiAocG9yY2VsYWluICYmICFwdXNoX3JldCkKIAkJCXB1dHMoIkRvbmUiKTsKIAkJZWxzZSBpZiAo
IXF1aWV0ICYmICFyZXQgJiYgIXRyYW5zcG9ydF9yZWZzX3B1c2hlZChyZW1vdGVfcmVmcykpCi0J
CQlmcHJpbnRmKHN0ZGVyciwgIkV2ZXJ5dGhpbmcgdXAtdG8tZGF0ZVxuIik7CisJCQlmcHJpbnRm
KHN0ZGVyciwgIkFscmVhZHkgdXAtdG8tZGF0ZVxuIik7CiAKIAkJcmV0dXJuIHJldDsKIAl9Cg==
--089e0102f3326c3e4004fdd02ce3--
