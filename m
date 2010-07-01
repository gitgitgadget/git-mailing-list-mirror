From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/8] t/README: Tests are all +x, ./test, not sh ./test
Date: Thu,  1 Jul 2010 15:09:57 +0000
Message-ID: <1277997004-29504-2-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:15:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULTm-00006b-1k
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab0GAPKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:10:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38159 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab0GAPKm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:10:42 -0400
Received: by wyf23 with SMTP id 23so805138wyf.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FjgZoC+MGdO43sgnWGtvn0hhGQfkWjvze3NokNF5XPg=;
        b=LnGzsWjBVR41bCZ+DgxNLLWas7j3tnF2819QLlggkqGxU5+XScwsKhT+0506AJezQJ
         xkpG9X0b9hI91oSK/pBYZeyHyN017ABJCCbKU58awFANDBwzSldWSF9hy/vfxSEhMbeo
         bzQ1CqqGpTdDaLwajbuDDaegP3a4wzZsGsMqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZX4vhezj2R/Ed2bwG9PZtGl7SdX0riC9t1lvJotQl7xwPxjCplISnQ+x0SK3kmUv0r
         4zOpRNBKekr9HOVba47dv0AIQRmV5rDA7VeqgSLOOvlE5kKjlgfED98ykQARUuQsyf8k
         4v79wTkp/PaB1JGoeIKQZF4lfbRh8zI7hz7kE=
Received: by 10.213.4.5 with SMTP id 5mr5533636ebp.15.1277997038549;
        Thu, 01 Jul 2010 08:10:38 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150040>

They all run with a #!/bin/sh shebang, but it's probably better to use
the ./ form anyway.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/README b/t/README
index aa4ed28..b378ab1 100644
--- a/t/README
+++ b/t/README
@@ -52,7 +52,7 @@ prove and other harnesses come with a lot of useful o=
ptions. The
=20
 You can also run each test individually from command line, like this:
=20
-    $ sh ./t3010-ls-files-killed-modified.sh
+    $ ./t3010-ls-files-killed-modified.sh
     ok 1 - git update-index --add to add various paths.
     ok 2 - git ls-files -k to show killed files.
     ok 3 - validate git ls-files -k output.
--=20
1.7.1.251.g92a7
