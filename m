From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v0 1/3] doc/git-rebase.txt: remove mention of multiple strategies
Date: Thu, 21 May 2009 19:47:07 +1000
Message-ID: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 11:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M74sR-0007AZ-72
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 11:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbZEUJrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 05:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbZEUJrW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 05:47:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:41883 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZEUJrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 05:47:21 -0400
Received: by rv-out-0506.google.com with SMTP id f9so325308rvb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=jPkT7I5CBk5uObyK++/vs4beRng28/ZL0peTzQkFvdI=;
        b=HFgKoimzBfTc3FhtQSH3bB2UuJE7STJIPq/oXb1o5uSqFQDmFXlSU73AuQR7l1ISMC
         uDuyHJ4olhkoveV4b/wwtBISmUq7FGcxdiVbcJCNCcrxcvJp3w9j2UmA8gJzFKbS45OU
         1zbT0m4taw0+OHV5Ho9q5wsWn2RbtWxHVShyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ESSCqJy+OYQjjeiIsVUBwo6y0iqajmABEZ3Kma0jY8ZbVnyJUzWsCojIMUjVKazTIe
         tw4xCuWS1xluhSJ6Xs+72Cqx8x3ANcNg7ke4QgqX5uIvS1QYdc1Rfs+021Y54dpakS00
         Rl/9lELSP0JL/63WGXl9VfUvmZyqzL46pR9sA=
Received: by 10.141.48.10 with SMTP id a10mr1027771rvk.250.1242899242808;
        Thu, 21 May 2009 02:47:22 -0700 (PDT)
Received: from dektop ([121.91.24.237])
        by mx.google.com with ESMTPS id f42sm6085065rvb.11.2009.05.21.02.47.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 02:47:22 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 21 May 2009 19:47:14 +1000
X-Mailer: git-send-email test
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119666>

git-rebase.sh does not seem to support this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I have starred at git-rebase.sh many times and still don't know how
 it can do multiple strategies. So assume it's wrong, remove it.

 Documentation/git-rebase.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 3d5a066..26f3b7b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -231,8 +231,7 @@ OPTIONS
=20
 -s <strategy>::
 --strategy=3D<strategy>::
-	Use the given merge strategy; can be supplied more than
-	once to specify them in the order they should be tried.
+	Use the given merge strategy.
 	If there is no `-s` option, a built-in list of strategies
 	is used instead ('git-merge-recursive' when merging a single
 	head, 'git-merge-octopus' otherwise).  This implies --merge.
--=20
test
