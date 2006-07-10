From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb.cgi: Create $git_temp if it doesn't exist
Date: Sun, 9 Jul 2006 20:07:27 -0700 (PDT)
Message-ID: <20060710030727.84377.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-690911044-1152500847=:84104"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jul 10 05:07:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzm7h-0006RU-A7
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 05:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWGJDH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 23:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWGJDH3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 23:07:29 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:34986 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161309AbWGJDH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 23:07:29 -0400
Received: (qmail 84379 invoked by uid 60001); 10 Jul 2006 03:07:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WObOG2JJ9A2JgVZE+hcZIu4m+H6izMdjx0YN6nASo8VcJCQPfhhK+gNlJAEK4YEJs9bbJojfzvQDio7CbJxjrWCzSW7Eht5doaVCQ9ll6Vy1E9MAIviHN4kZcchsDleB/h4pRj9G6ViE3ssPJps+wavdx2Kqi6j6wya8Pvp6z/g=  ;
Received: from [71.84.27.155] by web31804.mail.mud.yahoo.com via HTTP; Sun, 09 Jul 2006 20:07:27 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23583>

--0-690911044-1152500847=:84104
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Unless we'd done diffs, $git_temp doesn't exist and then
mime lookups fail.  Explicitly create it, if it doesn't
exist already.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
--0-690911044-1152500847=:84104
Content-Type: application/octet-stream; name="patch.patch"
Content-Transfer-Encoding: base64
Content-Description: 2829251161-patch.patch
Content-Disposition: attachment; filename="patch.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIuY2dpIGIvZ2l0d2ViL2dpdHdl
Yi5jZ2kKaW5kZXggNjc5ODk5MC4uZDM3ZjRjNiAxMDA3NTUKLS0tIGEvZ2l0
d2ViL2dpdHdlYi5jZ2kKKysrIGIvZ2l0d2ViL2dpdHdlYi5jZ2kKQEAgLTQx
LDYgKzQxLDkgQEAgaWYgKCRnaXRfdmVyc2lvbiA9fiBtL2dpdCB2ZXJzaW9u
ICguKikkLwogCiAjIGxvY2F0aW9uIGZvciB0ZW1wb3JhcnkgZmlsZXMgbmVl
ZGVkIGZvciBkaWZmcwogb3VyICRnaXRfdGVtcCA9ICIvdG1wL2dpdHdlYiI7
CitpZiAoISAtZCAkZ2l0X3RlbXApIHsKKyAgICBta2RpcigkZ2l0X3RlbXAs
IDA3MDApIHx8IGRpZV9lcnJvcigiQ291bGRuJ3QgbWtkaXIgJGdpdF90ZW1w
Iik7Cit9CiAKICMgdGFyZ2V0IG9mIHRoZSBob21lIGxpbmsgb24gdG9wIG9m
IGFsbCBwYWdlcwogb3VyICRob21lX2xpbmsgPSAkbXlfdXJpOwotLSAKMS40
LjEuZzM1ZGJkCgo=

--0-690911044-1152500847=:84104--
