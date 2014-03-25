From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 008/144] unimplemented.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:13 -0700
Message-ID: <1395735989-3396-9-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhK-0006r1-KC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbaCYI0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:26:48 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44578 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbaCYI0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:45 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so129501pdi.30
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L64RwUQYTdjqIYr/ebdQjpq7k/IRrV2hLU4L6QnyOAE=;
        b=bt/A77PCdttz1SaeY4sFkVcBb69g4/L8TG3uR0dGjdkJYuQ3CuUkeK76z4+h9kHyQ2
         43tKHIhPZBaDFFxGd055qmJc9et+g23wSddh+NpKMegj3h76bffXt7zklcvSm1UWckSo
         S9jHZgJydUecDQGNt1/1bHIto2QM3yjfcDRlz347TaKq5Z6Nlyf4pedJS3li0M8UVkAv
         vT58jZb0rMXXjV/SzrPY3XaXFEnzgjY5kq3bUQnwO3hA4Vvv5to8GQdJd96q2e7RqDrx
         4HcfPJLfktLX1XuvC1CI4QeKR0z3RHc+gTBigko5KfCvNPCIXvX9xDmlpak2CmuTn4wm
         4b3g==
X-Received: by 10.68.190.200 with SMTP id gs8mr14286919pbc.130.1395736004955;
        Tue, 25 Mar 2014 01:26:44 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244910>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 unimplemented.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unimplemented.sh b/unimplemented.sh
index 5252de4..fee21d2 100644
--- a/unimplemented.sh
+++ b/unimplemented.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
=20
-echo >&2 "fatal: git was built without support for `basename $0` (@@RE=
ASON@@)."
+echo >&2 "fatal: git was built without support for $(basename $0) (@@R=
EASON@@)."
 exit 128
--=20
1.7.10.4
