From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/72] cache.h: include gettext.h
Date: Sat, 19 Feb 2011 19:23:45 +0000
Message-ID: <1298143495-3681-3-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:25:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsQs-0001k3-7F
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab1BSTZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:27 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42014 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1BSTZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:26 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1969964ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=uT+O8iL2ccyfqguMTVW60QYkgXqjhx6fX8VhT8tV2Gg=;
        b=C0Fi2/TSWzz8VxLXgzwrBTs/tjWJi3Wl6M9YN0r9uIecHVjYqys3li1cAlvvSEH0SN
         ELBC6unztmBHBV1sNlv64GHlPTMIahJT6226N+Nc/16z8xp0l0gMUpdWCz++ahCBf9w4
         7CFEiFd7LN4asJtdeiVokGpXWGuBNHPoA5nSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XNKfQlRM7OYsK9p3ewF8yLxruEtIqTS6yNJeiBZ4CIgmnYMW8jWuhzEWKaOlh+NhqH
         SxSDz2QUOkhFSM5kcCbw9T2wZmAyh66JaxcCEkXIURBokVR0aBaxZSTu+D8tawcD+DOF
         hV7N44Bp1Y+pprF8m5R3U9mII7XAIOSsFhQqo=
Received: by 10.213.30.20 with SMTP id s20mr2571661ebc.15.1298143525679;
        Sat, 19 Feb 2011 11:25:25 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.25
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:25 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167308>

Change cache.h to include gettext.h. In previous incarnations of the
gettext series I included gettext.h in builtin.h, then changed
builtin/*.c files to include that when they didn't already.

It was pointed out by Junio and others that it makes more sense to
have the inclusion here, since gettext is going to be used everywhere.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 cache.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 3abf895..a465f38 100644
--- a/cache.h
+++ b/cache.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "hash.h"
 #include "advice.h"
+#include "gettext.h"
=20
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
--=20
1.7.2.3
