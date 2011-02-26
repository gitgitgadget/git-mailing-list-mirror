From: Eric Hanchrow <eric.hanchrow@gmail.com>
Subject: Re: [PATCH] branch_merged: fix grammar in warning
Date: Sat, 26 Feb 2011 05:03:37 -0800
Message-ID: <AANLkTikL1KkSTeNgT2dhE2bGBu5FHY8HiqxfjPMd90sT@mail.gmail.com>
References: <AANLkTikgmA8useucn0T6Gp7m5ang8iy-a--L_2HuOk9d@mail.gmail.com>
 <AANLkTimN2ba8Ab2BRp=sU4NT_e6UYh4HH2L7afgEkHg8@mail.gmail.com> <7vbp1z8apg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 14:04:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtJol-0005tS-SA
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 14:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab1BZNEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 08:04:08 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47890 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab1BZND6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 08:03:58 -0500
Received: by eyx24 with SMTP id 24so869367eyx.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 05:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=09dOp0g6FsTVlkdk3r9dry0azP4JMmG4m/1dENxPwy8=;
        b=UrAkz6XndI9ZYQrfsKSQrnfcgeVVLSgn5v85kNHXVJbU+LG6bDZ3Ov2hysOrRgIih5
         3v6/6MwV+JzP9JUXDxk4daTW8d12V6Sgnr+zUa7QENqr6G1dHB06NcKm5uOzXxdEkA+q
         UcQcO3FZjIy9JHfa3FDlMY9g0f6IseKYvOL3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b69j/dipYAItDIlx7v/tcrQNuMAGV0CxwAduoWMiUVWvzi+iI/BCEGoHsSCKSvud8G
         d97v8k7UHy308lSOiqEQTmSAM3diJDgtvGcicJXg+A2ldcFSO3cky6qzXrVawAisQtiJ
         ASjqr76nDSzs1TdZnsGHfpcxVjfWIQF9sVfvs=
Received: by 10.14.17.193 with SMTP id j41mr1444666eej.38.1298725437109; Sat,
 26 Feb 2011 05:03:57 -0800 (PST)
Received: by 10.14.126.19 with HTTP; Sat, 26 Feb 2011 05:03:37 -0800 (PST)
In-Reply-To: <7vbp1z8apg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167981>

OK, here it is again:
From 5445193baac417831d849b9ef5acd5197859bd0b Mon Sep 17 00:00:00 2001
From: Eric Hanchrow <eric.hanchrow@gmail.com>
Date: Fri, 25 Feb 2011 19:29:42 -0800
Subject: [PATCH] branch_merged: fix grammar in warning

Signed-off-by: Eric Hanchrow <eric.hanchrow@gmail.com>
---
 builtin/branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9e546e4..27c2000 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -134,7 +134,7 @@ static int branch_merged(int kind, const char *name,
 	    in_merge_bases(rev, &head_rev, 1) != merged) {
 		if (merged)
 			warning("deleting branch '%s' that has been merged to\n"
-				"         '%s', but it is not yet merged to HEAD.",
+				"         '%s', but has not yet been merged to HEAD.",
 				name, reference_name);
 		else
 			warning("not deleting branch '%s' that is not yet merged to\n"
-- 
1.7.4.1
