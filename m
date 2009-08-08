From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 4/9] add missing long option to 'git grep' bash competion
Date: Sat, 8 Aug 2009 10:56:18 +0200
Message-ID: <9f50533b0908080156h23415740lb94cbd9f2c6a165d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:56:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhj5-00059w-7j
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbZHHI4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZHHI4U
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:56:20 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:43086 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbZHHI4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:56:19 -0400
Received: by fxm28 with SMTP id 28so170150fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=kasCvf2Ujrog7NMNfLpii8NGGKfMKtekXbYzVCHsnIw=;
        b=ljUGZELI3h6s9pRnFeN5YMn6HEGItbUPIYk4B89zUYFNyKmQIIwD23bjp0MOUDtPGs
         B4XjOXG1yqHrLZVGgH4pjEZ1SqE+diNHzB8aYjV9NpCvRZ8vKY/mzC8s7yKdkziQVe3/
         ZvvTHDaQo1QsW7ejMgIbUF17vyvvAEnD8yxb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=kEJz5jST+MgyW9T91BpXKWzZLKZL4Vr3LXAdcftItr9/xSt3xb7rv6oysdGKcX3UE2
         KJPOl7CxNwfIwDG7uvJVT24ult7+TLLvXVmy1VtTO9Vv5uOYFfx3OrPQUqWZDabDVETJ
         DZZ+tOtMeJBWKm4N4bKexNJqmnBhBTU8bG4cE=
Received: by 10.204.104.7 with SMTP id m7mr925301bko.24.1249721778591; Sat, 08 
	Aug 2009 01:56:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125268>

according to the 'git-grep' man page, the following long options are missing
from the 'git grep' bash completion :
--null
--color
--no-color

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index f56733b..a4e78d5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1057,7 +1057,9 @@ _git_grep ()
 			--extended-regexp --basic-regexp --fixed-strings
 			--files-with-matches --name-only
 			--files-without-match
+			--null
 			--count
+			--color --no-color
 			--and --or --not --all-match
 			"
 		return
-- 
1.6.4
