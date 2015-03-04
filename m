From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] Documentation/config.txt: simplify boolean description in the syntax section
Date: Wed,  4 Mar 2015 13:33:22 -0800
Message-ID: <1425504803-16039-7-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <1425504803-16039-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:34:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGvR-0007NC-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbbCDVdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752173AbbCDVds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93BE83C7A3;
	Wed,  4 Mar 2015 16:33:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wVKd
	n8dDNtIypsrnBXn6c9y/QBQ=; b=RKZ8od3nwgOPKALM0VQ6eVV83prRulVAr3E+
	2bMlyScz8Cns1oJDme5uObT4iMJlTHmf0RWMhPafv2QA/V7yJifAL5B5CbNhjcTq
	XA7Wzwvjq2fEFwk1KdfP8+uBVAbdIyyyBzbt4yYZtWUG4DrXyP9GduLH7rWfCpac
	2J2uUJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=de9ZGs
	Ro7PnJjIT2+6UP7oLmVUkDHRd/Uq6HNJPCDBo1aHt3jeHuRibjvHlKz7h4tNjCCP
	VDnt2151efiI8DftHD6EQMq+sA9drCfv39DqaNc0XGxPnhBYu3VGBZyAi2rcawOH
	7JTddf7W6JWUCQpBBTRhVpS41Vp0MxNa1v5a4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D54B3C7A2;
	Wed,  4 Mar 2015 16:33:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BC4F3C792;
	Wed,  4 Mar 2015 16:33:42 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <1425504803-16039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 21392CE2-C2B6-11E4-8809-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264786>

The 'true' short-hand doesn't deserve a separate sentence; even our own

    git config --bool foo.bar yes

would not produce it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c40bf4a..f1cf571 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -54,8 +54,8 @@ restrictions as section names.
 
 All the other lines (and the remainder of the line after the section
 header) are recognized as setting variables, in the form
-'name = value'.  If there is no equal sign on the line, the entire line
-is taken as 'name' and the variable is recognized as boolean "true".
+'name = value' (or just 'name', which is a short-hand to say that
+the variable is the boolean "true").
 The variable names are case-insensitive, allow only alphanumeric characters
 and `-`, and must start with an alphabetic character.
 
-- 
2.3.1-316-g7c93423
