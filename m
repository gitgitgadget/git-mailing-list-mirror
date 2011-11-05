From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/2] i18n: fix GETTEXT_POISON=YesPlease breakages
Date: Sat,  5 Nov 2011 17:28:41 +0000
Message-ID: <1320514123-18842-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 18:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMk3J-00066P-Sn
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 18:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1KER2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 13:28:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55354 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab1KER2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 13:28:51 -0400
Received: by faao14 with SMTP id o14so3682311faa.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=gmRI3vzdoU9QZO+PWItPHeYLzakfMmFq08uncAti+pQ=;
        b=ck8B1HjGvoO60hOD65FexBPBZLlKbqiLaKR/jo4tBfsCpV+6i23DMx5I8eMZTohPFb
         IywCr/HamMQrtNvcqqU0GtgbsF5/orfovh+Wu8BPY7ze7/AhYqaYgaMuYcC4x8/7yxIA
         qU2q7y9sfjXFZmhx5woiXzc5jYeMeNZ+Olkew=
Received: by 10.223.30.149 with SMTP id u21mr33400256fac.18.1320514129956;
        Sat, 05 Nov 2011 10:28:49 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id w11sm22575710fad.7.2011.11.05.10.28.49
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 10:28:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184868>

This fixes things broken in the test suite under
GETTEXT_POISON=3DYesPlease.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  t/t6030-bisect-porcelain.sh: use test_i18ngrep
  t/t7508-status.sh: use test_i18ncmp

 t/t6030-bisect-porcelain.sh |    2 +-
 t/t7508-status.sh           |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--=20
1.7.7
