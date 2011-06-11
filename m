From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/4] default core.clockskew variable to one day
Date: Sat, 11 Jun 2011 19:04:10 +0000
Message-ID: <1307819051-25748-4-git-send-email-avarab@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 21:05:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVTVE-0005oh-UD
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 21:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab1FKTFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2011 15:05:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41065 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059Ab1FKTFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 15:05:43 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1229620eyx.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=mx/bCGXz1H1e2/NRujFKIWunh+Mx9CftVEP486ipDeE=;
        b=JUXQBiBzJMmaCiRxc5E60XPfSWdWrNRb+By/QBWMD0rbiKGHZvyjuJTvlhIDHjvZSw
         ZQwa0L76nkl4czzqz28sZNSGv3rHdS9sbPOkYgbbAz9nsKji2uFm/9DGWQauWRj0Fh+A
         eV4LWMNJL1e5TSmiyIXz+P2+jXKeDtAaZ1fv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TC4h29768t7BPj/2l2R52h/EKFxrqjg1INSNAiH8iRnzMk186EtCg8IB1WbHzmMYax
         pJaD01rNBxn1irLkvOEpdHoY9KqEoNKP8ggBCuH5KKr0zyOF2iwKiPYO8IPsY2PEE79X
         dWEmpSmOHB8vAxJ5hisk8WcFMxhCGCjrX1iow=
Received: by 10.14.43.152 with SMTP id l24mr1614342eeb.147.1307819142793;
        Sat, 11 Jun 2011 12:05:42 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id v76sm477161eea.17.2011.06.11.12.05.31
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Jun 2011 12:05:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175646>

=46rom: Jeff King <peff@peff.net>

This is the slop value used by name-rev, so presumably is a
reasonable default.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/tag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 0f0d784..1468813 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -25,7 +25,7 @@ static const char * const git_tag_usage[] =3D {
=20
 static char signingkey[1000];
=20
-static int core_clock_skew =3D -1;
+static int core_clock_skew =3D 86400;
=20
 struct tag_filter {
 	const char *pattern;
--=20
1.7.5.3
