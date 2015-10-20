From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] gitk crash fix and locale updates
Date: Tue, 20 Oct 2015 14:33:00 +0200
Message-ID: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 14:34:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoW6y-0006hp-59
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 14:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbbJTMdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 08:33:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:35276 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbbJTMdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 08:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C2C25ACC7;
	Tue, 20 Oct 2015 12:33:16 +0000 (UTC)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279910>

Hi,

the recent change in gitk to support the menu accelerator broke the
invocation with --all option in non-English locales.  Also, the whole
menu translations are gone by this, too.  This patchset tries to
address these issues.


Takashi

===

Takashi Iwai (4):
  gitk: Fix crash with --all in non-English locales
  gitk: Update msgid's for menu items with accelerator
  gitk: Add accelerators to Japanese locale
  gitk: Add accelerator to German locale

 gitk-git/gitk        |  4 +--
 gitk-git/po/bg.po    | 34 ++++++++++++-------------
 gitk-git/po/ca.po    | 34 ++++++++++++-------------
 gitk-git/po/de.po    | 70 ++++++++++++++++++++++++++--------------------------
 gitk-git/po/es.po    | 34 ++++++++++++-------------
 gitk-git/po/fr.po    | 34 ++++++++++++-------------
 gitk-git/po/hu.po    | 34 ++++++++++++-------------
 gitk-git/po/it.po    | 36 +++++++++++++--------------
 gitk-git/po/ja.po    | 68 +++++++++++++++++++++++++-------------------------
 gitk-git/po/pt_br.po | 34 ++++++++++++-------------
 gitk-git/po/ru.po    | 34 ++++++++++++-------------
 gitk-git/po/sv.po    | 34 ++++++++++++-------------
 gitk-git/po/vi.po    | 34 ++++++++++++-------------
 13 files changed, 242 insertions(+), 242 deletions(-)

-- 
2.6.1
