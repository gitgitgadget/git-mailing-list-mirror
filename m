From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 7/9] update 'git-show' bash completion to match the man page
Date: Sat, 8 Aug 2009 10:56:53 +0200
Message-ID: <9f50533b0908080156j33db6f99u18de79537677451b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhja-0005Jd-6W
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbZHHI4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755280AbZHHI4x
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:56:53 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46859 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277AbZHHI4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:56:53 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1826831bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=NRGFVDz/PLYcKNKo8IOnItHDtG529t9jQ6ALX6q9I0s=;
        b=p2NnEs8aXkb/Z8Etcws+2LmBrhydX0Y6shn/t4woisNdah9fuBKAdd5JBpF1Hd4OWs
         fuiNgnYd4t6vI7tKLqq70Rn3Q5PKpYNf/R3UT5tkKE+SPGDY8VLvollfh2PMQiN8xDsb
         /2rDFdVJ07RcYRLRgqgQtfus4ECz/UrpvKUto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=hleMeUFQ+m/g01c+afafYlD9O8+UYPKcoDx3tiw6ltgkBFRrXAXh11gIyyLVnjdmeY
         T0GRR5uLTm5lILVV33UBfa51E6lg4/42oiXYG7vDcKk5qh5gSVBS+GcIHbq8hfgrXhWr
         QM8A9B/UsjEJ2QmGEb4JUjEXSFfUsGDBfSncE=
Received: by 10.204.114.194 with SMTP id f2mr354290bkq.96.1249721813954; Sat, 
	08 Aug 2009 01:56:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125271>

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 4746eee..1e3efe3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1870,7 +1870,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --oneline
+		__gitcomp "--pretty= --format= --abbrev-commit --oneline --encoding
 			$__git_diff_common_options
 			"
 		return
-- 
1.6.4
