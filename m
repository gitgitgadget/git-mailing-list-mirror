From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 21/72] gettextize: git-checkout describe_detached_head messages
Date: Sat, 19 Feb 2011 19:24:04 +0000
Message-ID: <1298143495-3681-22-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTA-0002tu-Hy
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab1BST1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:49 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab1BST1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:41 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=n+ydgjlbu97d+7pZAf2dh3TXTrbyDyLhi5QzgXGyiI4=;
        b=QOsxzncrvs2FpRveWUu9SMSYlDi3hNlVdZR6qZFXAeOlRQ81gjqg4q0SGnvyOd8QD9
         7kNBp6twETsNr3fEyxTNznAaFzZB+0Lm2Eo5/VI3Wak5umgMBFZ64HZOfEvzoPT0Ta4i
         MfDHb7GUqg2H4dLb0o8Ys/0gxGXqx0PnQ02Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BRDyvJGCMXocNYKilRDAZ7Bt2vGFziK2wTaWZb+u3qxbLSyCxUIbDQ9WnC/7UXNDcp
         9gwgaCPReBKHTbfSS8BGyOBTX7HJOptkZIqHngqRfJZjPm3XZH7DKmtGNkL5PtBAjfAy
         0OGrjf/tq0irDS+15vZGtkXknFwQzrgRZjHMY=
Received: by 10.14.29.77 with SMTP id h53mr2430481eea.18.1298143660012;
        Sat, 19 Feb 2011 11:27:40 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.39
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:39 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167327>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7ba0788..698ac63 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -613,7 +613,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	 * to remind the user that it might be lost.
 	 */
 	if (!opts->quiet && !old.path && old.commit && new->commit !=3D old.c=
ommit)
-		describe_detached_head("Previous HEAD position was", old.commit);
+		describe_detached_head(_("Previous HEAD position was"), old.commit);
=20
 	update_refs_for_switch(opts, &old, new);
=20
--=20
1.7.2.3
