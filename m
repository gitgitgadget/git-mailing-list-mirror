From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Documentation: tiny git config manual tweaks
Date: Sat, 9 Jan 2010 21:01:21 -0600
Message-ID: <20100110030121.GD1083@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <9516c897017ec420403bb7f687fb8962de42cb7c.1263081032.git.trast@student.ethz.ch>
 <20100110025641.GB1083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 04:01:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTo3N-0005XX-TX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 04:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab0AJDBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jan 2010 22:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218Ab0AJDBS
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 22:01:18 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:49711 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0AJDBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 22:01:17 -0500
Received: by ywh6 with SMTP id 6so20594092ywh.4
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 19:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=V3AHY257KmlGhjdU8ihuCg5pAaNRUyLSGhtYBIa2Gmg=;
        b=fUd0AInEWCx2oWsxwIG6V6P0OtL1xBSFJVYqaAdzTFFpH7oqrV+KifV0N4nbijhi1A
         paurUVc3nRJcd9O0Phtlw21pIJDbc7rhXbDBElcGSw+IitCCxeFkoDR+w+wf2MW+eQkc
         xlc85VLwgBM6R25r3PoRVrvpiFl75y92frVQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Fy89my5sctFwh7FDIjIFIWsdAJ9CrSGLVRuvngcahsrSoF+4kfgSdWm9fhyuNvnyiV
         CdIZCQYC4mq8EVEMi/SjydNSMHGIz0qlQvptX/x5Ze44yCcGyLSqDM80LYTkU4gcdN6B
         acB5ujBu34FxyaltbwTonIqLExrHi/sBzKM8s=
Received: by 10.150.102.37 with SMTP id z37mr5558114ybb.69.1263092475134;
        Sat, 09 Jan 2010 19:01:15 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3389353iwn.12.2010.01.09.19.01.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 19:01:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100110025641.GB1083@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136549>

As a verb, 'setup' is spelled 'set up'.  =E2=80=9Cdiff commands such as
diff-files=E2=80=9D scans better without a comma.  Clarify that shallow
and deep are special non-boolean values for format.thread rather
than boolean values with some other name.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bcfed1c..f7728ec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -537,7 +537,7 @@ apply.whitespace::
 	as the '--whitespace' option. See linkgit:git-apply[1].
=20
 branch.autosetupmerge::
-	Tells 'git-branch' and 'git-checkout' to setup new branches
+	Tells 'git-branch' and 'git-checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
 	starting point branch. Note that even if this option is not set,
 	this behavior can be chosen per-branch using the `--track`
@@ -725,7 +725,7 @@ diff.autorefreshindex::
 	contents in the work tree match the contents in the
 	index.  This option defaults to true.  Note that this
 	affects only 'git-diff' Porcelain, and not lower level
-	'diff' commands, such as 'git-diff-files'.
+	'diff' commands such as 'git-diff-files'.
=20
 diff.external::
 	If this config variable is set, diff generation is not
@@ -841,8 +841,8 @@ format.pretty::
=20
 format.thread::
 	The default threading style for 'git-format-patch'.  Can be
-	either a boolean value, `shallow` or `deep`.  `shallow`
-	threading makes every mail a reply to the head of the series,
+	a boolean value, or `shallow` or `deep`.  `shallow` threading
+	makes every mail a reply to the head of the series,
 	where the head is chosen from the cover letter, the
 	`\--in-reply-to`, and the first patch mail, in this order.
 	`deep` threading makes every mail a reply to the previous one.
--=20
1.6.6
