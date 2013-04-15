From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 0/4] Some small fixes to glossary-content.txt
Date: Mon, 15 Apr 2013 19:45:02 +0200 (CEST)
Message-ID: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 19:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnSq-0006BL-7j
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab3DORpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:45:05 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:56944 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768Ab3DORpD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 13:45:03 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 4CAC9AA879;
	Mon, 15 Apr 2013 19:45:02 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 3FFED1F6003;
	Mon, 15 Apr 2013 19:45:02 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 35F081AB32B;
	Mon, 15 Apr 2013 19:45:02 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 35F081AB32B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1366047902; bh=sAnL1QjEUEJw0jODfr0+IOD9Ya58Zk8Sdj7PTIsHGis=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=bN8Wi91qssS8H3LNzCrNKzeX1Ndby/j5LUI2F/pT1sLcT5XVxt1FV/hiU482o7WlX
	 IDNKiy6xWyUaY6bUsTXV4WFH3mQJEkF6bAqaZInFiD0iEIsgGNqQvtUNJXAdIyXfUO
	 Rzdyr6wD4ynV/seyB2IpYigZulVy6lx0Mw4avq3Y=
Received: from [188.105.109.185] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Mon, 15 Apr 2013 19:45:01 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.109.185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221268>

This is another reroll of my patches for glossary-content.txt.

- The first patch is the same as in v2.
- The second patch only adds the log message which Junio suggested and a missing full stop.
- The third patch is new and is a direct consequence of the second patch.
- In the fourth patch there is an explanation in the log message why the exact definition of 
  "refspec" can be omitted in the glossary. The definition of "pathspec" is kept in the glossary; 
  there are only small improvements to wording and formatting.

[PATCH v3 1/4] glossary: remove outdated/misleading/irrelevant entries
[PATCH v3 2/4] glossary: improve description of SHA-1 related topics
[PATCH v3 3/4] The name of the hash function is "SHA-1", not "SHA1"
[PATCH v3 4/4] glossary: improve definitions of refspec and pathspec


---
Thomas
