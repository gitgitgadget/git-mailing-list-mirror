From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH 4/5] gettextize: git-revert: !fixup "Your local changes"
Date: Sun, 31 Oct 2010 11:34:19 +0000
Message-ID: <1288524860-538-5-git-send-email-avarab@gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 12:34:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCWBe-0002ko-1Y
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 12:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab0JaLel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Oct 2010 07:34:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46450 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab0JaLeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 07:34:36 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so5080025wwe.1
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zgvZJJlVjG/fK2+wDAXgP6vv26/aKF4YEh0/ZqcPZA0=;
        b=a4HPFXoSk2vXPuJE3nKnuhEPTQiWzS078Z/zb4XXryHQIaNOeK8+sLHCCjYbfG+eqd
         phrdXySYRnxn8teq0VeiADGxum8UQ5zsdEBqWo4Xv9Xme5q74U5i2AK3CG78l5l4GDxq
         8X9kv7tAngZSUbtJyt/crvHONH+A30IjAg8v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CLtKwqCeF31n5qimL42xoPcrUyifOtdTmbByLsIAokEHNLVuDWXY8zWd8GOdV2n/EU
         o8CPxJIGwpOd+lYGntVznmoqIdDGarlNimlUGWY76FAWdCTm51wYOq72DDNnHLrsMN4F
         t1K6pieLmWpQUEXJpYwJM9ydCMdBqYWahLvSA=
Received: by 10.216.231.168 with SMTP id l40mr6518053weq.18.1288524875425;
        Sun, 31 Oct 2010 04:34:35 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x12sm3009770weq.18.2010.10.31.04.34.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 04:34:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.312.ge13a7
In-Reply-To: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160435>

Gettextize two messages that I missed in 'gettextize: git-revert "Your
local changes" message'.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index c8463d2..178b8a0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -294,9 +294,9 @@ static NORETURN void die_dirty_index(const char *me=
)
 					  "Please, commit your changes or stash them to proceed."));
 		} else {
 			if (action =3D=3D REVERT)
-				die("Your local changes would be overwritten by revert.\n");
+				die(_("Your local changes would be overwritten by revert.\n"));
 			else
-				die("Your local changes would be overwritten by cherry-pick.\n");
+				die(_("Your local changes would be overwritten by cherry-pick.\n")=
);
 		}
 	}
 }
--=20
1.7.3.2.312.ge13a7
