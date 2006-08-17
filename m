From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: bugfix: commitdiff regression
Date: Thu, 17 Aug 2006 13:52:09 -0700 (PDT)
Message-ID: <20060817205209.98624.qmail@web31801.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1111093236-1155847929=:96634"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 17 22:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDoqe-0000GO-1e
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 22:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWHQUwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 16:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWHQUwM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 16:52:12 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:26483 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932216AbWHQUwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 16:52:10 -0400
Received: (qmail 98626 invoked by uid 60001); 17 Aug 2006 20:52:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZFyGkDT4lF6et8RD2HMK5dUtgifkuestcA5526tnYRRrM3lrb12F4cf3i8GJ21YUDR4uKCIBg2LMg80GOWMfXxyjex2T06fB5Zmbp/p8jH1jX5wk/E15XFQ8AFSDZkOOStWLMKiBJAbBw0dpB3Emuj+DOWeZyIQCJVidajycN2I=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Thu, 17 Aug 2006 13:52:09 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25613>

--0-1111093236-1155847929=:96634
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Fix regression in git_commitdiff() introduced
by commit 756d2f064b2419fcdf9cd9c851f352e2a4f75103.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
--0-1111093236-1155847929=:96634
Content-Type: application/octet-stream; name="px.patch"
Content-Transfer-Encoding: base64
Content-Description: 2038685703-px.patch
Content-Disposition: attachment; filename="px.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3
ZWIucGVybAppbmRleCBiYjc3YjU1Li5iOTczNDJmIDEwMDc1NQotLS0gYS9n
aXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBA
IC0yNDE0LDcgKzI0MTQsNyBAQCBzdWIgZ2l0X2NvbW1pdGRpZmYgewogCQkJ
CSAgICAgICRjZ2ktPmEoey1ocmVmID0+IGhyZWYoYWN0aW9uPT4iYmxvYiIs
IGhhc2g9PiRmcm9tX2lkLCBoYXNoX2Jhc2U9PiRoYXNoX3BhcmVudCwgZmls
ZV9uYW1lPT4kZmlsZSl9LCAkZnJvbV9pZCkgLgogCQkJCSAgICAgICIgLT4g
IiAuCiAJCQkJICAgICAgZmlsZV90eXBlKCR0b19tb2RlKSAuICI6IiAuCi0J
CQkJICAgICAgJGNnaS0+YSh7LWhyZWYgPT4gaHJlZihhY3Rpb249PiJibG9i
IiwgaGFzaD0+JHRvX2lkLCBoYXNoX2Jhc2U9PiRoYXNoLCBmaWxlX25hbWU9
PiRmaWxlKX0sICR0b19pZCkgLgorCQkJCSAgICAgICRjZ2ktPmEoey1ocmVm
ID0+IGhyZWYoYWN0aW9uPT4iYmxvYiIsIGhhc2g9PiR0b19pZCwgaGFzaF9i
YXNlPT4kaGFzaCwgZmlsZV9uYW1lPT4kZmlsZSl9LCAkdG9faWQpOwogCQkJ
CXByaW50ICI8L2Rpdj5cbiI7CiAJCQkJZ2l0X2RpZmZfcHJpbnQoJGZyb21f
aWQsICJhLyRmaWxlIiwgICR0b19pZCwgImIvJGZpbGUiKTsKIAkJCX0KLS0g
CjEuNC4yLmc3NWMwMQoK

--0-1111093236-1155847929=:96634--
