From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: "on for all" configuration of notes.rewriteRef
Date: Sun, 4 Sep 2011 22:28:57 +0200
Message-ID: <f415402994735a60664e1f9f85be490a68b25ed3.1315167848.git.trast@student.ethz.ch>
References: <CABNEGjy8M-pFTOs504Q1+G_DtocJwvzDyOAsJp9cn4BOSkv1TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "John S. Urban\"" <urbanjost@comcast.net>,
	Tor Arntsen <tor@spacetec.no>,
	knittl <knittl89@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 04 22:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0JJY-0001i7-Sq
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 22:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab1IDU3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 16:29:00 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:38284 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab1IDU27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 16:28:59 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sun, 4 Sep
 2011 22:28:53 +0200
Received: from localhost.localdomain (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sun, 4 Sep
 2011 22:28:58 +0200
X-Mailer: git-send-email 1.7.7.rc0.420.g468b7
In-Reply-To: <CABNEGjy8M-pFTOs504Q1+G_DtocJwvzDyOAsJp9cn4BOSkv1TQ@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180702>

Users had problems finding a working setting for notes.rewriteRef.
Document how to enable rewriting for all notes.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
[Sorry for the spam; the first one lacks my reply blurb and the
in-reply-to. :-( ]

Tor Arntsen wrote:
> Thanks. Got it working. So it's not by default, as was suggested by
> knittl, it has to be enabled. BTW, it's not at all obvious from the
> manpage what it should be set to, there's no actual example. Found it
> by trial&error plus finding a diff for a test.

Let's document it then.  This still won't help you find out about the
option/feature in the first place, though.  Maybe we should flip the
default to enabled?

 Documentation/config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0ecef9d..302b2d0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1464,7 +1464,8 @@ notes.rewriteRef::
 	You may also specify this configuration several times.
 +
 Does not have a default value; you must configure this variable to
-enable note rewriting.
+enable note rewriting.  Set it to `refs/notes/*` to enable rewriting
+for all notes.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
-- 
1.7.7.rc0.420.g468b7
