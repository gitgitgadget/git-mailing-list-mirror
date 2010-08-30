From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 04/17] builtin.h: Include gettext.h
Date: Mon, 30 Aug 2010 21:28:10 +0000
Message-ID: <1283203703-26923-5-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvd-0000N5-RP
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab0H3V3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41451 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab0H3V32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:28 -0400
Received: by wwb28 with SMTP id 28so136823wwb.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SkA6jEawZkHf7yr681yCkkThfYiLaLtuYREUF05kN38=;
        b=JCYD8bcPIN7Y3bFIMEiiI4KvjUCjCMVw2Fd7Ip3FhdnZj4mfJyTQgDTd/Llijf4Svh
         y3wM13DmZxjom1KwWZsAaYzF+5tCqvH7fkyPf4qruvObbnebmJVR2qwFEMvbsmzp6x8B
         Ovmu5MRoqBGmikQQOxk922VA8qJ2yiShduyEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IxnoclHYD4gMTyOBX8NsF0B3Xo9vxvzqVAY+w7WeMHtnsOAzqtMqKGBz6S1U+DzU5Z
         OvvGmSvQjEaZH4YlhL0+aV4AETlHmmsJ2w1GnKu+MR1OI94HMqmwW/TvvF02W09gl3Ou
         X8kX1mnEotR7OtwYWYpm7OYs2yAgj736HxvWE=
Received: by 10.227.157.134 with SMTP id b6mr4862863wbx.115.1283203730679;
        Mon, 30 Aug 2010 14:28:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154860>

Change builtin.h to include gettext.h. This is needed in order to
translate Git's builtin commands (like git-init), which don't include
gettext.h otherwise.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin.h b/builtin.h
index ed6ee26..6cd3bd8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "notes.h"
+#include "gettext.h"
=20
 extern const char git_version_string[];
 extern const char git_usage_string[];
--=20
1.7.2.2.536.g3f548
