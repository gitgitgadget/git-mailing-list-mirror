From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] fixup! Documentation/i18n: quote double-dash for AsciiDoc
Date: Wed, 29 Jun 2011 11:44:31 -0500
Message-ID: <20110629164431.GB20032@elie>
References: <20110628171748.GA11485@elie>
 <20110629053133.GB28690@elie>
 <20110629053648.GD28690@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 18:44:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbxsZ-00049M-7q
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 18:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab1F2Qoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 12:44:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56389 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab1F2Qoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 12:44:37 -0400
Received: by gyh3 with SMTP id 3so540166gyh.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=do+6+FdnJjBT0JnKdzHxMHGHVCZpRgL1fxCQpv2gZLk=;
        b=gmu5kxntePUfBV8xiiStH1q5KaHLudyxwJdw+UxrRsIwkPvSKnUCpQvH6ComOcog9B
         XnrKeXzwWfJ2FWRxe08ly53UQNvB3Trd6itayVptcQ/iAEU6pCe7OjtkoEN2lmrD20k+
         sYhNsLVjMu5fuQ4Ag6E1CkDJWTJbAqMZ6uWJc=
Received: by 10.150.74.2 with SMTP id w2mr867379yba.335.1309365876930;
        Wed, 29 Jun 2011 09:44:36 -0700 (PDT)
Received: from elie (adsl-69-209-66-254.dsl.chcgil.sbcglobal.net [69.209.66.254])
        by mx.google.com with ESMTPS id l22sm429472ybl.27.2011.06.29.09.44.35
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Jun 2011 09:44:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110629053648.GD28690@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176445>

The double-dash in the title should be escaped, too, to avoid spurious
em dashes in the header:

	.TH "GIT\-SH\-I18N\(emENVSUB" "1" "06/26/2011" "Git 1\&.7\&.6" "Git Manual"

AsciiDoc 8.6.4 with DocBook XSL 1.76.0-RC1 copes fine and writes
"GIT\-SH\-I18N\-\-ENVSUB" even without this change, which is why it
was missed before.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-sh-i18n--envsubst.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/git-sh-i18n--envsubst.txt
index 6e3a9539..5c3ec327 100644
--- a/Documentation/git-sh-i18n--envsubst.txt
+++ b/Documentation/git-sh-i18n--envsubst.txt
@@ -1,5 +1,5 @@
-git-sh-i18n--envsubst(1)
-========================
+git-sh-i18n{litdd}envsubst(1)
+=============================
 
 NAME
 ----
-- 
1.7.6
