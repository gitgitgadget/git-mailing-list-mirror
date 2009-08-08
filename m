From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 9/9] update 'git apply' bash-completion according to its man 
	page
Date: Sat, 8 Aug 2009 10:57:18 +0200
Message-ID: <9f50533b0908080157r6e58a6a4rf42ff684d095c002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhjy-0005Py-SO
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbZHHI5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932963AbZHHI5S
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:57:18 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46859 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbZHHI5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:57:17 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1826831bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=JNCTMjg2auiy8+7OlenhXNI24JHz64nlT4Eqrf8HoYI=;
        b=x0snMTt99yi1lugUFfqKNQnGmuLtwBXarJ85A4k1x+5dZAt7VUe5oa9dSGay5q5UXx
         E89melulqb4BI29rEzPZa0qkbq6SQpMaNcQy/JcSG59wY+CLBM/fvsQHOqIWCe4W8n2R
         OAbYTg/tyK6SSautH9J2hGpQahMtJX8IkSt9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=R5aJpU5ICUmqul+QaZdEIJtSqTicFRligGo75o85MINFWoGWKhEj3cBrqwDzVB8upY
         ealIR+6McMRww7815dn0wgbcztC8GK6TNCaK6yR426qEnPngrCO5uYfZQeUXpx0Fzgw8
         c2P0CBFDOAMYLZIpT1Q1tKfzPFLXy5h37C/rE=
Received: by 10.204.98.14 with SMTP id o14mr648624bkn.125.1249721838288; Sat, 
	08 Aug 2009 01:57:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125273>

---
 contrib/completion/git-completion.bash |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 8ba1249..c08422c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -694,9 +694,15 @@ _git_apply ()
 	--*)
 		__gitcomp "
 			--stat --numstat --summary --check --index
-			--cached --index-info --reverse --reject --unidiff-zero
-			--apply --no-add --exclude=
+			--cached
+			--build-fake-ancestor=
+			--index-info --reverse --reject --unidiff-zero
+			--apply --no-add
+			--exclude=
+			--include=
 			--whitespace= --inaccurate-eof --verbose
+			--recount
+			--directory=
 			"
 		return
 	esac
-- 
1.6.4
