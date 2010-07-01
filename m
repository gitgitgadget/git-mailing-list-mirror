From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/8] t/README: The trash is in 't/trash directory.$name'
Date: Thu,  1 Jul 2010 15:09:58 +0000
Message-ID: <1277997004-29504-3-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:18:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULWs-0002Ea-FI
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab0GAPSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:18:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40259 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab0GAPSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:18:13 -0400
Received: by wyf23 with SMTP id 23so811764wyf.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Zmy1VKrYC8+Jz6ANhNLP3BMi5tRWoTcZCNxiBOb3H2Y=;
        b=w0QizrEJWWI4OP9BaQNlNAkD4+qOCLn3xTpBKh0iTXD5gPFGuEH+x6REHKkPwuw39h
         X5xGxUF5/WV7MK+w2M/vORlQF72C5GKpduPU09IpOPWcKBiUPrqPAI61ukWZ6iq7RRqf
         xVUKvs2YNgprkMgHfr2Fksb9XZ8CGy9r/iDuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GBXpcW15uIue+CXpFJ1MiYIvFTS3+AzNMdVoCJZzpLZoptiW0zmi40kP6YLCno9Qlb
         LLOm+quatIXHoPn1Od94UH43XJB5I1JLSHKx5uWR8Joox9wRKflSIvBB+SBrVqRhblK/
         D9cVaSmpzRNaZdn0cOWvbPOCK+rZ81+/e3+Hc=
Received: by 10.213.33.134 with SMTP id h6mr5570121ebd.46.1277997042152;
        Thu, 01 Jul 2010 08:10:42 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150046>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index b378ab1..fd61ec7 100644
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
+   directory.$test_name_without_dotsh' if you must know, but I do not
+   think you care.
=20
  - Defines standard test helper functions for your scripts to
    use.  These functions are designed to make all scripts behave
--=20
1.7.1.251.g92a7
