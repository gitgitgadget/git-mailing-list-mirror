From: =?UTF-8?B?5a2Z5Lm+56iL?= <sunqiancheng0644@126.com>
Subject: Git for Windows crashes on Windows 10
Date: Wed, 3 Feb 2016 13:28:09 +0800 (CST)
Message-ID: <34a86972.3610.152a59a27d0.Coremail.sunqiancheng0644@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 06:59:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQqTG-0002Sm-Ck
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 06:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613AbcBCF7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 00:59:14 -0500
Received: from m15-54.126.com ([220.181.15.54]:43057 "EHLO m15-54.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468AbcBCF7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 00:59:13 -0500
X-Greylist: delayed 1859 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2016 00:59:12 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=SBCq2
	m+677D7iPmn2za5dcAh4+J0SfQB1n6nw05RDy0=; b=U3anxmaWyblT8iT3wVs4O
	DQQ6Usbw+3kSM4kfS0DkgWeNEIjXzB8MlxOKZPE5gwDXoDL9Q5SMsqLOX8BkUb/7
	Q1ZfcfkJdyouUiBtJiDPF7Aqc1JihvRPFpYO8F5KZcJzPPJ3DZC4zctWxkPAqZ8b
	kFciJk4+j8oAO/XHyTvleo=
Received: from sunqiancheng0644$126.com ( [117.147.183.81, 176.34.62.243,
 10.144.1.72] ) by ajax-webmail-wmsvr54 (Coremail) ; Wed, 3 Feb 2016
 13:28:09 +0800 (CST)
X-Originating-IP: [117.147.183.81, 176.34.62.243, 10.144.1.72]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20150911(74783.7961) Copyright (c) 2002-2016 www.mailtech.cn 126com
X-CM-TRANSID: NsqowAAn0g3qj7FWidoaAA--.11277W
X-CM-SenderInfo: 5vxq1xxdqfxvdqjqlkau6rjloofrz/1tbi4xoDflUw2o3eyQACsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285334>

SSdtIG5vdCBhIG5hdGl2ZSBFbmdsaXNoIHNwZWFrZXIuIEknbSBzb3JyeSBpZiBJIGRpZG4ndCBl
eHBsYWluIHRoZSBwcm9ibGVtIGNsZWFybHkuCkknbSB1c2luZyBXaW5kb3dzIDEwIEVudGVycHJp
c2UgSW5zaWRlciBQcmV2aWV3IChJJ2xsIHVzZSBXaW4xMCBpbnN0ZWFkIGJlbG93KS4gVW50aWwg
eWVzdGVyZGF5LCBJJ20gdXNpbmcgV2luMTAgYnVpbGQgMTExMDIsIGFuZCBHaXQgZm9yIFdpbmRv
d3Mgd29ya3Mgd2VsbC4gQnV0IHRvZGF5IEkgdXBncmFkZWQgbXkgc3lzdGVtIHRvIFdpbjEwIGJ1
aWxkIDE0MjUxLCB0aGVuIHNvbWV0aGluZyB3cm9uZyBoYXBwZW5lZC4KSSBvcGVuZWQgYSAiY21k
IiBpbiBteSByZXBvc2l0b3J5IGFuZCBlbnRlcmVkICJnaXQgcHVsbCIsIHRoZW4gYSBkaWFsb2cg
d2luZG93IGFwcGVhcmVkLCBzYXlpbmcgIkdpdCBmb3IgV2luZG93cyBoYXMgc3RvcHBlZCB3b3Jr
aW5nIi4KVGhlIHZlcnNpb24gb2YgdGhlIGdpdCBvbiBteSBzeXN0ZW0gd2FzIDIuNi40LCBhbmQg
SSBmb3VuZCBvdXQgdGhhdCB0aGUgbGF0ZXN0IHZlcnNpb24gd2FzIDIuNy4wLjIuIFNvIEkgZG93
bmxvYWRlZCBhIGluc3RhbGxlciBmcm9tICJodHRwczovL2dpdC1zY20uY29tLyIuIEkgb3BlbmVk
IHRoZSBpbnN0YWxsZXIsIGJ1dCBhcyBzb29uIGFzIHRoZSBpbnN0YWxsYXRpb24gZmluaXNoZWQs
IHRoZSBzYW1lIGVycm9yIGRpYWxvZyBhcHBlYXJlZC4gSSBjbG9zZWQgdGhlIGRpYWxvZywgYnV0
IGl0IGFwcGVhcmVkIGFnYWluLCBzbyBJIGNsb3NlZCBpdCBhZ2Fpbi7CoEkgb3BlbmVkIGEgImNt
ZCIgYW5kIGVudGVyZWQgImdpdCIsIG9mIGNvdXJzZSwgaXQgY3Jhc2hlcyBhbmQgdGhlIGVycm9y
IGRpYWxvZyBhcHBlYXJlZC4KQnkgdGhlIHdheSwgSSBpbnN0YWxsZWQgR2l0SHViIGZvciBXaW5k
b3dzIG9uIG15IHN5c3RlbSBhbmQgaXQgY3Jhc2hlcyB0b28gd2hlbiBJIHByZXNzZWQgdGhlICJT
eW5jIiBidXR0b24gaW4gaXQuCkluIG15IHN1cnByaXNlLCBHaXRIdWIgRXh0ZW5zaW9uIGZvciBW
aXN1YWwgU3R1ZGlvIHdvcmtzIGNvcnJlY3RseS4KCg==
