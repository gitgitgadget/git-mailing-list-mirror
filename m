From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/12] attr.c: complete a sentence in a comment
Date: Mon, 16 May 2016 14:05:38 -0700
Message-ID: <20160516210545.6591-6-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiL-0001Fc-IS
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbcEPVGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:06:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbcEPVGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:06:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5ABA1C444;
	Mon, 16 May 2016 17:05:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8ZlE
	kt1MQrXFtZYy8RRM028z7CI=; b=lqZxrnFTQElflhUCT3vchENTUfZLT/0aheL/
	nZthYk6x8gD7IN/Z8TAmVnBbuy51sU/BMbhi/muR2jHweYafXagVpZ1BmvAxO4lR
	onnKAmhDIaejs6RT93EmpdTSDT1wk0ShOQugJQBaTPSiZI/JlsDHvOJEHPds4wlz
	0HUBLSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=K2W4py
	vJuomdpF1biZWC/aiZkdOsI2iCCfbteVOk9jVxf/Ko+8cFFCB6IzQiF5ZiHlSwow
	5x+Q21xW+ESG6Zz7yu46cOHuNQUoznKRb2gt7l4OgjXgKdQNXWCLxYFZnlvcMGYr
	zgBus+wSsb2s8jqBZRQza1zdMM6Lpv0PJCw24=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BC6E41C443;
	Mon, 16 May 2016 17:05:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E7B41C442;
	Mon, 16 May 2016 17:05:59 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: FD27F7D6-1BA9-11E6-930F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294790>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 05db667..a7f2c3f 100644
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
