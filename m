From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 33/51] i18n: git-stash echo + gettext message
Date: Sun,  3 Apr 2011 16:45:57 +0000
Message-ID: <1301849175-1697-34-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTJ-0005RJ-Ga
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab1DCQrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab1DCQrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:02 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=NlENEFgB4m1XyB5k/ExY/sSsw9mk7sy7LsPatu9gKlg=;
        b=w7I6NIl1WYJVVUlcq16zPUGEYRUinIGLhRzNb97uwFVFQrhv60WS3o/XlYoV8Vg7sk
         WcRcZ/jKuNuvIHCBEbZ7YjlM8gN3r798W581sGJ044JKToa+KUCzPpJFBOTf1hbUJCHF
         G/yihwQ8hX7rJeGC5QBI3/J8Q5QfemvHcPfVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xTRMRGbhNv0Yu7Fs56Y6cHNz3ach5snCn3mnThusJsSzuDjkqgUIFgLaVgmW9RLQc+
         NKS8Qw5MJtFJ7IIhepcB9lyJ+erf6z35TqNIMBYe0inM8/daWkMfqLkk6snW5aBXhANg
         X9Zpyuu03vg5qAx679GNa6Ppr/6rKsDsb4T7g=
Received: by 10.213.100.223 with SMTP id z31mr1147368ebn.65.1301849221867;
        Sun, 03 Apr 2011 09:47:01 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.01
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170724>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ff18364..9259f13 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -401,7 +401,7 @@ apply_stash () {
 		status=3D$?
 		if test -n "$INDEX_OPTION"
 		then
-			echo >&2 'Index was not unstashed.'
+			echo >&2 "$(gettext "Index was not unstashed.")"
 		fi
 		exit $status
 	fi
--=20
1.7.4.1
