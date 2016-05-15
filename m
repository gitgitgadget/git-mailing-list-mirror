From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr: complete a sentence in a comment
Date: Sun, 15 May 2016 15:58:10 -0700
Message-ID: <xmqqeg933p4t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:58:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b24zK-0006f2-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbcEOW6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:58:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbcEOW6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:58:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD6C41B956;
	Sun, 15 May 2016 18:58:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	KejixNFhjewW0dHcBUUsz1fxAU=; b=Msbm4/TfuXF/bz1ota8Tck8LEo6d+/bUJ
	BOUVpxBgNuKu6PjD0TQrvyqvyDV+2rsugJaNeF3vV+KVLFOLpxlkY19pL/p3YRJV
	MQd+GQybwBy02ZwEHveJ8b2Lli2upZxVzmZEF0HyGNThiXPp470H6x6IdlZ73xat
	QzhbD4DCy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=qiz
	uey0oAWMsCuZn6K1OQS6etuH+cS0Mx4mDeA2szISJeMvpxzs9DDUNtHeVTVCKHTf
	dbhrHSLMeaO7qqWLpbLh+AEejC2lTXOlb9Ixccd0bcqxAlSrVwu6juUPReRkfGeQ
	GAm5KVAdN1o5yARe8ZUTle146/3JmFXD3NvcOc2M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B505E1B955;
	Sun, 15 May 2016 18:58:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 328921B954;
	Sun, 15 May 2016 18:58:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8086F786-1AF0-11E6-AD49-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294693>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index aac5c8f..a19946a 100644
--- a/attr.c
+++ b/attr.c
@@ -300,7 +300,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
  * This is exactly the same as what is_excluded() does in dir.c to deal with
- * .gitignore
+ * .gitignore file and info/excludes file as a fallback.
  */
 
 static struct attr_stack {
-- 
2.8.2-748-gfb85f76
