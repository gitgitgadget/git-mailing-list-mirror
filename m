From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: [PATCH] block-sha1: Use mozilla-sha1 copyright and license
	information
Date: Mon, 24 Aug 2009 14:07:56 +0200
Message-ID: <20090824120756.GA17146@ulrik-ibook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 14:07:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfYKo-0002ZH-2J
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 14:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbZHXMH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 08:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbZHXMH0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 08:07:26 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35703 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbZHXMHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 08:07:25 -0400
Received: by ewy3 with SMTP id 3so2299776ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=6sMKDX2SU25uZnxVqWgxl8ZQgEYx0C7yv3hfWmQJAhw=;
        b=bXbtyWYG2Xmm6BYNTrOFFbcqhlHJ64Ib3uui+pZanFEO55Vavokkz4Rh7Q35dDSeue
         LZwG4zKH+f/O2wCCpjMLzpayUIHyG5PJKOD6egy18ZI9PCU8955TuPXpoPCqVq0JE2yn
         0CiiGw19rPPgQq3/sb6va8IUjJ0pN2PdQmIbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=adm+/O277VHaYAEHjaRsBf/9HkuWIoQX06E9E5fp5VDDduJNGedBEkbaTDvAwNslel
         Q/eXXuNzOYvs5aTFDEhPs/b5UyXWCPCKYTimnTnsFFaCcWh2k/ISLNnmB4yQVdVaXkvH
         PHP4dbV1soeqQgMaHEHVo5JKVep7rz5Jd6wi8=
Received: by 10.210.140.6 with SMTP id n6mr798302ebd.42.1251115646733;
        Mon, 24 Aug 2009 05:07:26 -0700 (PDT)
Received: from ulrik-ibook.lan (90-229-231-23-no153.tbcn.telia.com [90.229.231.23])
        by mx.google.com with ESMTPS id 28sm5004622eye.5.2009.08.24.05.07.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 05:07:26 -0700 (PDT)
Received: from ulrik by ulrik-ibook.lan with local (Exim 4.69)
	(envelope-from <ulrik@ulrik-ibook>)
	id 1MfYL7-0004bP-0S
	for git@vger.kernel.org; Mon, 24 Aug 2009 14:07:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126919>

block-sha1 needs an independent copyright and license header, in the
case that the original mozilla SHA-1 implementation is removed from
the tree.

The Contributor(s) list in the header is not in the git style, but
it is copied as well, and augmented with git contributors to
block-sha1.

Signed-off-by: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
---

block-sha1/sha1.{ch} simply say this:

/*
 * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.c),
 * optimized to do word accesses rather than byte accesses,
 * and to avoid unnecessary copies into the context array.
 */

This means that if mozilla-sha1 is removed, we need to copy the
license information back to block-sha1.


 block-sha1/sha1.c |   38 +++++++++++++++++++++++++++++++++++++-
 block-sha1/sha1.h |   37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 464cb25..34c7415 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -1,5 +1,41 @@
 /*
- * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.c),
+ * The contents of this file are subject to the Mozilla Public
+ * License Version 1.1 (the "License"); you may not use this file
+ * except in compliance with the License. You may obtain a copy of
+ * the License at http://www.mozilla.org/MPL/
+ *
+ * Software distributed under the License is distributed on an "AS
+ * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+ * implied. See the License for the specific language governing
+ * rights and limitations under the License.
+ *
+ * The Original Code is SHA 180-1 Reference Implementation (Compact version)
+ *
+ * The Initial Developer of the Original Code is Paul Kocher of
+ * Cryptography Research.  Portions created by Paul Kocher are
+ * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
+ * Rights Reserved.
+ *
+ * Contributor(s):
+ *
+ *     Paul Kocher
+ *     Linus Torvalds
+ *     Nicolas Pitre
+ *
+ * Alternatively, the contents of this file may be used under the
+ * terms of the GNU General Public License Version 2 or later (the
+ * "GPL"), in which case the provisions of the GPL are applicable
+ * instead of those above.  If you wish to allow use of your
+ * version of this file only under the terms of the GPL and not to
+ * allow others to use your version of this file under the MPL,
+ * indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by
+ * the GPL.  If you do not delete the provisions above, a recipient
+ * may use your version of this file under either the MPL or the
+ * GPL.
+ */
+/*
+ * Based on the Mozilla SHA1, this implementation is
  * optimized to do word accesses rather than byte accesses,
  * and to avoid unnecessary copies into the context array.
  */
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index c1ae74d..dc72ccf 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -1,7 +1,38 @@
 /*
- * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.h),
- * optimized to do word accesses rather than byte accesses,
- * and to avoid unnecessary copies into the context array.
+ * The contents of this file are subject to the Mozilla Public
+ * License Version 1.1 (the "License"); you may not use this file
+ * except in compliance with the License. You may obtain a copy of
+ * the License at http://www.mozilla.org/MPL/
+ *
+ * Software distributed under the License is distributed on an "AS
+ * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+ * implied. See the License for the specific language governing
+ * rights and limitations under the License.
+ *
+ * The Original Code is SHA 180-1 Header File
+ *
+ * The Initial Developer of the Original Code is Paul Kocher of
+ * Cryptography Research.  Portions created by Paul Kocher are
+ * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
+ * Rights Reserved.
+ *
+ * Contributor(s):
+ *
+ *     Paul Kocher
+ *     Linus Torvalds
+ *     Nicolas Pitre
+ *
+ * Alternatively, the contents of this file may be used under the
+ * terms of the GNU General Public License Version 2 or later (the
+ * "GPL"), in which case the provisions of the GPL are applicable
+ * instead of those above.  If you wish to allow use of your
+ * version of this file only under the terms of the GPL and not to
+ * allow others to use your version of this file under the MPL,
+ * indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by
+ * the GPL.  If you do not delete the provisions above, a recipient
+ * may use your version of this file under either the MPL or the
+ * GPL.
  */
 
 typedef struct {
-- 
1.6.4
