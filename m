From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 02/16] t3020 (ls-files-error-unmatch): remove stray '1' from end of file
Date: Sat,  2 Oct 2010 23:10:30 -0600
Message-ID: <1286082644-31595-3-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gp6-0001s0-K0
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab0JCFJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:19 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51054 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:17 -0400
Received: by pxi10 with SMTP id 10so1068077pxi.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=g+1percJkkIc/qIbRSnYehrf4j+AMvaaDdeiCeVYJrI=;
        b=DRN5JB+it4ILpWQwv5DamEa2q05mCQr9BBmtzZfNRsq3+uz0+p1sX7lKePnwMU5xFB
         u5as2IiTCc5FgCt7sH0iZtPrzgFZKUxFhZQTBV//c1Ak4uPremmV32xqTkWta1hTW3TK
         3wue191fe54NBSeitVRVyy4oTXqdhEU40NnDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NhGd+rMUKVCm8nk88dtZwXg7Un817SmqOXoGQkfzeoGjDKT7TQ2o7H4xymeMP2LWI/
         oAJZ6nSawdaLT8uAN85vWQWRfMSfhvio3jQPrROmtIXpuNAPhnC5Yws53+2PL9EQQl6t
         bpkbxTdWqXi4lEep0jdmx8cy1acrkTOYiSZbQ=
Received: by 10.142.232.21 with SMTP id e21mr6836230wfh.333.1286082557445;
        Sat, 02 Oct 2010 22:09:17 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157828>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3020-ls-files-error-unmatch.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error=
-unmatch.sh
index a7d8187..ca01053 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -26,4 +26,3 @@ test_expect_success \
     'git ls-files --error-unmatch foo bar'
=20
 test_done
-1
--=20
1.7.3.1.66.gab790
