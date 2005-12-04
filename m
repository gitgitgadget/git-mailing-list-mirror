From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] A few more options for git-cat-file
Date: Sat, 03 Dec 2005 17:57:48 -0800
Message-ID: <43924D1C.8070306@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070003070409070109030807"
X-From: git-owner@vger.kernel.org Sun Dec 04 02:58:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eij8m-0004FD-7B
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 02:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVLDB56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 20:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVLDB56
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 20:57:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:25280 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751312AbVLDB55
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 20:57:57 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB41vnKl020105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 17:57:49 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13172>

This is a multi-part message in MIME format.
--------------070003070409070109030807
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This adds the following options to git-cat-file:

-n, to get the canonical name of a resource.  This is for one thing 
useful in tagging scripts.

-e, to test for the existence of a file.

This also cleans up the option-parsing in git-cat-file slightly.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>


--------------070003070409070109030807
Content-Type: text/plain;
 name="git-cat-enhancements"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-cat-enhancements"

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ2l0LWNhdC1maWxlLnR4dCBiL0RvY3VtZW50
YXRpb24vZ2l0LWNhdC1maWxlLnR4dAppbmRleCBhYjRkY2FlLi5hNTllNTEzIDEwMDY0NAot
LS0gYS9Eb2N1bWVudGF0aW9uL2dpdC1jYXQtZmlsZS50eHQKKysrIGIvRG9jdW1lbnRhdGlv
bi9naXQtY2F0LWZpbGUudHh0CkBAIC04LDcgKzgsNyBAQCBnaXQtY2F0LWZpbGUgLSBQcm92
aWRlIGNvbnRlbnQgb3IgdHlwZSBpCiAKIFNZTk9QU0lTCiAtLS0tLS0tLQotJ2dpdC1jYXQt
ZmlsZScgKC10IHwgLXMgfCA8dHlwZT4pIDxvYmplY3Q+CisnZ2l0LWNhdC1maWxlJyAoLXQg
fCAtcyB8IC1uIHwgLWUgfCA8dHlwZT4pIDxvYmplY3Q+CiAKIERFU0NSSVBUSU9OCiAtLS0t
LS0tLS0tLQpAQCAtMjksNiArMjksMTMgQEAgT1BUSU9OUwogCUluc3RlYWQgb2YgdGhlIGNv
bnRlbnQsIHNob3cgdGhlIG9iamVjdCBzaXplIGlkZW50aWZpZWQgYnkKIAk8b2JqZWN0Pi4K
IAorLW46OgorCUluc3RlYWQgb2YgdGhlIGNvbnRlbnQsIHNob3cgdGhlIGNhbm9uY2ljYWwg
bmFtZSBvZiA8b2JqZWN0Pi4KKworLWU6OgorCVN1cHByZXNzIGFsbCBvdXRwdXQ7IGluc3Rl
YWQgZXhpdCB3aXRoIHplcm8gc3RhdHVzIGlmIDxvYmplY3Q+CisJZXhpc3RzIGFuZCBpcyBh
IHZhbGlkIG9iamVjdC4KKwogPHR5cGU+OjoKIAlUeXBpY2FsbHkgdGhpcyBtYXRjaGVzIHRo
ZSByZWFsIHR5cGUgb2YgPG9iamVjdD4gYnV0IGFza2luZwogCWZvciBhIHR5cGUgdGhhdCBj
YW4gdHJpdmlhbGx5IGJlIGRlcmVmZXJlbmNlZCBmcm9tIHRoZSBnaXZlbgpAQCAtMzksOCAr
NDYsMTQgQEAgT1BUSU9OUwogCiBPVVRQVVQKIC0tLS0tLQotSWYgJy10JyBpcyBzcGVjaWZp
ZWQsIG9uZSBvZiB0aGUgPHR5cGU+LiAgSWYgJy1zJyBpcyBzcGVjaWZpZWQsCi10aGUgc2l6
ZSBvZiB0aGUgPG9iamVjdD4gaW4gYnl0ZXMuCitJZiAnLXQnIGlzIHNwZWNpZmllZCwgb25l
IG9mIHRoZSA8dHlwZT4uCisKK0lmICctcycgaXMgc3BlY2lmaWVkLCB0aGUgc2l6ZSBvZiB0
aGUgPG9iamVjdD4gaW4gYnl0ZXMuCisKK0lmICctbicgaXMgc3BlY2lmaWVkLCB0aGUgY2Fu
b25jaWFsIG5hbWUgKDQwLWNoYXJhY3RlciBTSEExCitoZXhhZGVjaW1hbCBzdHJpbmcpIG9m
IHRoZSBvYmplY3QuCisKK0lmICctZScgaXMgc3BlY2lmaWVkLCBubyBvdXRwdXQuCiAKIE90
aGVyd2lzZSB0aGUgcmF3ICh0aG91Z2ggdW5jb21wcmVzc2VkKSBjb250ZW50cyBvZiB0aGUg
PG9iamVjdD4gd2lsbAogYmUgcmV0dXJuZWQuCmRpZmYgLS1naXQgYS9jYXQtZmlsZS5jIGIv
Y2F0LWZpbGUuYwppbmRleCBkNzc1YTE1Li4yM2ZiZDI4IDEwMDY0NAotLS0gYS9jYXQtZmls
ZS5jCisrKyBiL2NhdC1maWxlLmMKQEAgLTExLDI3ICsxMSw0OCBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqKmFyZ3YpCiAJY2hhciB0eXBlWzIwXTsKIAl2b2lkICpidWY7CiAJdW5z
aWduZWQgbG9uZyBzaXplOworCWludCBvcHQ7CiAKIAlzZXR1cF9naXRfZGlyZWN0b3J5KCk7
CiAJaWYgKGFyZ2MgIT0gMyB8fCBnZXRfc2hhMShhcmd2WzJdLCBzaGExKSkKLQkJdXNhZ2Uo
ImdpdC1jYXQtZmlsZSBbLXQgfCAtcyB8IDx0eXBlPl0gPHNoYTE+Iik7CisJCXVzYWdlKCJn
aXQtY2F0LWZpbGUgWy10fC1zfC1ufC1lfDx0eXBlPl0gPHNoYTE+Iik7CiAKLQlpZiAoIXN0
cmNtcCgiLXQiLCBhcmd2WzFdKSB8fCAhc3RyY21wKCItcyIsIGFyZ3ZbMV0pKSB7Ci0JCWlm
ICghc2hhMV9vYmplY3RfaW5mbyhzaGExLCB0eXBlLAotCQkJCSAgICAgIGFyZ3ZbMV1bMV0g
PT0gJ3MnID8gJnNpemUgOiBOVUxMKSkgewotCQkJc3dpdGNoIChhcmd2WzFdWzFdKSB7Ci0J
CQljYXNlICd0JzoKLQkJCQlwcmludGYoIiVzXG4iLCB0eXBlKTsKLQkJCQlicmVhazsKLQkJ
CWNhc2UgJ3MnOgotCQkJCXByaW50ZigiJWx1XG4iLCBzaXplKTsKLQkJCQlicmVhazsKLQkJ
CX0KKwlvcHQgPSAwOworCWlmICggYXJndlsxXVswXSA9PSAnLScgKSB7CisJCW9wdCA9IGFy
Z3ZbMV1bMV07CisJCWlmICggIW9wdCB8fCBhcmd2WzFdWzJdICkKKwkJCW9wdCA9IC0xOyAv
KiBOb3QgYSBzaW5nbGUgY2hhcmFjdGVyIG9wdGlvbiAqLworCX0KKworCWJ1ZiA9IE5VTEw7
CisJc3dpdGNoIChvcHQpIHsKKwljYXNlICduJzoKKwkJcHJpbnRmKCIlc1xuIiwgc2hhMV90
b19oZXgoc2hhMSkpOworCQlyZXR1cm4gMDsKKworCWNhc2UgJ3QnOgorCQlpZiAoIXNoYTFf
b2JqZWN0X2luZm8oc2hhMSwgdHlwZSwgTlVMTCkpIHsKKwkJCXByaW50ZigiJXNcbiIsIHR5
cGUpOwogCQkJcmV0dXJuIDA7CiAJCX0KLQkJYnVmID0gTlVMTDsKLQl9IGVsc2UgeworCQli
cmVhazsKKworCWNhc2UgJ3MnOgorCQlpZiAoIXNoYTFfb2JqZWN0X2luZm8oc2hhMSwgdHlw
ZSwgJnNpemUpKSB7CisJCQlwcmludGYoIiVsdVxuIiwgc2l6ZSk7CisJCQlyZXR1cm4gMDsK
KwkJfQorCQlicmVhazsKKworCWNhc2UgJ2UnOgorCQlyZXR1cm4gIWhhc19zaGExX2ZpbGUo
c2hhMSk7CisKKwljYXNlIDA6CiAJCWJ1ZiA9IHJlYWRfb2JqZWN0X3dpdGhfcmVmZXJlbmNl
KHNoYTEsIGFyZ3ZbMV0sICZzaXplLCBOVUxMKTsKKwkJYnJlYWs7CisKKwlkZWZhdWx0Ogor
CQlkaWUoImdpdC1jYXQtZmlsZTogdW5rbm93biBvcHRpb246ICVzXG4iLCBhcmd2WzFdKTsK
IAl9CiAKIAlpZiAoIWJ1ZikK
--------------070003070409070109030807--
