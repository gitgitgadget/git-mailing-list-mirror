From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 1/7] t/README: The trash is in 't/trash directory.$name'
Date: Fri,  2 Jul 2010 14:59:43 +0000
Message-ID: <1278082789-19872-2-git-send-email-avarab@gmail.com>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 17:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhjL-00048m-So
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665Ab0GBPAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:00:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57428 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab0GBPAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:00:35 -0400
Received: by mail-wy0-f174.google.com with SMTP id 23so1196622wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=k5QAFt/2NS9eSEbPXRKm+cJpDzY98A/70+DbGzCRuww=;
        b=NF6VYK47SvHpQDvN1NUTaIfvTm0+vVh6HDkhGMixBgxSwMP1XccCxU7ivfx2rYwjyf
         t3U6oxjh6b6Wtvwg9iaT3Zg47U+pymBpsZpCihdPTKwxqDmbvOjOvgrFhxTBatrmzVSR
         /hvf5DpmEkQkLgrS35DqTI9VSWv0W0cQoEWQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fc7Z+hWXeNqHVCYm/MPlkw4IKiUebIeKX139aa2deXB5+qlhXTtq40jG6viXMKipoD
         utYRGTn5tqxi6Go7BNL0J8VGg36LkD/drryNiLQp8+LmFIL55DYHnM71kUei1paphicb
         ba5hlDs1ZtSNCBOBk0A6/avMv2hva2OOoAklE=
Received: by 10.213.31.133 with SMTP id y5mr4114982ebc.6.1278082834374;
        Fri, 02 Jul 2010 08:00:34 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id a48sm6206858eei.19.2010.07.02.08.00.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 08:00:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150129>

There's a unique trash directory for each test, not a single directory
as the previous documentation suggested.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index aa4ed28..cad6fde 100644
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
