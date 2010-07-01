From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 1/8] t/README: Tests are all +x, ./test, not sh ./test
Date: Thu,  1 Jul 2010 20:17:51 +0000
Message-ID: <1278015478-6920-2-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDV-0003KV-5E
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab0GAUSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43842 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab0GAUS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:29 -0400
Received: by ewy23 with SMTP id 23so884033ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dCDzu5vI8ef56XLE6em+JRDb8SrWGgtphoAFlDK3AJk=;
        b=lMBth0XqDaesBPgCzSFJhTESbdOvfe2b9zL7w/Addb3LezZTRsTR+3qJSdLfwmddSd
         ykYBgAfnSZvPcQ8nIpxm9BoH8WIsrrqtMmWvevNzRJDxUZCzoi30QdkSlROVQw9l85Fu
         6PiiAx2k2jkaI5MaSEhZmLyhS8YWyt3+r5wg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=k2H31S//C5bCTE2W4aDfOE38Zvvbat56+jd+9aIep5baDck3/4maveP/CsFVh1jLL0
         cpVDzp1XKbEq1eyBwVeuGb+bEkhPu7NaQwQfOOXBcAn/L4UloTAvLQz0S6C5rYC+yfBn
         kHebrJk8yO0AjHTbpoEQ87H09MlmjIg3lS58Y=
Received: by 10.213.13.18 with SMTP id z18mr724ebz.43.1278015506614;
        Thu, 01 Jul 2010 13:18:26 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150072>

test-lib.sh runs tests with $SHELL_PATH or the #!/bin/sh shebang when
run under prove. It's simpler to just show ./ as an example.

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
