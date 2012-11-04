From: Joern Huxhorn <jhuxhorn@googlemail.com>
Subject: git svn problem, probably a regression
Date: Sun, 4 Nov 2012 21:31:17 +0100
Message-ID: <36370AA5-4BB9-4D36-95A7-BB3DA315C9E6@googlemail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 21:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV6r1-0003aA-Oi
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 21:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab2KDUbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 15:31:23 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52753 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab2KDUbW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 15:31:22 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so2615120eek.19
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 12:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer;
        bh=YN/Be2fSIwHvsb0klTOAOe25YbDtLl9+V0BCUuis76U=;
        b=idCh9QvMhmfSbdPowr1pi15PF4dPRigyZBvhQ8XAOQ4LToGXahiOPwnFjHgQBJeRPm
         8qqniMp5nd3Vb1AEaYhR56/E1ig9ntPbgJct67/RjoWwNIS54NIJLsas54Q7hV3eUxFz
         zNIJBjOuDWOigNsC7CbaFTSe2I+ga1QErXLFeDSASzaiX9/RVwK0i+OnFWGdwjIB/lV5
         WRiqsuzpa0ks8HFdTefxPOJ2uLIekOmDahZJhpB2oaRb12rgT1tACLS/wrfTOPJ+8CSQ
         Gl+2SX/TWl4MvV9tHNwBlyWHHZhLFaU7Bbc134IzsG2i+InqZALXa5nIMutgHxZh8F11
         DobA==
Received: by 10.14.184.2 with SMTP id r2mr28856489eem.43.1352061081160;
        Sun, 04 Nov 2012 12:31:21 -0800 (PST)
Received: from [192.168.2.160] (p579DD3E0.dip.t-dialin.net. [87.157.211.224])
        by mx.google.com with ESMTPS id z43sm42680042een.16.2012.11.04.12.31.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Nov 2012 12:31:20 -0800 (PST)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209039>

git svn failed on me with the following error while cloning an SVN repository:
r1216 = fcf69d5102378ee41217d60384b96549bf2173cb (refs/remotes/svn/trunk)
Found possible branch point: svn+ssh://<repositoryName>@<IP address>/trunk => svn+ssh://<repositoryName>@<IP address>/tags/xxxx_2008-10-22, 1216
Use of uninitialized value $u in substitution (s///) at /usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm line 106.
Use of uninitialized value $u in concatenation (.) or string at /usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm line 106.
refs/remotes/svn/asset-manager-redesign: 'svn+ssh://<IP address>' not found in ''

I'm running git 1.8.0 via Homebrew on OS X. It was called via svn2git but I doubt that this is the culprit.
A colleague of mine was able to perform the same operation with git 1.7.x (not sure which) on Debian so I assume that this is a regression.

I just wanted to let you know.

Cheers,
Joern.