From: Oren Held <oren@held.org.il>
Subject: [PATCH] (trivial) Doc: git fetch: add -p to options list
Date: Mon, 12 Jul 2010 18:44:24 +0300
Message-ID: <4C3B3858.9070008@held.org.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 12 17:45:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYLC0-0004X5-7m
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 17:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203Ab0GLPpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 11:45:08 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:39018 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab0GLPpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 11:45:06 -0400
Received: from homiemail-a29.g.dreamhost.com (caiajhbdccah.dreamhost.com [208.97.132.207])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 8336E17B18B
	for <git@vger.kernel.org>; Mon, 12 Jul 2010 08:45:06 -0700 (PDT)
Received: from homiemail-a29.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a29.g.dreamhost.com (Postfix) with ESMTP id BDCD6674082
	for <git@vger.kernel.org>; Mon, 12 Jul 2010 08:44:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=held.org.il; h=message-id:date
	:from:mime-version:to:subject:content-type:
	content-transfer-encoding; q=dns; s=held.org.il; b=QPIsD9rfnA3d4
	JWsaiJwFxPO1ZWv6vPGfiuEAwqEJWkQjusyJVom5DaUiybmJ7VfBbCMBqsVDnbzM
	cWe/7cij+qSMXlMULL64RF0pZL1sYIvzWDaiCeHuecG3eMMDBUu6G2Lm5YT0IsUe
	AZ24LVGnf+/tdZcNZrFKRM6/1A1lnU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=held.org.il; h=message-id
	:date:from:mime-version:to:subject:content-type:
	content-transfer-encoding; s=held.org.il; bh=ZNcyPueVj8v6XPMJ/uD
	bKHvd+MU=; b=fnO4owI1qdCSOxxOsc0nUXP//AhXg3R6jY74L7DLB8DALspJQxx
	ro9ftyhueLSAtys6PV/UGWDd5oOhTESp26IphB6WCW6/LRjiisDiGev5tMu+MIk6
	Rxiewk+M+R3mv42WDcrtsgKHsuBHZPNj6r0sy8AFUqBWZL3GZBTj5z+g=
Received: from [9.151.133.140] (nesher3.haifa.il.ibm.com [192.114.107.4])
	(Authenticated sender: oren@held.org.il)
	by homiemail-a29.g.dreamhost.com (Postfix) with ESMTPA id 3389567407B
	for <git@vger.kernel.org>; Mon, 12 Jul 2010 08:44:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Lightning/1.0b1 Icedove/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150822>

It's acting the same as --prune, yet undocumented.
---
  Documentation/fetch-options.txt |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt 
b/Documentation/fetch-options.txt
index 044ec88..9333c42 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -34,6 +34,7 @@ ifndef::git-pull[]
  	Allow several <repository> and <group> arguments to be
  	specified. No <refspec>s may be specified.
  +-p::
  --prune::
  	After fetching, remove any remote tracking branches which
  	no longer exist	on the remote.
-- 
1.7.1
