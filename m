From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/66] i18n: mark "style" in OPT_COLUMN() for translation
Date: Mon, 20 Aug 2012 19:31:50 +0700
Message-ID: <1345465975-16927-2-git-send-email-pclouds@gmail.com>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGF-00056E-IS
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab2HTMjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab2HTMjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:05 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jLcaV/OunR/w2Dh6DYmLqE53KI1zsGXOjaWCgxWa6pI=;
        b=QGiFGz6aky7x9IEr/1Rc8+A9mohZZboOm7z7VmCE6ccEQFbbdcH6k2sLcl68vnyLO5
         KvAVuHWOUEF6QNWjqjvysMrW3aG4GZQUCQqMq3FpQyIsaJkU7K6smTqyeXhrpLRxhHsS
         yZAe9WRENkcnspvv/BZ4MDGlcNUoZVBDX9B+HVk7a3yX7IQVs6tTlYSPT4y6VT5TJZsL
         EzGiB1FaQVRlT89q7cveq3rMreR4QpNRRJl62AYne6nDOx4DlrwyDE0/u5Z3c2x8c3oB
         ipNfAxNbcRVB29wmOBXL8jXfjRW/KqCMVIlKtxtARHODpBC5tH3pYf2worQx05+CIgst
         dtfg==
Received: by 10.68.219.226 with SMTP id pr2mr34135995pbc.1.1345466344729;
        Mon, 20 Aug 2012 05:39:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ty1sm7956293pbc.76.2012.08.20.05.39.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:04 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203773>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 77a4a8b..71a39c6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -238,6 +238,6 @@ extern int parse_opt_noop_cb(const struct option *,=
 const char *, int);
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), "style", (h), PARSE_OPT_OPTARG, par=
seopt_column_callback }
+	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG,=
 parseopt_column_callback }
=20
 #endif
--=20
1.7.12.rc2.18.g61b472e
