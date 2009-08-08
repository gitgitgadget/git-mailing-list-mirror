From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 6/9] update 'git-rm' bash completion according to the man page
Date: Sat, 8 Aug 2009 10:56:40 +0200
Message-ID: <9f50533b0908080156t7cfd05ebg3e5d29f7d2260c25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhjO-0005Fz-08
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbZHHI4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755269AbZHHI4k
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:56:40 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46859 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906AbZHHI4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:56:39 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1826831bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=05uJ7MK+T30D5p4etwaLyTbBy6zR3KdMFxRE5t30EBI=;
        b=xzw3dDfoAEg4pxOAiMqQwY5DOjXLn50DdqNz6O2nQd+tVEmH7hzDvG+Dx2GMVyfSZ+
         QTEtneLlsWd9xC5I8mI2dGQxocffhG6LH905L8Nm9iTU4Zu1T5M0g1BP48pnXgygR1KE
         +y/uufzKMDCRj1zCZhDAf6HK9N23FI9SasRmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PwAxXS73Zmf5p9+G+4BN/HL2pnl/rwMMeAQSRUEHsPiN2UKWzTqRC+phsQvXEkjOnW
         G1bJfVmmYHjqZHiEoFz8URM+3d2GXNZ7CfHm8GOMHwe/iy5Z7Xe51dD4WfKlbZKOuo7N
         dKGWB+ikzgcvzVNkEvjzFWRqFre3n1QOMRd9Q=
Received: by 10.204.112.11 with SMTP id u11mr3960661bkp.134.1249721800508; 
	Sat, 08 Aug 2009 01:56:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125270>

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 98e1185..4746eee 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1828,7 +1828,7 @@ _git_rm ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "--force --cached --dry-run --ignore-unmatch --quiet"
 		return
 		;;
 	esac
-- 
1.6.4
