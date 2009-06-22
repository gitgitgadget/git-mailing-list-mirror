From: newren@gmail.com
Subject: [PATCH v2] fast-export: Document the fact that git-rev-list arguments are accepted
Date: Mon, 22 Jun 2009 07:06:41 -0600
Message-ID: <1245676001-14734-7-git-send-email-newren@gmail.com>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjHj-0004kU-OO
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbZFVNJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 09:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbZFVNJF
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:09:05 -0400
Received: from mail-px0-f174.google.com ([209.85.216.174]:33488 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbZFVNI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 09:08:59 -0400
Received: by mail-px0-f174.google.com with SMTP id 4so34643pxi.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JG1bNLh9uwxjPxHS+8qdBzVNQODBgU6FhbopNVnDLoU=;
        b=OMeg8hZwUxR4Sqlwo1OyQTTYo1EugNZXZpij+mC9Qjke+yQ2g1ZxQugI/l+WG3yrOJ
         wqoZf/RPFI25Um+9qosB3Xz4SxOKJcVdrnRRyNHOAAOuoQXuoMMbEAZ0xn2pKyW9khzE
         mTXhMHRYXCfMTw7jSARDAx3gBhvEjBZQ5EY6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SGo+Pdb192bVWsvOPyWUMma16KnMEnGoFY6ip1KEhZRNEfydNEyPJwHIpCwudc5Db/
         sEM+G81QruK/a9CJ5Clc9pJHHbQHDvMeFY17eoePO2h1YLn/NFYE7bK14GukT7PSQTfT
         hTyVxQs7yMOS79EQTe1sdoDNiJxc8+X+xYzNs=
Received: by 10.142.180.10 with SMTP id c10mr2687981wff.316.1245676142240;
        Mon, 22 Jun 2009 06:09:02 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 28sm675507wfd.23.2009.06.22.06.09.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 06:09:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245676001-14734-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122041>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
(No change to this patch since the first series.)

 Documentation/git-fast-export.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 194abde..af2328d 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -82,6 +82,12 @@ marks the same across runs.
 	allow that.  So fake a tagger to be able to fast-import the
 	output.
 
+[git-rev-list-args...]::
+       A list of arguments, acceptable to 'git-rev-parse' and
+       'git-rev-list', that specifies the specific objects and references
+       to export.  For example, `master\~10..master` causes the
+       current master reference to be exported along with all objects
+       added since its 10th ancestor commit.
 
 EXAMPLES
 --------
-- 
1.6.0.6
