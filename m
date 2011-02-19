From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/72] gettext.h: add no-op _() and N_() wrappers
Date: Sat, 19 Feb 2011 19:23:44 +0000
Message-ID: <1298143495-3681-2-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsQr-0001k3-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613Ab1BSTZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:25 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42014 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1BSTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:23 -0500
Received: by ewy5 with SMTP id 5so1969964ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6550u+RSZfP8ZiSGPbBBmoZ+HUMLhGV7Bwy95IsgSNY=;
        b=Z5JbuEOTBrUK4hlwOAopEmQbOzdb/ImjkoPFnPH59RwLmr59xgyXcuNr5zTcrTgAL/
         uifUm2jiqvTaylpe/Vdn/74CLDkM+Avj+dQDmv7D3IEwyt+KTmoY2KbjSNqN5U7b9Jrc
         5yp+9L37SJ+IPHBiLgQ1BBOMSppFxMuULBTCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tfjUGSPAypcF/SpPOR+euX13j6EfH5T8lvk14S8EZYvoQr3Y+zOuz6+2Kl7piGDsWL
         fSjXPf8m5ovY4lRqylVOPRSQGrxra6NBzrA1U3F9yIh8cg9z9Z/h3qM5NxOX7RypSxyO
         p3kQWy3bi19TxkLNjaIg57KsHFbWfppONzfBA=
Received: by 10.213.98.203 with SMTP id r11mr2572608ebn.10.1298143522365;
        Sat, 19 Feb 2011 11:25:22 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.21
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:21 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167309>

Add a new header called gettext.h which is currently a no-op. To split
up the gettext series I'm first submitting patches to gettextize the
source tree before I add any of the Makefile and C changes needed to
actually use them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 gettext.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 gettext.h

diff --git a/gettext.h b/gettext.h
new file mode 100644
index 0000000..c68bbe9
--- /dev/null
+++ b/gettext.h
@@ -0,0 +1,9 @@
+/*
+ * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+ *
+ * This is a skeleton no-op implementation of gettext for Git. It'll
+ * be replaced by something that uses libintl.h and wraps gettext() in
+ * a future patch series.
+ */
+#define N_(s) (s)
+#define _(s) (s)
--=20
1.7.2.3
