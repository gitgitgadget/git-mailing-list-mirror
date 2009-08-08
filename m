From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 5/9] add missing long options to 'git push bash completion'
Date: Sat, 8 Aug 2009 10:56:27 +0200
Message-ID: <9f50533b0908080156n3e990a69lc54e8ab4f0422d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhj5-00059w-V7
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbZHHI42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbZHHI41
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:56:27 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46859 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbZHHI41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:56:27 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1826831bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=W2C5vqh7aqK87BASKlYF1RprQzVRsrVhyEJJdiDhPJA=;
        b=hQ5Ws3M88WL5BvQTnLNySkukZTUxBPL1YGPdv2CwHp2AzYQCg7xFVGT4ZncrTR6pfr
         Yn1nQA93QmmBguefOyjsOLHESKJlG14nfYY20+Z6MzIabMiUeaOtdWjkvFgfGEhNki95
         dVAO/lOUw9SbiOx/iJJwOq15JaKdMPvqSqrmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=a7ebB781dVdt1UboroMmmXoGQftqyeetkcm399FwSYGXPePJ3GeoRO345AqI24xVCQ
         GSdAUfF8uWBSqyc4ikHjRaoJyCAOJ8fPfv4cF3NEACmK8ZFwdy2vTwfE7B4jcnt88eHx
         zvZ9mWh0hDmW03M7WepOPKEho4I20vaFD6Y8I=
Received: by 10.204.66.17 with SMTP id l17mr3359808bki.108.1249721787812; Sat, 
	08 Aug 2009 01:56:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125269>

according to git-push(1), the following long-options are missing to the bash
completion :
--porcelain
--thin
--no-thin
Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 contrib/completion/git-completion.bash |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index a4e78d5..98e1185 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1296,8 +1296,10 @@ _git_push ()
 		;;
 	--*)
 		__gitcomp "
-			--all --mirror --tags --dry-run --force --verbose
+			--all --mirror --dry-run --porcelain --tags --force --verbose
 			--receive-pack= --repo=
+			--thin
+			--no-thin
 		"
 		return
 		;;
-- 
1.6.4
