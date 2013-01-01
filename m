From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] SubmittingPatches: who am I and who cares?
Date: Tue,  1 Jan 2013 15:24:53 -0800
Message-ID: <1357082695-29713-2-git-send-email-gitster@pobox.com>
References: <1357082695-29713-1-git-send-email-gitster@pobox.com>
Cc: Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 00:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqBCx-0001U8-Aq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab3AAXZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 18:25:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63650 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab3AAXZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 18:25:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3998A4F8;
	Tue,  1 Jan 2013 18:24:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dmwM
	0uqoI/AlvEHp4GFDAe9igHg=; b=cy5tORnemCFvlkaIx4nk837tEzjHJY7HhKnh
	NRbzPzJq12tK3wON2mfYwpO4U9iQObpJIRmp95tgLnvoCQVc8QRVKBxXnstu1HZo
	ZZbArJHO2tnqGn7Pg32D0WtDwETnSNePgJ79swhhQ75bhQ2q6L0tWiQxa/M6ODrT
	33nRWIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	yi1baQfSV6Yw6O3pUlwuP4uRljI+ucZEM26MQbiVTmucs0wTGQnqVvGdbiykDvo9
	TeIcTBCCEXdpY09GC9s4xtIpYiOptxnCKsDvwBwrdXDsud74JimHrU//7g/p/7MF
	dBZ9/I/VfVYvWFM+a84TsDncklVk+SfiaV3lS0eC+Mc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5A73A4F7;
	Tue,  1 Jan 2013 18:24:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0952CA4F5; Tue,  1 Jan 2013
 18:24:58 -0500 (EST)
X-Mailer: git-send-email 1.8.1.209.gc32ab23
In-Reply-To: <1357082695-29713-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 75943B54-546A-11E2-B4CD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212471>

The introductory text in the "long version" talks about the origin
of this document with "I started ...", but it is unclear who that I
is, and more importantly, it is not interesting how it was started.

Just state the purpose of the document to help readers decide if it
is releavant to them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c34c9d1..b9fd182 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -60,14 +60,8 @@ Checklist (and a short version for the impatient):
 
 Long version:
 
-I started reading over the SubmittingPatches document for Linux
-kernel, primarily because I wanted to have a document similar to
-it for the core GIT to make sure people understand what they are
-doing when they write "Signed-off-by" line.
-
-But the patch submission requirements are a lot more relaxed
-here on the technical/contents front, because the core GIT is
-thousand times smaller ;-).  So here is only the relevant bits.
+Here are some guidelines for people who want to contribute their code
+to this software.
 
 (0) Decide what to base your work on.
 
-- 
1.8.1.209.gc32ab23
