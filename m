From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/5] diff: move TRANSLATORS comments so they're picked up
Date: Mon, 30 Apr 2012 15:33:10 +0000
Message-ID: <1335799995-7667-2-git-send-email-avarab@gmail.com>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 17:33:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsbW-0001Az-O6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab2D3Pda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 11:33:30 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55592 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2D3Pd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:33:29 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so383521bkc.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V5dD8PEFttwMHhOMNds3S5VpEVE0QfJJ1SCB2l4smjM=;
        b=Bbqg3oxvVN46PBGawCaKQOEwUxkVD0Om9ucTHt+KEKPPvQdTZ2Bf0mT9u67polRP6C
         WsNZsYt+qLMIYSlkgG5/1YMF6Ec8lKJZWeynOPkFAkb2K24m5XBxwVGrIYW5KI+Y1lGL
         EMQHipY38qE4b06xUvvysNRzOZl25g3nZtXq3QfLNJHhLg0qG86G9ubaNE1Dlko47gsY
         9NkbgKIuT7nnhi5I9/9dAqb+TupF8rLzakT1IfjidDXMr9N21201TdX3cXwmAE9Td2a5
         j7O1hLPcMrfQkPiD7aMMuArrLbOBwsf5WDUBzgP5aikI2yUtb8bYtcFVw+VgCpKHTsFr
         h3/w==
Received: by 10.205.139.81 with SMTP id iv17mr7453682bkc.118.1335800008483;
        Mon, 30 Apr 2012 08:33:28 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id jr13sm27636569bkb.14.2012.04.30.08.33.27
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 08:33:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.546.gbaa1a.dirty
In-Reply-To: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196566>

These TRANSLATORS comments weren't actually picked up by xgettext, the
comment needs to be right before the Q_() function call, evidently it
isn't picked up if that call is wrapped in another function call.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 diff.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 7da16c9..5d06375 100644
--- a/diff.c
+++ b/diff.c
@@ -1413,22 +1413,22 @@ int print_stat_summary(FILE *fp, int files, int=
 insertions, int deletions)
 	 * but nothing about added/removed lines? Is this a bug in Git?").
 	 */
 	if (insertions || deletions =3D=3D 0) {
-		/*
-		 * TRANSLATORS: "+" in (+) is a line addition marker;
-		 * do not translate it.
-		 */
 		strbuf_addf(&sb,
+			    /*
+			     * TRANSLATORS: "+" in (+) is a line addition marker;
+			     * do not translate it.
+			     */
 			    Q_(", %d insertion(+)", ", %d insertions(+)",
 			       insertions),
 			    insertions);
 	}
=20
 	if (deletions || insertions =3D=3D 0) {
-		/*
-		 * TRANSLATORS: "-" in (-) is a line removal marker;
-		 * do not translate it.
-		 */
 		strbuf_addf(&sb,
+			    /*
+			     * TRANSLATORS: "-" in (-) is a line removal marker;
+			     * do not translate it.
+			     */
 			    Q_(", %d deletion(-)", ", %d deletions(-)",
 			       deletions),
 			    deletions);
--=20
1.7.10.546.gbaa1a.dirty
