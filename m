From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/8] t/README: The trash is in 't/trash directory.$name'
Date: Thu,  1 Jul 2010 20:17:52 +0000
Message-ID: <1278015478-6920-3-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDV-0003KV-L9
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab0GAUSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42123 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab0GAUSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:31 -0400
Received: by wwb24 with SMTP id 24so222125wwb.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2WL9VOhvzoKkOTcQxqOJ4StS5DtYtPYXevin6LhAllY=;
        b=uvbZNangBvFS4JnyJZZtbDEzXvdKaB1HrrYDdFhRNDSzSVmuBN/DL4ptR8jJG4hKdD
         /isVmx8B69oi7BLos+2iyY86fo68ojoBH7i7p2PcBLstRnVTydEAip3FX+VKxGTlZ4oC
         JCW9DKFywAYppdSo7G4rQJkSpgaXXPeNi+oAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kdToq7fzC86Md7dgOUClVtg9FYPWgnXXsWChPI/E4RkzoG03ugdfj68mmBDdxWxL35
         c19BbHaHnLlFNEoLbYgHCiiQaWnbKcS0qvaRuV/e5040rw85YrrAXKAC9X6EldrMuZ3o
         dIh+UP6FWpQAcaiBJtZ2yGr4+hWvRnyIamKsY=
Received: by 10.213.31.141 with SMTP id y13mr3053832ebc.34.1278015509721;
        Thu, 01 Jul 2010 13:18:29 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150074>

There's a unique trash directory for each test, not a single directory
as the previous documentation suggested.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index b378ab1..3cdd744 100644
--- a/t/README
+++ b/t/README
@@ -221,9 +221,10 @@ This test harness library does the following thing=
s:
  - If the script is invoked with command line argument --help
    (or -h), it shows the test_description and exits.
=20
- - Creates an empty test directory with an empty .git/objects
-   database and chdir(2) into it.  This directory is 't/trash director=
y'
-   if you must know, but I do not think you care.
+ - Creates an empty test directory with an empty .git/objects database
+   and chdir(2) into it.  This directory is 't/trash
+   directory.$test_name_without_dotsh', with t/ subject to change by
+   the --root option documented above.
=20
  - Defines standard test helper functions for your scripts to
    use.  These functions are designed to make all scripts behave
--=20
1.7.1.251.g92a7
