From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 30/48] i18n: git-stash echo + gettext message
Date: Sun,  8 May 2011 12:21:02 +0000
Message-ID: <1304857280-14773-31-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31O-0004a3-KD
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab1EHMXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1EHMWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=YIZ8i+IUR3BpR/Wk5cEl2CXFPH7Mz/xBq7CNgL+vYxk=;
        b=b8wkZedHRAuCVrOfVLcjGAYlD7/RCQpv2xYLRUwH8LurSYTkMIRFNtagqZfbttlCaX
         u4xp+v+8cRHGCm5toiEn5vM6ZPJAbac8bkX7Nl49j2px1fWpMdD2a5TaI2XTGOdPx9fD
         cqXK63J6Ee3dopVukXTv3vk+zCKrHW7IOV05Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jH+n2kkEPPan88D4QMurQPj2Wd4IHLAtL3XjFij2glM6CgRunkZwbqD1MqEaQo2M+1
         uWitcSQ0ioznNRwZCLM7T6jKRKK0x0opj9JOUICt4D8ac3wVRztV6jy108AizMCF0JZ0
         eB22EwvbFYCObDtFKrBskkGoRudQe1aY5KEzw=
Received: by 10.14.188.135 with SMTP id a7mr2729010een.180.1304857321262;
        Sun, 08 May 2011 05:22:01 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.00
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173143>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1ad380a..f3bb3c5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -390,7 +390,7 @@ apply_stash () {
 		status=3D$?
 		if test -n "$INDEX_OPTION"
 		then
-			echo >&2 'Index was not unstashed.'
+			echo >&2 "$(gettext "Index was not unstashed.")"
 		fi
 		exit $status
 	fi
--=20
1.7.4.4
