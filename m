From: Jerald Fitzjerald <jfj@freemail.gr>
Subject: Re: [PATCH] missing return
Date: Wed, 30 May 2007 12:16:45 -0700
Message-ID: <465DCD9D.5090501@freemail.gr>
References: <465D709E.7040402@freemail.gr> <7vk5uq2pio.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 21:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtTcs-0004JD-Vb
	for gcvg-git@gmane.org; Wed, 30 May 2007 21:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXE3TOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 15:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbXE3TOX
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 15:14:23 -0400
Received: from aiolos.otenet.gr ([195.170.0.93]:59391 "EHLO aiolos.otenet.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbXE3TOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 15:14:22 -0400
Received: from [85.75.200.190] (athedsl-168224.home.otenet.gr [85.75.200.190])
	by aiolos.otenet.gr (8.13.8/8.13.8/Debian-3) with ESMTP id l4UJEBI3023834;
	Wed, 30 May 2007 22:14:17 +0300
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
In-Reply-To: <7vk5uq2pio.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48782>

Junio C Hamano wrote:

>I realize that I've seen this pointed out by somebody already.
>
It was suggested on irc a couple of days ago.

Signed-off-by: Jerald Fitzjerald <jfj@freemail.gr>

---

diff --git a/base85.c b/base85.c
--- a/base85.c
+++ b/base85.c
@@ -66,7 +66,7 @@ int decode_85(char *dst, const char *buf
		 */
		if (0x03030303 < acc ||
		    0xffffffff - de < (acc *= 85))
-			error("invalid base85 sequence %.5s", buffer-5);
+			return error("invalid base85 sequence %.5s", buffer-5);
		acc += de;
		say1(" %08x", acc);
