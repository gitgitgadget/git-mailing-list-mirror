From: "=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?=" 
	<stepan.nemec@gmail.com>
Subject: [PATCH 6/6] Fix {update,checkout}-index usage strings
Date: Fri,  8 Oct 2010 19:31:20 +0200
Message-ID: <1286559080-27257-7-git-send-email-stepnem@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Gql-0000hg-0N
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759276Ab0JHReY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:34:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33353 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433Ab0JHReK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:34:10 -0400
Received: by mail-fx0-f46.google.com with SMTP id 14so629256fxm.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1EmNiJAlLNZtntPYmO0L9pXFa2RJIj6WXsAmnwqWwmA=;
        b=T9l2wjC2oYYVRDLnin0piCNCorlEYTX+7Qq4TDvUyEBuwp2cZarrE/A8vyInA4dYvh
         rg7IsZ/U0VbPJZ8ScXEeU6EHy0q2vzVfi7D/v6zHZmHvtAmolnaNNeLq3F1dVl1m6M0H
         SGpllP71wfjm3jpr+kWVzRmpwPwwcyxqsn2hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=laZsyO4+pNGlWtko0vvYMqoJF33ZAQi8Vh904j+xEQdSubTZoqSTLLIjJC+fVDk/JL
         Z9kPWOnjoTT2SMkZhGJqoOg+NR1aC/NgGcQrUAtZ+NF6fd9euEPd/oaCZ+lkpR7+1CdQ
         KlTH3u/STMPYQ7IS2pehpZYp9CWRaVyjl9VNY=
Received: by 10.223.126.15 with SMTP id a15mr3606447fas.67.1286559250216;
        Fri, 08 Oct 2010 10:34:10 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id k4sm737982faa.32.2010.10.08.10.34.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:34:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
In-Reply-To: <87fwwhszsf.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158514>

The `<file>' argument is optional in both cases (the man pages are
already correct).

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 builtin/checkout-index.c |    2 +-
 builtin/update-index.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a7a5ee1..65cbee0 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -155,7 +155,7 @@ static void checkout_all(const char *prefix, int pr=
efix_length)
 }
=20
 static const char * const builtin_checkout_index_usage[] =3D {
-	"git checkout-index [options] [--] <file>...",
+	"git checkout-index [options] [--] [<file>...]",
 	NULL
 };
=20
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..62d9f3f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -398,7 +398,7 @@ static void read_index_info(int line_termination)
 }
=20
 static const char update_index_usage[] =3D
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-=
remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore=
-missing] [-z] [--verbose] [--] <file>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-=
remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore=
-missing] [-z] [--verbose] [--] [<file>...]";
=20
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
--=20
1.7.3.rc2.221.gbf93f.dirty
