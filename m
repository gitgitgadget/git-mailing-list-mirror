From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] apply.c: typofix
Date: Thu, 22 Jan 2015 14:58:22 -0800
Message-ID: <1421967505-16879-2-git-send-email-gitster@pobox.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
 <1421967505-16879-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 23:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQi4-0007rO-AF
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbAVW6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:58:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753212AbbAVW6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:58:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C73C31352;
	Thu, 22 Jan 2015 17:58:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2rjv
	sVyYyCUIRalM4+/FyHkgrB8=; b=piytWx3+9H91sZHD/h7zopy6CVSg8+GWP8ft
	SHepDQI76v0RNzlY/AQFBy5aYI8JqpJMFgmwUvIwbGeFM3dBLr3MdEHGeCWNtrkt
	u6EbE4TuRFUMMO/EZjbO3yve7DoceuZYd0S5/F0I2B9k2MZbZ8Kb6xkS1HOYVhmD
	p4fcr5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eHUKaM
	zrWe+5gCJuUXe/I5UzfoMaRId3MSUiHaJCvTre14PMqfid3ATYk4FoEqGaQJF/gX
	97IAxmV3dFwV7s1QTlj3aFwiVHzFrG16xcI+Zc/8c9uEkkkXyncci8a4LiLhwFWk
	0G/UPyYdgINcRFp6tntFhhnRK/OtvtNvTnqD4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0339931351;
	Thu, 22 Jan 2015 17:58:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C84C131344;
	Thu, 22 Jan 2015 17:58:27 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc1-150-gaf32ea2
In-Reply-To: <1421967505-16879-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2D5E01CE-A28A-11E4-9B6A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262884>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 622ee16..31f8733 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2326,7 +2326,7 @@ static int match_fragment(struct image *img,
 
 	/*
 	 * The hunk does not apply byte-by-byte, but the hash says
-	 * it might with whitespace fuzz. We haven't been asked to
+	 * it might with whitespace fuzz. We weren't asked to
 	 * ignore whitespace, we were asked to correct whitespace
 	 * errors, so let's try matching after whitespace correction.
 	 *
-- 
2.3.0-rc1-116-g84c5016
