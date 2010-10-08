From: "=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?=" 
	<stepan.nemec@gmail.com>
Subject: [PATCH 4/6] Remove stray quotes in --pretty and --format documentation
Date: Fri,  8 Oct 2010 19:31:18 +0200
Message-ID: <1286559080-27257-5-git-send-email-stepnem@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Gqj-0000hg-Q9
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495Ab0JHReM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:34:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33353 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345Ab0JHReF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:34:05 -0400
Received: by mail-fx0-f46.google.com with SMTP id 14so629256fxm.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OGYDIixx3ybm8e87t5M4cc37uz16qWjK2koxovbeL18=;
        b=cKMElhr5+jUwy+HUtrLSHEHbTc+GFbqc/L4V+jmMt94YENOzkZ0EjbEq3BNXOAE0ye
         E3ZP43x2EpQBJndtwuxJCTdupoR9ZUMQvnLquGMtGO/tiLUKVKNdKb9dTkuJ3UqVgIMz
         yYeKoWYGwMMdtVGngwZuiECpjzDTnirn+Abuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xTLMWgVYYiyQEB6ViG+WfWzNL3i3Pr3lf/9nTfOF7bGrdnS7W1d2eeMaF/ArsBIQjk
         kfjVUQVudT9VgulctCYrq//jcOL1ZuzfyKliuLxyr2TQJEW3U5Z6eyAGZgZqpmVEOJy8
         JO4pcMB+uR0Wi9r2ltTYOIDHyvPV1qJoNrJPU=
Received: by 10.223.113.78 with SMTP id z14mr3532281fap.92.1286559245091;
        Fri, 08 Oct 2010 10:34:05 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id e17sm1741603faa.39.2010.10.08.10.34.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:34:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
In-Reply-To: <87fwwhszsf.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158512>

Quotes (for emphasis) are used in option explanations, not the
headings.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Documentation/git-shortlog.txt   |    2 +-
 Documentation/pretty-options.txt |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlo=
g.txt
index bc1ac77..5cc3baf 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -44,7 +44,7 @@ OPTIONS
 --email::
 	Show the email address of each author.
=20
---format[=3D'<format>']::
+--format[=3D<format>]::
 	Instead of the commit subject, use some other information to
 	describe each commit.  '<format>' can be any string accepted
 	by the `--format` option of 'git log', such as '{asterisk} [%h] %s'.
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-op=
tions.txt
index 9b6f389..50923e2 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,5 +1,5 @@
---pretty[=3D'<format>']::
---format=3D'<format>'::
+--pretty[=3D<format>]::
+--format=3D<format>::
=20
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
--=20
1.7.3.rc2.221.gbf93f.dirty
