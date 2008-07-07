From: "Eric Raible" <raible@gmail.com>
Subject: [PATCH] completion: add branch options --contains --merged --no-merged
Date: Mon, 7 Jul 2008 13:41:54 -0700
Message-ID: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, szeder@ira.uka.de,
	spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jul 07 22:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxXx-0006I8-PG
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbYGGUl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 16:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbYGGUl4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:41:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:54068 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709AbYGGUlz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 16:41:55 -0400
Received: by wx-out-0506.google.com with SMTP id h29so898152wxd.4
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HrdqLtTWLpiC6ZMjPltH+m0cNTe4xzS0l6DUXJhVyfc=;
        b=kfUgo68D1LmhGgRUTUiIYdITzDMXOPLEamUw5b57xeVizphz/+HSpWpK5ty078XJww
         8lHlQ1gk0+FW2bHtv4diMg/pxGaC34/sBetO6Mare09kl3FuOUME9RVhJ6eZbYvYlDax
         pEwqvQSHuVTqBWorxid7oQrQaeukzgvr0l95s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QQqu8Bk2CW2CRBXhzhUUhPkriIxjNW3fKChibVy1EhIHFxYklC2d3YVn5arx50Wp9B
         XnNII8t2taRcSusAWBzrJjl/1arfoaJt62qzsumyAqHejJD29DUv/cLLRKBH8FHevHnO
         kCoJopJYXyM0abOxtviTkJtTYFcJ9RL/ubSH4=
Received: by 10.142.48.14 with SMTP id v14mr1489121wfv.121.1215463314245;
        Mon, 07 Jul 2008 13:41:54 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Mon, 7 Jul 2008 13:41:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87650>

Signed-off-by: Eric Raible <raible@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 0eb8df0..22e109d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -546,7 +546,7 @@ _git_branch ()
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
-			--track --no-track
+			--track --no-track --contains --merged --no-merged
 			"
 		;;
 	*)
-- 
1.5.6.1.1071.g76fb.dirty
