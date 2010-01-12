From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/18] bisect.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:44 -0800
Message-ID: <1263282781-25596-2-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbaZ-00056x-OH
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0ALHyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387Ab0ALHxS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0ALHxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 537F88E871
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3ole
	Xxocr8F6brO+3Fu22VATf/M=; b=rvLT7M3uWpRv1ZIpMD3yLrzeoPQukaRmKEUD
	WpuPqL9TKz4G9TDLgf1Zy/rAtIm7PFZdxZqkqRYwwOzKWH3BPbUdwMKFQwAZPbdp
	iO2+GdDz4iTzPtY59LiWZHoCFXkdRv9+zm08g/YkKn3sxrYPV700f2ZumCqwWQVG
	Y2n+s+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AVSZLg
	kpF3xC9zD2/HEseIls26TvtS2QfuOU0SU2Fs/EpO4Sq7H55479yjrjQuv5vOiN95
	CNQ8lS9jJ0MOpjMPa4PH0BSWP2Delm3TAUnO88KeJFDOEIlTeQujbuMRa0fe2DrG
	bE4CwNhCbtfDcEmDn5pog1C90DGiDzdqe/Odw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D37C8E86F
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D69C18E86E for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:11 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 885B5F56-FF4F-11DE-99AA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136698>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bisect.c b/bisect.c
index f1a1f84..5c03398 100644
--- a/bisect.c
+++ b/bisect.c
@@ -593,7 +593,7 @@ struct commit_list *filter_skipped(struct commit_list *list,
  * is increased by one between each call, but that should not matter
  * for this application.
  */
-int get_prn(int count) {
+static int get_prn(int count) {
 	count = count * 1103515245 + 12345;
 	return ((unsigned)(count/65536) % PRN_MODULO);
 }
-- 
1.6.6.280.ge295b7.dirty
