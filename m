From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation/urls: Add <transport>::<address> syntax
Date: Mon, 29 Mar 2010 20:40:07 +0530
Message-ID: <f3271551003290810u4edbbbd0x2432bc7411333800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 17:10:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwGbr-0007iE-8r
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 17:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab0C2PK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 11:10:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51012 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab0C2PK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 11:10:28 -0400
Received: by gwaa18 with SMTP id a18so4074980gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=WapQlWYdEW9IBc4WykZ9UnH3F+l0sl5B0YHgEsdKJBE=;
        b=jIYwKcTBRkFhD4YXohId/nbDuB5XorDL36CzZGFVuSt08Zkuns/lMWDnVEPhWPyuks
         tKqCN0eklJ98G4IEbqBsFehvwep/3y8yZhpamhmX76czjFsebn+WmpvyZ0Z8IKZS0koY
         wmBldKJLcyIUlK9yNMz40a0XMvt4d9Yp7UflI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=jJCCOEZThzeObQpgmHAu9AZF/8akuqxrY7wsPGf5icZrmCcaLPzSop64cgyJOyzOm8
         vZlehFNanWkBj1QH2ZwuU+Lp1n2kluQpml3O1HupYGmicw31V4rrT6Tag0kh5AeDLOp6
         9nzhzkTHd2RGo8J0VG2bPyAl4hG7PFczuk+44=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 08:10:07 -0700 (PDT)
Received: by 10.90.23.37 with SMTP id 37mr982954agw.75.1269875427237; Mon, 29 
	Mar 2010 08:10:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143481>

Add <transport>::<address> syntax for explicitly invoking a remote
helper.
---
 Documentation/urls.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 459a394..041cbfe 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -30,6 +30,11 @@ To sync with a local directory, you can use:
 - /path/to/repo.git/
 - file:///path/to/repo.git/

+To explicity request a remote helper for a certain transport protocol,
+you can use:
+
+- <transport>::path/to/repo.git
+
 ifndef::git-clone[]
 They are mostly equivalent, except when cloning.  See
 linkgit:git-clone[1] for details.
-- 
1.7.0.3
