From: "Eric Raible" <raible@gmail.com>
Subject: bash completion: 'git apply' should use 'fix' not 'strip'
Date: Sat, 9 Aug 2008 01:24:31 -0700
Message-ID: <279b37b20808090124w356ca692s4c6d95c833beebeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 10:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRjld-0000pn-63
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 10:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYHIIYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 04:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYHIIYd
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 04:24:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:1436 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYHIIYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 04:24:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2272765wfd.4
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=m80TVWoqnaL79rSwmYfhxNnOw9Hm5DMDf2PaEzwfjsE=;
        b=qPENIz+cC8xszUniij+DEkThgfHVvI6Wn0GI4BSZMzhhhVvsiU4TMaajkL7oBvtVX5
         DQSyG1mCx3uBd0p75Qp08z70/sReNQzp89mnhnDiYmcuBSYTtA01EEAyxuyUzwhkTPQg
         g3f5Og1I3Hf0YFLAS3ouzfSssH5yhLlPIv6H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=tk3Jq/oSBkdeNj6xStb+oQCTOvHGN7Lf8kmLBLUfSCszU9AmuH/3iAsDa3/iHK8uzB
         Oo9rQ5zAAJGgNc6hgEw4lRo9Ee+ruKku9/MYqCPrS8Cai5PSa4Ki+pDuZQrU+YzBNnWn
         DnOqRVrqHIzPs3BM3hoRWfskmszAtMR0QK8ss=
Received: by 10.142.170.3 with SMTP id s3mr1270201wfe.252.1218270271382;
        Sat, 09 Aug 2008 01:24:31 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Sat, 9 Aug 2008 01:24:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91752>

Bring completion up to date with the man page.

Signed-off-by: Eric Raible <raible@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 3396e35..95040bd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -501,7 +501,7 @@ __git_has_doubledash ()
        return 1
 }

-__git_whitespacelist="nowarn warn error error-all strip"
+__git_whitespacelist="nowarn warn error error-all fix"

 _git_am ()
 {
--
1.6.0.rc1.1206.gff2cf
