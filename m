From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 2/9] add missing long options to 'git difftool' completion
Date: Sat, 8 Aug 2009 10:55:45 +0200
Message-ID: <9f50533b0908080155w55c89c36l6237c93f7ac00383@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:56:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhiZ-00050f-Lm
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbZHHIzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbZHHIzp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:55:45 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46859 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918AbZHHIzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:55:45 -0400
Received: by bwz19 with SMTP id 19so1826831bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=M5Qmi4Aclo1tNxU5/vY9PN/ICMHtOuDCqddnL/P7dOs=;
        b=DFRmVQjOP0GaR96y5B+JEqcC2m2KTLyNuzauyPaD0c/P/pJIgg89EimC0WlXNRtp97
         L2k1NQmmFmvuVZ3wpsa6w/jF21Cjgg4pc2b2loYSLhOWJIvx3s8I9eV5pdQfDtORdbQP
         sh/5eX1CI8QYldFrWIYlZKQZdOpXJ/vWlIhCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=QGsNvCdekTkr2ilY8deAF9/X3RyIugc+1jEpZflHLWzkvfxISUZ4z6LX1aqePulWZF
         X1WnHVpfM7YB4i8PWhyN+yHnb/+e5BzX+76b8MkgYUv7OqTD7HEc3/dco1Ks7p7akLs0
         1QMoDTV+fCc+vkCDFcjhzs7vOM69QyXoOzgcU=
Received: by 10.204.103.210 with SMTP id l18mr3944210bko.206.1249721745050; 
	Sat, 08 Aug 2009 01:55:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125266>

according to its man page, git-difftool has 3 long options :
--tools=, --no-prompt and --prompt. The last 2 options are missing.

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index bc5427f..9e86d28 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -960,7 +960,7 @@ _git_difftool ()
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
