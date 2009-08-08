From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 8/9] update the 'git am' bash completion according to the man 
	page
Date: Sat, 8 Aug 2009 10:57:06 +0200
Message-ID: <9f50533b0908080157x7f54eb7t74f3e3a2153977a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:57:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhjo-0005Mb-F4
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933117AbZHHI5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbZHHI5H
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:57:07 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:50157 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbZHHI5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:57:06 -0400
Received: by fxm28 with SMTP id 28so170297fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=WfEW2USamYDeFOX+zq+Na2qFQ0mGzBbVliFS5rhkEek=;
        b=vWOssTclOLyQz5HUAD494z9SPMvKs7+d/9PnSDIc4lpTEzgebzZHbl6/QPGeXABb/M
         yRrcfxKO8jcxi+AGmPY3kbgJkqOCvNeBGlX+GZRrcrVkplldYFhFloTq27Q9ZZ37qawA
         T4rpC7oW0VrhKCwVPwfpIeqzFKOfEB7YInw7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=knPvywsiuczN1srv5uqXLLNr+IMWOk9MWQiiuqPlYz6mBiagCTdqouG/v9x9XnD0jP
         OQJSYaOUfRrSuuCfUwoA6WMSil1DgA23d9e07hwov7qrdpdfDEo51qeERAH7y8FG3x6Y
         TxrkFGy+DHBL16Sq/m9V2U6ib8q03/RZAy9R0=
Received: by 10.204.67.146 with SMTP id r18mr3997260bki.88.1249721826395; Sat, 
	08 Aug 2009 01:57:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125272>

---
 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 1e3efe3..8ba1249 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -675,7 +675,8 @@ _git_am ()
 		__gitcomp "
 			--3way --committer-date-is-author-date --ignore-date
 			--interactive --keep --no-utf8 --signoff --utf8
-			--whitespace=
+			--whitespace= --directory=
+			--reject --quiet
 			"
 		return
 	esac
-- 
1.6.4
