From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] [COGITO] RPM: build in parallel on SMP systems
Date: Thu, 08 Dec 2005 19:37:16 -0800
Message-ID: <4398FBEC.6040800@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040200050500030903050307"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 04:37:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkZ4i-0007ve-TX
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 04:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVLIDha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 22:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVLIDh3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 22:37:29 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54956 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751269AbVLIDh3
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 22:37:29 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB93bGfM010554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Dec 2005 19:37:17 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13411>

This is a multi-part message in MIME format.
--------------040200050500030903050307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

asciidoc is hideously slow, so it's worth it to build in parallel on SMP 
hosts.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------040200050500030903050307
Content-Type: text/plain;
 name="cogito.smp.build"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cogito.smp.build"

ZGlmZiAtLWdpdCBhL2NvZ2l0by5zcGVjLmluIGIvY29naXRvLnNwZWMuaW4KaW5kZXggNTAx
YzUyZS4uN2MzYzkxZCAxMDA2NDQKLS0tIGEvY29naXRvLnNwZWMuaW4KKysrIGIvY29naXRv
LnNwZWMuaW4KQEAgLTIyLDcgKzIyLDcgQEAgbWFueSBvdGhlciB2ZXJzaW9uIGNvbnRyb2wg
c3lzdGVtcy4KIAogJWJ1aWxkCiAKLW1ha2UgYWxsIGRvYworbWFrZSAle19zbXBfbWZsYWdz
fSBhbGwgZG9jCiAKICVpbnN0YWxsCiBybSAtcmYgJFJQTV9CVUlMRF9ST09UCkBAIC00Miw2
ICs0Miw5IEBAIHJtIC1yZiAkUlBNX0JVSUxEX1JPT1QKICVkb2MgUkVBRE1FIENPUFlJTkcg
RG9jdW1lbnRhdGlvbi90dXRvcmlhbC1zY3JpcHQKIAogJWNoYW5nZWxvZworKiBUaHUgRGVj
IDggMjAwNSBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4KKy0gYWRkICV7X3NtcF9t
ZmxhZ3N9CisKICogVHVlIE5vdiAxIDIwMDUgUGF2ZWwgUm9za2luIDxwcm9za2lAZ251Lm9y
Zz4gMC4xNS4xLTEKIC0gZ2VuZXJhdGUgYW5kIGluY2x1ZGUgbWFudWFscwogCg==
--------------040200050500030903050307--
