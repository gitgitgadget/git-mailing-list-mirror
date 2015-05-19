From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] help.c: mark a file-local function static
Date: Tue, 19 May 2015 20:15:55 +0100
Message-ID: <555B8BEB.1050103@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: sebastien.guimmara@gmail.com
X-From: git-owner@vger.kernel.org Tue May 19 21:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yumzs-0007TT-FS
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbbESTQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 15:16:08 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:56965 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbbESTQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:16:06 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id C9175A0C08F;
	Tue, 19 May 2015 20:16:01 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 75D42A0C08C;
	Tue, 19 May 2015 20:16:01 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Tue, 19 May 2015 20:16:00 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269387>


Commit 4f671d74 ("help: respect new common command grouping",
18-05-2015) adds the 'cmd_group_cmp' funtion as an external
symbol.

Noticed by sparse. ("'cmd_group_cmp' was not declared. Should it
be static?")

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Sebastien,

If you need to re-roll the patches in your 'sg/help-group' branch,
could you please squash this into the relevant patch (commit 4f671d74).

Thanks!

ATB,
Ramsay Jones

 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 71027b7..7881ab7 100644
--- a/help.c
+++ b/help.c
@@ -218,7 +218,7 @@ void list_commands(unsigned int colopts,
 	}
 }
 
-int cmd_group_cmp(const void *elem1, const void *elem2)
+static int cmd_group_cmp(const void *elem1, const void *elem2)
 {
 	const struct cmdname_help *e1 = elem1;
 	const struct cmdname_help *e2 = elem2;
-- 
2.4.0
