From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/6] Use our nice message printout wrapping system
Date: Mon, 08 Oct 2007 10:55:18 +0200
Message-ID: <20071008085518.9734.44584.stgit@yoghurt>
References: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoOl-0003Em-AA
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbXJHIz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXJHIzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:55:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2218 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbXJHIzW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:55:22 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IeoOU-00024p-00; Mon, 08 Oct 2007 09:55:18 +0100
In-Reply-To: <20071008085430.9734.75797.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60300>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/main.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/main.py b/stgit/main.py
index 15582dd..8e00217 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -282,7 +282,7 @@ def main():
=20
         command.func(parser, options, args)
     except (StgException, IOError, ParsingError, NoSectionError), err:
-        print >> sys.stderr, '%s %s: %s' % (prog, cmd, err)
+        out.error(str(err), title =3D '%s %s' % (prog, cmd))
         if debug_level > 0:
             raise
         else:
