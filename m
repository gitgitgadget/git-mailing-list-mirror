From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 6/8] t/README: Document test_expect_code
Date: Thu,  1 Jul 2010 20:17:56 +0000
Message-ID: <1278015478-6920-7-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:18:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDj-0003QZ-VJ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976Ab0GAUSn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43842 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966Ab0GAUSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so884033ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gS3A7vtJTJPJl5Mbb3ysLoQSs5o42gktGy+MLsag3Jk=;
        b=q8gxzMXI8oG2PDcbP8VHR7lE4RKBSprFIcPeMAZ5aXWk9+kGWKojw8V9TEY2nbxwR5
         +GphqavpqDzcXVCgirtGkWIV5REnxQ7JSGqaI1yBIM9XSMVKM28JI6lTOzd0ErPpvKdY
         qi5cU3DJFWr+peFljZlgSb26MzCn9F/iytzNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uAh1MssG2A5ohbhQS+Zq1b0OcdFPxZHUK0CR0ZwYApTEBcGrMJ8SnVeiW4lAryX6t+
         twOc7nFBWLCGYJPW/i7oFfOAcVXi8/3JOWedqxbZnuSQ4lCFgs7A2S2MfC5D4zF1u2H9
         fwBmAVWrKNRWfkkcaVjA5APtipciRoDNfKrsM=
Received: by 10.213.20.142 with SMTP id f14mr6001284ebb.82.1278015520774;
        Thu, 01 Jul 2010 13:18:40 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150075>

test_expect_code (which was introduced in d3bfdb75) never had any
documentation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index d9b5294..27b9658 100644
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
