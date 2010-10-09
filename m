From: stepnem@gmail.com
Subject: [PATCH] CodingGuidelines: Fix a typo
Date: Sat,  9 Oct 2010 13:18:39 +0200
Message-ID: <1286623119-13766-1-git-send-email-stepnem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 09 13:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4XSy-0006T9-3y
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 13:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab0JILTq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 07:19:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39548 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab0JILTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 07:19:45 -0400
Received: by bwz15 with SMTP id 15so805668bwz.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=QbE4PtkCx92+J+MrRN1JNgMpA6ZA4dxMMtNRog/zj4s=;
        b=NBDr7tVQ74hrGd4xnZWqf9yLVBJHV5B9HiET7t0Unf6SuJTL/a4adQnZpSmoT+xZXe
         DnDSyfCuouJes+13yJ6CYtU//56bcRXu/VyCvvz3SB+Cm2Kvz89jmkAbVUhdZOCTe07h
         2wLbCwShfZ4Ra0zItz4aGlaMSOjs2CaaSaYHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uyK+n2B9oUPlK6nZlDwAE0YkI48AE+iKZU5GpKyThgEbqYMFQ7X5duvpHEa6GdgMs7
         5l4Lk9U5dN2AzJLcC2Woh5ENq8t88DdHHnzudSHo+wVAsEswr0Pq6DuE8DYo32bOnH7K
         CfZjm5KwyGD1Y1d82QIkNtuyefOxn9IHt06CU=
Received: by 10.204.60.212 with SMTP id q20mr3111415bkh.26.1286623183592;
        Sat, 09 Oct 2010 04:19:43 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id 4sm738165bki.1.2010.10.09.04.19.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 04:19:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158581>

=46rom: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>

`${parameter/pattern/string}' shell expansion uses glob patterns, so
talking about `regexp' is confusing.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Documentation/CodingGuidelines |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index 8346c19..df50ccf 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -53,7 +53,7 @@ For shell scripts specifically (not exhaustive):
=20
  - No strlen ${#parameter}.
=20
- - No regexp ${parameter/pattern/string}.
+ - No substitution ${parameter/pattern/string}.
=20
  - We do not use Process Substitution <(list) or >(list).
=20
--=20
1.7.3.rc2.221.gbf93f.dirty
