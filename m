From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-gui: remove spurious "fuzzy" attributes in po/it.po
Date: Fri, 14 Mar 2008 21:59:52 +0100
Message-ID: <200803142159.52633.barra_cuda@katamail.com>
References: <20080313052713.GU8410@spearce.org> <alpine.DEB.1.00.0803140723450.30157@perkele.intern.softwolves.pp.se> <20080314063817.GW8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Karlsson <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 21:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaGyr-0005r9-Jh
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 21:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbYCNU5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbYCNU5m
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 16:57:42 -0400
Received: from smtp.katamail.com ([62.149.157.154]:39243 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752856AbYCNU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 16:57:41 -0400
Received: (qmail 17250 invoked by uid 89); 14 Mar 2008 20:48:09 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host132-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.132)
  by smtp1-pc with SMTP; 14 Mar 2008 20:48:08 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <20080314063817.GW8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77282>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

On Friday 14 March 2008, Shawn O. Pearce wrote:
>     MSGFMT    po/it.msg 388 translated, 2 fuzzy, 1 untranslated.

These "2 fuzzy" are bogus: those lines weren't changed between my last
translation and Peter's regeneration, and were not fuzzy before. Strange.

 po/it.po |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/po/it.po b/po/it.po
index 877e7e8..11cc79b 100644
--- a/po/it.po
+++ b/po/it.po
@@ -1910,7 +1910,6 @@ msgid "Spell checker silently failed on startup"
 msgstr "Il correttore ortografico ha riportato un errore all'avvio"
 
 #: lib/spellcheck.tcl:80
-#, fuzzy
 msgid "Unrecognized spell checker"
 msgstr "Correttore ortografico sconosciuto"
 
@@ -1919,7 +1918,6 @@ msgid "No Suggestions"
 msgstr "Nessun suggerimento"
 
 #: lib/spellcheck.tcl:381
-#, fuzzy
 msgid "Unexpected EOF from spell checker"
 msgstr "Il correttore ortografico ha mandato un EOF inaspettato"
 
-- 
1.5.4.3
