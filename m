From: Eric Hanchrow <eric.hanchrow@gmail.com>
Subject: [PATCH] branch_merged: fix grammar in warning
Date: Fri, 25 Feb 2011 19:33:14 -0800
Message-ID: <AANLkTikgmA8useucn0T6Gp7m5ang8iy-a--L_2HuOk9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 04:33:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtAuk-0000gd-DH
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 04:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab1BZDdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 22:33:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1BZDdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 22:33:35 -0500
Received: by eyx24 with SMTP id 24so805281eyx.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=2/QI4HznpkC8Ev4mdS3EnkLoFCXrPCZW2+nIpbohGtg=;
        b=xmK3xk8PYtiFTp1kBEi2rTBc6WfCTB4/kkiqbhadrzRx0ttO3IPiJAYAjZX+RXIohm
         7kPBgN+iKeGGBqHyBianGO2L+W92tJR/JnqwuQbu3IQ+FSJTgmsl8JlDnY09v7tBVEn1
         B3MXIKRLfwutkglvAcbf7q98i3eoN2vApWk7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Ddrv6FrWTOoiYVWUOTzstOPcgAHolWabrYuVD0TEwRLNEVRdIkIN4QqNlF6f5/b/Vy
         3LsTwSap77Ng6h398Fepkd+54KiWobsVdwB2d8wm+p0Flsp4fbu8mlibaLM+yJiEjjW9
         RO2o0HMuM+JucZDA3x80cyfYrTb82z9OkMbcs=
Received: by 10.14.10.141 with SMTP id 13mr2147329eev.45.1298691214115; Fri,
 25 Feb 2011 19:33:34 -0800 (PST)
Received: by 10.14.126.19 with HTTP; Fri, 25 Feb 2011 19:33:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167952>

 builtin/branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9e546e4..915f270 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -134,7 +134,7 @@ static int branch_merged(int kind, const char *name,
 	    in_merge_bases(rev, &head_rev, 1) != merged) {
 		if (merged)
 			warning("deleting branch '%s' that has been merged to\n"
-				"         '%s', but it is not yet merged to HEAD.",
+				"         '%s', but it has not yet been merged to HEAD.",
 				name, reference_name);
 		else
 			warning("not deleting branch '%s' that is not yet merged to\n"
-- 
1.7.4.1
