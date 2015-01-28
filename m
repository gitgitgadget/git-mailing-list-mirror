From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] config.txt: mark deprecated variables more prominently
Date: Wed, 28 Jan 2015 14:33:12 -0800
Message-ID: <1422484393-4414-3-git-send-email-gitster@pobox.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
 <1422484393-4414-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 02:12:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGdew-0002eJ-3F
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbbA2BMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:12:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751328AbbA2BM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:12:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79F8133A91;
	Wed, 28 Jan 2015 17:33:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=cL7n
	pivlPNXsWZRmBm1phMemT1w=; b=fCMaP3h02nqN+WjKdPPPVwxOd4XDQd7ZeSqa
	Zb0cf7Nr8Qh041DsbGtc4Gnc91YxahRcgvFOPEkB6VyoFKkekQoEDYs/J5TmwvwG
	/Ff/jYw1kcodKrfvxmX+o0FMGAq9K1HdKmVu41+9EHnWtBmxV1gqCKJfGsXdkBKp
	rVAy0p8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LGlZeu
	LjVyMzkAidvCHcYkPRLXsWVSKEjsvFn0X5mW28trkk7o/Bj1IbL1cOak/DAvMcGo
	LUsfLNGG4O+mNodqy9NkpCKNhSwjBMaJ5A+SQ0+Lx6tPxLxi8IrA4Z2Kpz5XREQ/
	7OugqopAfTY/aznX48iUi40eBa9X0w8QMNAU4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70BA033A90;
	Wed, 28 Jan 2015 17:33:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E97A133A8F;
	Wed, 28 Jan 2015 17:33:17 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-149-gdd42ee9
In-Reply-To: <1422484393-4414-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A7E59B34-A73D-11E4-811D-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263124>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 69f30d6..8a76d1d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -665,7 +665,7 @@ core.abbrev::
 	time.
 
 add.ignoreErrors::
-add.ignore-errors::
+add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
 	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
@@ -1923,7 +1923,7 @@ pack.useBitmaps::
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
-pack.writebitmaps::
+pack.writebitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
 
 pack.writeBitmapHashCache::
@@ -2234,7 +2234,7 @@ sendemail.smtpencryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl::
+sendemail.smtpssl (deprecated)::
 	Deprecated alias for 'sendemail.smtpencryption = ssl'.
 
 sendemail.smtpsslcertpath::
@@ -2272,7 +2272,7 @@ sendemail.thread::
 sendemail.validate::
 	See linkgit:git-send-email[1] for description.
 
-sendemail.signedoffcc::
+sendemail.signedoffcc (deprecated)::
 	Deprecated alias for 'sendemail.signedoffbycc'.
 
 showbranch.default::
-- 
2.3.0-rc2-149-gdd42ee9
