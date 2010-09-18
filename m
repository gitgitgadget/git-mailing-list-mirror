From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH v3 4/4] Documentation: document foreign idents
Date: Sat, 18 Sep 2010 15:53:59 +0200
Message-ID: <c2829398f87f35f24522a780fa82b1250a15b7c8.1284820251.git.marcus@mc.pp.se>
References: <cover.1284820251.git.marcus@mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 16:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owyhh-0008C7-Vc
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 16:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab0IROr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 10:47:29 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:42700 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab0IROr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 10:47:28 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Sep 2010 10:47:28 EDT
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 4AF33F8C6;
	Sat, 18 Sep 2010 16:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1284820668; bh=in9QhHxDavcOBElEWXHcovB4qCQuW1jDwyHwTCD+pUY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc; b=yDlxZxAJ0pS2efrjv7
	+jQt9Gnw47A0ImHQW4gdnbo4//v0ir9wXb5pZ5x5j+6+3hx+ivGDMp6Ng2a103w7Ztk
	4es3oRCGZUUVZrNEHLaqdMgeUSvvkov5hXhKsCdd9RvX6c44oldB2FkJFO4KKoOw70r
	QtLVOMDwbkHN2i22SsM=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <c2829398f87f35f24522a780fa82b1250a15b7c8@chiyo>)
	id 1OwyXz-0002NK-QV; Sat, 18 Sep 2010 16:37:47 +0200
In-Reply-To: <cover.1284820251.git.marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156456>

Add a short paragraph to the "ident" documentation about the
semantics and intended use of foreign idents.

Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 Documentation/gitattributes.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index e5a27d8..9af1d6f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,13 @@ sign `$` upon checkout.  Any byte sequence that be=
gins with
 `$Id:` and ends with `$` in the worktree file is replaced
 with `$Id$` upon check-in.
=20
+When converting a repository from a different version control
+system, it can be useful to create blobs which contain expanded
+`$Id$` tags.  Git will recognize such "foreign idents" if they
+contain at least one space within the payload.  A foreign ident
+will be replaced by `$Id$` upon check-in, but is left unaltered
+upon checkout.
+
=20
 `filter`
 ^^^^^^^^
--=20
1.7.2
