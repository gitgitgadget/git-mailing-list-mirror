From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] Parallelize building rpm
Date: Mon, 26 Sep 2005 19:48:39 -0700
Message-ID: <4338B307.7010405@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000904080108050004080404"
X-From: git-owner@vger.kernel.org Tue Sep 27 04:50:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK5XH-0006XF-7D
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 04:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVI0Csu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 22:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVI0Csu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 22:48:50 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:38863 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S964798AbVI0Cst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 22:48:49 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8R2mkJv014350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Sep 2005 19:48:47 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9363>

This is a multi-part message in MIME format.
--------------000904080108050004080404
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Allow parallelization of rpm build by adding %{_smp_mflags} to the 
specfile.  The absence of this macro in a specfile means a make should 
not be parallelized.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------000904080108050004080404
Content-Type: text/plain;
 name="git-makej-patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-makej-patch"

Ci0tLQpjb21taXQgYjhkNWRmZWRlNThjNmU3ODdiMDZlZGY5YTE3OWI1NDg3NmVmMDRkYgp0
cmVlIGZiNWY2ZWFiYmMxY2Y5YzU3ZjBkNmMyZjUyZGIzMzRmYWE3MDQyNjkKcGFyZW50IDRh
ZTk1NjgyNjk0YTFjZDA1ZWUyMDI5ZmUyNDFhZDkwZDQzYzhjMGUKYXV0aG9yIEguIFBldGVy
IEFudmluIDxocGFAaGVyYS5rZXJuZWwub3JnPiBNb24sIDI2IFNlcCAyMDA1IDE5OjQzOjI0
IC0wNzAwCmNvbW1pdHRlciBILiBQZXRlciBBbnZpbiA8aHBhQGhlcmEua2VybmVsLm9yZz4g
TW9uLCAyNiBTZXAgMjAwNSAxOTo0MzoyNCAtMDcwMAoKIGdpdC1jb3JlLnNwZWMuaW4gfCAg
ICA3ICsrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1jb3JlLnNwZWMuaW4gYi9naXQtY29yZS5zcGVj
LmluCi0tLSBhL2dpdC1jb3JlLnNwZWMuaW4KKysrIGIvZ2l0LWNvcmUuc3BlYy5pbgpAQCAt
MjMsMTIgKzIzLDEyIEBAIGVsc2V3aGVyZSBmb3IgdG9vbHMgZm9yIG9yZGluYXJ5IGh1bWFu
cyAKICVzZXR1cCAtcQogCiAlYnVpbGQKLW1ha2UgQ09QVFM9IiRSUE1fT1BUX0ZMQUdTIiBX
SVRIX09XTl9TVUJQUk9DRVNTX1BZPVllc1BsZWFzZSBcCittYWtlICV7X3NtcF9tZmxhZ3N9
IENPUFRTPSIkUlBNX09QVF9GTEFHUyIgV0lUSF9PV05fU1VCUFJPQ0VTU19QWT1ZZXNQbGVh
c2UgXAogICAgICBwcmVmaXg9JXtfcHJlZml4fSBhbGwgJXshP193aXRob3V0X2RvY3M6IGRv
Y30KIAogJWluc3RhbGwKIHJtIC1yZiAkUlBNX0JVSUxEX1JPT1QKLW1ha2UgREVTVERJUj0k
UlBNX0JVSUxEX1JPT1QgV0lUSF9PV05fU1VCUFJPQ0VTU19QWT1ZZXNQbGVhc2UgXAorbWFr
ZSAle19zbXBfbWZsYWdzfSBERVNURElSPSRSUE1fQlVJTERfUk9PVCBXSVRIX09XTl9TVUJQ
Uk9DRVNTX1BZPVllc1BsZWFzZSBcCiAgICAgIHByZWZpeD0le19wcmVmaXh9IG1hbmRpcj0l
e19tYW5kaXJ9IFwKICAgICAgaW5zdGFsbCAleyE/X3dpdGhvdXRfZG9jczogaW5zdGFsbC1k
b2N9CiAKQEAgLTQ1LDYgKzQ1LDkgQEAgcm0gLXJmICRSUE1fQlVJTERfUk9PVAogJXshP193
aXRob3V0X2RvY3M6ICV7X21hbmRpcn0vbWFuNy8qLjcqfQogCiAlY2hhbmdlbG9nCisqIE1v
biBTZXAgMjYgMjAwNSBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4KKy0gYWRkICV7
X3NtcF9tZmxhZ3N9CisKICogRnJpIFNlcCAxNiAyMDA1IENocmlzIFdyaWdodCA8Y2hyaXN3
QG9zZGwub3JnPiAwLjk5LjYtMQogLSB1cGRhdGUgdG8gMC45OS42CiAK
--------------000904080108050004080404--
