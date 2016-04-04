From: Ivan Pozdeev <vano@mail.mipt.ru>
Subject: Re: [PATCH] comment for a long #ifdef
Date: Mon, 4 Apr 2016 20:23:37 +0300
Message-ID: <5702A319.9030708@mail.mipt.ru>
References: <CAPig+cS=oGvs3zWA782APy7moo3N-4-Oe9B8obej5oWKxw9Gsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 19:23:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8EA-00048u-E1
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbcDDRXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:23:45 -0400
Received: from relay2.telecom.mipt.ru ([81.5.91.6]:44032 "EHLO
	relay2.telecom.mipt.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbcDDRXo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:23:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by relay2.telecom.mipt.ru (Postfix) with ESMTP id C9B2C127052
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 20:23:41 +0300 (MSK)
X-Virus-Scanned: Debian amavisd-new at relay2.telecom.mipt.ru
Received: from relay2.telecom.mipt.ru ([127.0.0.1])
	by localhost (relay2.telecom.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NsaVhVZujFv0 for <git@vger.kernel.org>;
	Mon,  4 Apr 2016 20:23:40 +0300 (MSK)
Received: from mail.mipt.ru (mail.mipt.ru [81.5.91.32])
	by relay2.telecom.mipt.ru (Postfix) with ESMTPS id 6E146127050
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 20:23:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mipt.ru; s=mail;
	t=1459790620; i=@mipt.ru;
	bh=xDyNhKZZEudwHgQnvGx1hMaB/c374q2fNMAXMEPO1DU=;
	h=From:Subject:To:References:Date:In-Reply-To:From;
	b=Y2RZGZxMllk93/S7Eb1kxVAvHSI9Ogo2AeyzBXVo/ZiuPYwJv4FynUhDYp/pfLcwf
	 EwWnC++pnTKrOnrm0I562g4OLdoTnO9EyIe+fQ2kmkX1ycxsJ5oCW+3DZNH1c8W4G5
	 QNfDut7/UOr8UERYE+/tEpVE47OPR35uUSfib9lA=
Received: from mail.mipt.ru (localhost [127.0.0.1])
	by mail.mipt.ru (Postfix) with ESMTPS id D0CFEB4C943
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 20:23:38 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.mipt.ru (Postfix) with ESMTP id C4FA2B4C913
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 20:23:38 +0300 (MSK)
Received: from mail.mipt.ru ([127.0.0.1])
	by localhost (mail.mipt.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y4sZviu_BDqj for <git@vger.kernel.org>;
	Mon,  4 Apr 2016 20:23:38 +0300 (MSK)
Received: from [100.78.48.129] (unknown [82.208.127.239])
	by mail.mipt.ru (Postfix) with ESMTPSA id AAA9FB4C8F9
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 20:23:38 +0300 (MSK)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAPig+cS=oGvs3zWA782APy7moo3N-4-Oe9B8obej5oWKxw9Gsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290702>

Signed-off-by: Ivan Pozdeev
---
compat/poll/poll.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index db4e03e..5eb0280 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -441,7 +441,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
}

return rc;
-#else
+#else /* #ifndef WIN32_NATIVE */
static struct timeval tv0;
static HANDLE hEvent;
WSANETWORKEVENTS ev;
@@ -622,5 +622,5 @@ restart:
}

return rc;
-#endif
+#endif /* #ifndef WIN32_NATIVE */
}
-- 
1.9.5.msysgit.1


-- 
Regards,
Ivan
