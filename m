From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] remote-helpers: point at their upstream repositories
Date: Thu, 15 May 2014 15:56:29 -0700
Message-ID: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 00:56:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4Zr-0001yz-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaEOW4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:56:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50712 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbaEOW4e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:56:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6CC116C9A;
	Thu, 15 May 2014 18:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	9yYUis74veSo5H95ZujqpdhXSo=; b=dz6nLF/FLzjnB57M5cJKibXqNi7m3gM9E
	8btfInkZLB2fFwGekHXjjjYhoFwk9wLLBuWeLM9CaIFKFsagRZjsxC3CKyld1ZdO
	FJwWP86GCxFdKf52Mb0YliMbljMmXhM4C+H4rE93bOGLSVgFm2EbLgoGQVorwNFG
	+8zCxRJ/z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=XXw
	zJDkjwlh32OUxxEMdpO8zjs/auEO8Murj2cR3Km2xY/FAFDQSCUjfnTw4BIuJfIJ
	D91C+en7q3rd4CB2ndBWYGe2XWtr3msAkcuO6/Lqf0MLO/6Ybg9BaXMkihLB2KjN
	DMLlF8sn7YAi9TxlhM9F+wlmT+xFK1+OJ3aoNlNU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD01016C99;
	Thu, 15 May 2014 18:56:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A4BC16C97;
	Thu, 15 May 2014 18:56:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 27C86726-DC84-11E3-9B78-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249216>

Two announcements for their version 0.2 on the list archive are not
quite enough to advertise them to their users.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am inclined to queue this for 2.0, and we would also need an
   update to the release notes as well.

   I am undecided about the revert I sent earlier in $gmane/248937;
   with or without it, that is just a contrib/ thing that is not
   well maintained inside our tree anyway.

 contrib/remote-helpers/README | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 contrib/remote-helpers/README

diff --git a/contrib/remote-helpers/README b/contrib/remote-helpers/README
new file mode 100644
index 0000000..72a2df4
--- /dev/null
+++ b/contrib/remote-helpers/README
@@ -0,0 +1,11 @@
+The remote-helper bridges to access data stored in Hg and bzr will be
+maintained outside the git.git tree in the repositories of its
+primary author at:
+
+    https://github.com/felipec/git-remote-hg
+    https://github.com/felipec/git-remote-bzr
+
+As a convenience, copies of the last-bundled version of these two
+remote-helper bridges are kept here, but they may left stale.  Users
+are encouraged to visit the above authoritative repositories for the
+latest versions to get involved in its further developments.
-- 
2.0.0-rc3-431-gba4c34e
