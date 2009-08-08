From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 3/9] add missing long options to 'git mergetool' completion
Date: Sat, 8 Aug 2009 10:56:09 +0200
Message-ID: <9f50533b0908080156ndd368cfxafbe6efeb341b8b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhit-00055o-2Y
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbZHHI4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755043AbZHHI4K
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:56:10 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46859 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbZHHI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:56:09 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1826831bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4AkpBQfighslD8OXYMopn9j0Boz2n3meGfH0XSxc7Mk=;
        b=WmU31yXFa0DxwkHo1ekVRc2QkNI9bhZ3YKD3JxIuvhHeCtrt9Jh5LnD/xX5xT0onVc
         R55jMhcBduxWhYBTEcCWeLFS/bfhvwctVJK53AL17buYVaZE+JM7T4Uz+YJefLa12U4/
         RqAW/JLBUCNNthwh868Yk1ncuIdLrBCB+E4h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Fm0BRtH/njKhJHVky9sUg9cCf5qUooSPoqjONmz4cv6t/Pb09QKyycpVrz050o22VE
         n+E/iLbHO9wwflksc1UXG1DVf5s8YWGhKzswT9TTFhpD/uv7iqQGLA5pIT5ISO2PsZ4R
         cUP0Jdb5S2pUfnSkSUFIwl/8SREmVRmXacqMI=
Received: by 10.204.117.20 with SMTP id o20mr3991073bkq.1.1249721769798; Sat, 
	08 Aug 2009 01:56:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125267>

according to the git-mergetool man page, '--no-prompt' and '--prompt' are
missing from the 'git mergetool' completion

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 9e86d28..f56733b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1232,7 +1232,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool="
+		__gitcomp "--tool= --no-prompt --prompt"
 		return
 		;;
 	esac
-- 
1.6.4
