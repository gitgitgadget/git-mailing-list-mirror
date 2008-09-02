From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: minor cleanup in a use case in 'git stash'
	manual
Date: Tue,  2 Sep 2008 03:45:01 +0200
Message-ID: <1220319901-23733-1-git-send-email-szeder@ira.uka.de>
References: <1220319324-23012-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Jonas=20Flod=C3=A9n?= <jonas.floden@gmail.com>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 03:46:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaKyA-0006aI-0s
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 03:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbYIBBpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 21:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYIBBpE
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 21:45:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57048 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbYIBBpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 21:45:03 -0400
Received: from [127.0.1.1] (p5B13393C.dip0.t-ipconnect.de [91.19.57.60])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1KaKx12ypK-0007yB; Tue, 02 Sep 2008 03:45:00 +0200
X-Mailer: git-send-email 1.6.0.1.171.gaaac
In-Reply-To: <1220319324-23012-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/Xj/ACRBLGf2iA27KwM4L5h9nKs0jQbWcZjFE
 IIgAao/N7sYP3rxEJuTHHFNi1boZi9YAl78mFYw0KydNZtdG2x
 2lM3LVFT8j0Wsz6ez14BA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94638>

There is no need to explicitly pass the file to be committed to 'git
commit', because it's contents is already in the index.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

  Ah, and one more small change in stash docs.

 Documentation/git-stash.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index cdf3cf1..f91368c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -207,7 +207,7 @@ each change before committing:
 $ git add --patch foo            # add just first part to the index
 $ git stash save --keep-index    # save all other changes to the stash
 $ edit/build/test first part
-$ git commit foo -m 'First part' # commit fully tested change
+$ git commit -m 'First part'     # commit fully tested change
 $ git stash pop                  # prepare to work on all other change=
s
 # ... repeat above five steps until one commit remains ...
 $ edit/build/test remaining parts
--=20
1.6.0.1.171.gaaac
