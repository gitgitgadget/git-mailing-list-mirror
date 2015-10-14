From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: [RFC] Git based patch tracking and review
Date: Wed, 14 Oct 2015 18:30:43 +0100
Message-ID: <1444843845-8017-1-git-send-email-richard.ipsum@codethink.co.uk>
Cc: Richard Ipsum <richard.ipsum@codethink.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 19:33:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmPvK-0000N5-H5
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 19:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbbJNRdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 13:33:05 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:36543 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbJNRdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 13:33:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 6E0E8462045;
	Wed, 14 Oct 2015 18:33:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qa0aPxTA4soV; Wed, 14 Oct 2015 18:32:58 +0100 (BST)
Received: from salo.dyn.ducie.codethink.co.uk. (salo.dyn.ducie.codethink.co.uk [10.24.1.215])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 7A443461EC7;
	Wed, 14 Oct 2015 18:32:58 +0100 (BST)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279580>

Hi,

I've been working to add patch tracking and candidate
review to git. The motivation for this is simply that most patch
tracking systems are centralised, since git is a distributed vcs it
seems appropriate that patches, reviews and comments should also
be distributed.

The system aims to be fairly minimal, it adds a candidate
subcommand which can be used to manipulate the state of candidates:
add reviews, comment, submit new versions etc. This prototype is,
as you would probably expect, by no means complete, at this point
it seems useful to stop and ask where we should take this next.

git-candidate is written in perl, with the hope that in time it
can potentially be included within contrib.

The original source repository for this project can be found
at https://bitbucket.org/richardipsum/git-candidate

Richard Ipsum (2):
  contrib: Add git-candidate subcommand
  contrib/git-candidate: Add README

 contrib/git-candidate/GitUtils.pm        |  215 +++
 contrib/git-candidate/README.md          |  153 ++
 contrib/git-candidate/git-candidate.perl | 2602 ++++++++++++++++++++++++++++++
 3 files changed, 2970 insertions(+)
 create mode 100644 contrib/git-candidate/GitUtils.pm
 create mode 100644 contrib/git-candidate/README.md
 create mode 100755 contrib/git-candidate/git-candidate.perl

-- 
2.1.4
