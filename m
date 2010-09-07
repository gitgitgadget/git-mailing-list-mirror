From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] t2105 (gitfile): add missing &&
Date: Mon, 6 Sep 2010 20:49:10 -0500
Message-ID: <20100907014910.GD1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brad King <brad.king@kitware.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnL8-0007nV-8c
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab0IGBvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:51:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51312 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab0IGBvI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:51:08 -0400
Received: by yxp4 with SMTP id 4so1696483yxp.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hUy40/Yt0E0RTcb7J623NOJgP2h84IogWRbtvU9OusQ=;
        b=m9ISbfwdsfFP7ovIpuKhocwe6l/VtMnuTqnRpA/YDR3kSx8iYjFifzaoFwn8kNMzNg
         thvzCS/pmtSpZrN/a4NkVtweq5u3ifyX2wcdyHi6Sva2xnDUL7sPl184gIPHLfGkcN7q
         ymQDYSSqbOfwlDLOJ/SCTGB082BMz232tBIi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CsH7v1sKrQFUiTWauPITqyMyt6ht+R52mYt+ZLwgx20pgsx0mlCyzFWNwnbOmRUlZX
         SqpiORAlxufEg719oPoWi+KsvbfDsfQivVChhQdtXzIZYIUZr0LMONx1ehzB3yikDS0P
         H3r783hB7eUkOeCPNXO2cMLJwq3EoSfJrbFic=
Received: by 10.151.109.9 with SMTP id l9mr471759ybm.340.1283824267984;
        Mon, 06 Sep 2010 18:51:07 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id x3sm4352944ybl.22.2010.09.06.18.51.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014135.GA1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155660>

Make sure early failures are not masked by later successes.

Cc: Brad King <brad.king@kitware.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t2105-update-index-gitfile.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2105-update-index-gitfile.sh b/t/t2105-update-index-gitfile.sh
index 641607d..a7f3d47 100755
--- a/t/t2105-update-index-gitfile.sh
+++ b/t/t2105-update-index-gitfile.sh
@@ -13,7 +13,7 @@ test_expect_success 'submodule with absolute .git file' '
 	(cd sub1 &&
 	 git init &&
 	 REAL="$(pwd)/.real" &&
-	 mv .git "$REAL"
+	 mv .git "$REAL" &&
 	 echo "gitdir: $REAL" >.git &&
 	 test_commit first)
 '
-- 
1.7.2.3
