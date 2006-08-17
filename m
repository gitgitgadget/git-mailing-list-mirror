From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: bugfix: commitdiff regression
Date: Thu, 17 Aug 2006 15:00:37 -0700 (PDT)
Message-ID: <20060817220037.22377.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-474360680-1155852037=:22315"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Aug 18 00:00:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDpus-0005np-Fr
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 00:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWHQWAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 18:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWHQWAj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 18:00:39 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:31871 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030208AbWHQWAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 18:00:38 -0400
Received: (qmail 22379 invoked by uid 60001); 17 Aug 2006 22:00:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lGTC91gdAJvvdJxcuPdt+ZwoQA8F0KxTzZNozf3jbI5NSL5zeMu76GrJLX7bTuBgTBAd8QRFly2igTLwINicUhN0M8nG7yOu0Dd7Jw4Paru9X5zR6qw73d8PTytyQoXzZkMm9pNgZtkPX2o8zmQxtY6LVZWGA51fhWo7qkj+lg8=  ;
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Thu, 17 Aug 2006 15:00:37 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25614>

--0-474360680-1155852037=:22315
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

--0-474360680-1155852037=:22315
Content-Type: application/octet-stream; name="px.patch"
Content-Transfer-Encoding: base64
Content-Description: pat387950892
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

--0-474360680-1155852037=:22315--
