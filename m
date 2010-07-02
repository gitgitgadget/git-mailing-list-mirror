From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 5/7] t/README: Document test_expect_code
Date: Fri,  2 Jul 2010 14:59:47 +0000
Message-ID: <1278082789-19872-6-git-send-email-avarab@gmail.com>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 17:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhk6-0004di-BB
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768Ab0GBPA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:00:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49039 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab0GBPAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:00:53 -0400
Received: by ewy23 with SMTP id 23so1096019ewy.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VCAJ5MS5ToqoPAM62j3CdqUx3BkxHbS/5mc8zZxJAKc=;
        b=PHc8ZvV62Bf63UWa/1XYTImvTn9I+Z9bwqJ4ruHC+IqRRXii7ptYL5iGaLdtWI0meo
         F0sqeS4KNwKei866fBr0KXuCmO3KNq5MOExdJp2y96huB+SspARpQFsVHp/Ruro8q40Z
         kEV6KwqX7ikRaHxjPKji6kARU9ZvPyUQYzMCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=U6ACVe2ABn0FoSOaqj1PhNqWyja4JCK634eMGfUSENmGD4IW7IM5T8pjl+7fNGeKnz
         GgDq2A2SJuRBlqkQh0+nzdtO2FCw130y8pbo2IQDwRmUF3gCTKgBvIpuPtpQ8x6sAHz4
         hxV7oGeQc3209A5R11XPfLrawf8N+7IMSozcA=
Received: by 10.213.26.13 with SMTP id b13mr4099739ebc.71.1278082850075;
        Fri, 02 Jul 2010 08:00:50 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id a48sm6206858eei.19.2010.07.02.08.00.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 08:00:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150135>

test_expect_code (which was introduced in d3bfdb75) never had any
documentation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index b40403d..04ad927 100644
--- a/t/README
+++ b/t/README
@@ -277,6 +277,13 @@ library for your script to use.
    Like test_expect_success this function can optionally use a three
    argument invocation with a prerequisite as the first argument.
=20
+ - test_expect_code [<prereq>] <code> <message> <script>
+
+   Analogous to test_expect_success, but pass the test if it exits
+   with a given exit <code>
+
+ test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" =
B master'
+
  - test_debug <script>
=20
    This takes a single argument, <script>, and evaluates it only
--=20
1.7.1.251.g92a7
