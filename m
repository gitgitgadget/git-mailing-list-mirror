From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Tue, 10 Nov 2015 12:56:36 +0000
Message-ID: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
Cc: Richard Ipsum <richard.ipsum@codethink.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 13:56:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw8Tq-0000KT-UM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 13:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbbKJM4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 07:56:54 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45309 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbKJM4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 07:56:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 81FF046224B;
	Tue, 10 Nov 2015 12:56:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PwzZRoRXysFc; Tue, 10 Nov 2015 12:56:50 +0000 (GMT)
Received: from salo.dyn.ducie.codethink.co.uk. (salo.dyn.ducie.codethink.co.uk [10.24.1.218])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id DD23A461947;
	Tue, 10 Nov 2015 12:56:49 +0000 (GMT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281119>

Hi,

I've continued my work[1] to add patch tracking and candidate review capability
to git.

git-candidate now has a more git-like user interface, so remote candidates
can now be specified in a similar way to remote refs (e.g. origin/candidate)
as well as various other improvements, such as versioned metadata.

[1]: http://www.mail-archive.com/git%40vger.kernel.org/msg79461.html

Richard Ipsum (2):
  contrib: Add git-candidate subcommand
  contrib/git-candidate: Add README

 contrib/git-candidate/GitUtils.pm        |  207 +++
 contrib/git-candidate/README.md          |  154 ++
 contrib/git-candidate/git-candidate.perl | 2541 ++++++++++++++++++++++++++++++
 3 files changed, 2902 insertions(+)
 create mode 100644 contrib/git-candidate/GitUtils.pm
 create mode 100644 contrib/git-candidate/README.md
 create mode 100755 contrib/git-candidate/git-candidate.perl

-- 
2.1.4
