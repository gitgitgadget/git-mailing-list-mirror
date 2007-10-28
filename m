From: "Yin Ping" <pkufranky@gmail.com>
Subject: How to merge git://repo.or.cz/git-gui into git.git
Date: Sun, 28 Oct 2007 18:57:06 +0800
Message-ID: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 11:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im5q0-0007AX-5n
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 11:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbXJ1K5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 06:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbXJ1K5J
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 06:57:09 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:32931 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbXJ1K5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 06:57:07 -0400
Received: by py-out-1112.google.com with SMTP id u77so2275250pyb
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=b24m4kOJat5vcBSKTlxi/CzFpwtkaFN7+qfrZwzBBFg=;
        b=J8NQlCYJzxL/ISfOmnX+f3/FrbYrFBfkWl3g7hp3T+lzLGYo26zRxXKhNONllZvjAvIFDK00ZOjoU63MkGWXecRALKRbCKehivlQHgCj4S3R02+QjO5Ptuk2BZ/nOOwo6ILXJUElZQDYAnuc6E4+iEVurS0iHaovssQzOoQY1c8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EWD8uZ4vcqR/gGJTmomKXBlZxzv7rwJcNURL+gAV26K6C/toHILq1/ks3y46e2lDf/mz2q1D8qfosSXUfh8xIsCI0YmWYHxm9GIkMEnhbW+azVq5wdtHk7x/uoShfeqySQsNt6bHbhraOAGQtlZpRL/mX191tZt9vsLzyxSUtac=
Received: by 10.35.72.1 with SMTP id z1mr5986525pyk.1193569026524;
        Sun, 28 Oct 2007 03:57:06 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Sun, 28 Oct 2007 03:57:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62551>

I'm reading code of git.

When I type
gtlg --topo-order --pretty=oneline --abbrev-commit e92ea624 -p
in directory git cloned from git.git, I get

e92ea62... Merge branch 'master' of git://repo.or.cz/git-gui
c80d25d... git-gui: Correct 'git gui blame' in a subdirectory
diff --git a/git-gui.sh b/git-gui.sh
index 743b7d4..fa30ccc 100755
--- a/git-gui.sh
+++ b/git-gui.sh
...

git-gui.sh is in the git-gui directory but we see a/git-gui.sh here
other than a/git-gui/git-gui.sh.
And in git://repo.or.cz/git-gui, I see git-gui.sh in the top directory

I just wonder how does this happen and how to merge
git://repo.or.cz/git-gui into git.git this way?


-- 
franky
