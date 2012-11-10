From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Do not add an empty value from config credential.helper
Date: Sat, 10 Nov 2012 23:08:04 +0800
Message-ID: <CAHtLG6Snuv4x+xvqJRmEo8b8TJRPqBP46kanSsfvhgDWfDbuOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=485b390f7f405b51e704ce256f49
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 16:13:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXCkP-0000x9-QZ
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 16:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab2KJPII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 10:08:08 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52905 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab2KJPIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 10:08:06 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so3709828lbo.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 07:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=T+hs714Al0/lZCBAp0ZAs3SE4R1KnAVJB8Xm8iUMaDo=;
        b=DRmpMJxiTqzhIyN506Uf/TjxGA+lEbx6v/FlC7QOQKTSQUbOWKwAq6xohtpSqIcpWv
         i1oLADe7Y0UMjE1t/VC36rGFlR2IKN3xsvY/42pdO9kSZgWj673reSKCrQNHCy6S+ECT
         mnHKmR6IVsZHlrKjRvcI6Vci7oJhnRFH+Y/+likeJ7S9WQmWJTiRgneCkYKjlbBmQ3gT
         TiphP1kGmqqImc8x9zPzdcD4HxB/j0y9rjMIBsJFkhOjXsfi6qlY9s7Gq3gT2H6nQJbf
         oIGmXg4Wy5dkzD4eB3UERLi3K7ow8Wb8juWx5niwvHMBou2s96o4Eod7WY3uE9BRB05u
         rMFw==
Received: by 10.112.43.34 with SMTP id t2mr5758726lbl.109.1352560084209; Sat,
 10 Nov 2012 07:08:04 -0800 (PST)
Received: by 10.112.47.71 with HTTP; Sat, 10 Nov 2012 07:08:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209277>

--485b390f7f405b51e704ce256f49
Content-Type: text/plain; charset=ISO-8859-1

Below is current git message when a local config credential.helper has
an empty value. Please skip an empty value.

$ git push --force origin master
git: 'credential-' is not a git command. See 'git --help'.

Did you mean this?
        credential
Total 0 (delta 0), reused 0 (delta 0)
To https://user@github.com/user/myrepo.git
 + d23aa6a...3405990 master -> master (forced update)

--485b390f7f405b51e704ce256f49
Content-Type: application/octet-stream; 
	name="0001-credential-do-not-recognize-a-credential-helper-if-c.patch"
Content-Disposition: attachment; 
	filename="0001-credential-do-not-recognize-a-credential-helper-if-c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h9cvck040

RnJvbSAwYjNlYzA3ZWQ4OTNhMGQ1OTVjZjQ4YzU1ZDg4NGZmODQ0ZjExMDhmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXAgWXV0IFN1bSA8Y2gzY29vbGlAZ21haWwuY29tPgpEYXRl
OiBTYXQsIDEwIE5vdiAyMDEyIDIyOjI0OjMwICswODAwClN1YmplY3Q6IFtQQVRDSF0gY3JlZGVu
dGlhbDogZG8gbm90IHJlY29nbml6ZSBhIGNyZWRlbnRpYWwgaGVscGVyIGlmIGNvbmZpZwogdmFs
dWUgaXMgZW1wdHkKClNpZ25lZC1vZmYtYnk6IFN1cCBZdXQgU3VtIDxjaDNjb29saUBnbWFpbC5j
b20+Ci0tLQogY3JlZGVudGlhbC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvY3JlZGVudGlhbC5jIGIvY3JlZGVudGlh
bC5jCmluZGV4IGU1NDc1M2MuLjE0ODllN2EgMTAwNjQ0Ci0tLSBhL2NyZWRlbnRpYWwuYworKysg
Yi9jcmVkZW50aWFsLmMKQEAgLTY0LDcgKzY0LDcgQEAgc3RhdGljIGludCBjcmVkZW50aWFsX2Nv
bmZpZ19jYWxsYmFjayhjb25zdCBjaGFyICp2YXIsIGNvbnN0IGNoYXIgKnZhbHVlLAogCQlrZXkg
PSBkb3QgKyAxOwogCX0KIAotCWlmICghc3RyY21wKGtleSwgImhlbHBlciIpKQorCWlmICghc3Ry
Y21wKGtleSwgImhlbHBlciIpICYmICp2YWx1ZSkKIAkJc3RyaW5nX2xpc3RfYXBwZW5kKCZjLT5o
ZWxwZXJzLCB2YWx1ZSk7CiAJZWxzZSBpZiAoIXN0cmNtcChrZXksICJ1c2VybmFtZSIpKSB7CiAJ
CWlmICghYy0+dXNlcm5hbWUpCi0tIAoxLjguMC5tc3lzZ2l0LjAKCg==
--485b390f7f405b51e704ce256f49--
