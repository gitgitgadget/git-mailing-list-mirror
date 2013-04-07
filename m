From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v2 0/3] Some small fixes to glossary-content.txt
Date: Sun, 7 Apr 2013 17:06:37 +0200 (CEST)
Message-ID: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 17:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrB5-00087f-U5
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933891Ab3DGPGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:06:40 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:32986 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933885Ab3DGPGj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 11:06:39 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 668E22D629E;
	Sun,  7 Apr 2013 17:06:37 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 6277D6F2CDD;
	Sun,  7 Apr 2013 17:06:37 +0200 (CEST)
Received: from webmail09.arcor-online.net (webmail09.arcor-online.net [151.189.8.45])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 622B1107852;
	Sun,  7 Apr 2013 17:06:37 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 622B1107852
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1365347197; bh=CAmq/QKGDwuZtneJXnrz+vXzrGCQyf2YZ8WoFCHmnbM=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=ERO+OvR8M8oAMqjYHQaLX/nW8yOl5kKBmAP2FupPvH15hlAO8DNrhmH2x6xLe7YDF
	 c4s8yk0aSWx+ZvobWREarjl3xYFHIw6kBsrCLrGdTg3qIcT9YCYBn5P60hAmLtyItF
	 QzF1q9eUzc248+Z3kRhwvKX7whAVevsAWoTm2UlY=
Received: from [188.98.233.28] by webmail09.arcor-online.net (151.189.8.45) with HTTP (Arcor Webmail); Sun, 7 Apr 2013 17:06:37 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.233.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220312>

This is a reroll of my patches for glossary-content.txt
with Junio's comments/suggestions included:

[PATCH 1/3] glossary: remove outdated/misleading/irrelevant entries
- keep entries for "directory" and "evil merge"
- keep comparison of "Git tag" to "Lisp tag"
[PATCH 2/3] glossary: improve description of SHA-1 related topics
- more suitable description for "object name"
- use "SHA-1" instead of "SHA1"
[PATCH 3/3] glossary: remove definition of refspec and pathspec
- further small changes to description of refspec and pathspec


---
Thomas
