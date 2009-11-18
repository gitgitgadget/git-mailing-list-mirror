From: "George Dennie" <gdennie@pospeople.com>
Subject: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 07:55:45 -0500
Message-ID: <005a01ca684e$71a1d710$54e58530$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <torvalds@osdl.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkB4-00017H-7L
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570AbZKRNCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbZKRNCS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:02:18 -0500
Received: from smtp116.rog.mail.re2.yahoo.com ([68.142.225.232]:39410 "HELO
	smtp116.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756361AbZKRNCS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 08:02:18 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2009 08:02:17 EST
Received: (qmail 45470 invoked from network); 18 Nov 2009 12:55:44 -0000
Received: from CPE001cf04d66c9-CM0012c9a0913a.cpe.net.cable.rogers.com (gdennie@99.244.179.211 with login)
        by smtp116.rog.mail.re2.yahoo.com with SMTP; 18 Nov 2009 04:55:44 -0800 PST
X-Yahoo-SMTP: zge3jO.swBAK2Pj1ZBh8nVciRpiiK2CUUeAJch.zCNP5zAk-
X-YMail-OSG: JTxlG3MVM1lYbeRMPewwZ2zH5ywu9oFwAGcHsEoyoH_sG72NV.ewi5PzlE9lvK8rJQ--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: Microsoft Office Outlook 12.0
thread-index: AcpoTklAycCzarlGRSOH+haHVPN0YA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133166>

A Clean checkout command might be...

The Git model does not seem to go far enough conceptually, for some
unexplainable reason...

In particular, why is Git not treating the entire working tree as the
versioned document (qualified of course by the .gitignore file). 

Instead, Git is treating a manually maintained list of files within the
working tree as the versioned document, this list being initialized and
manually amended by the "Git add/rm/mv" commands, etc. 

The result is conceptual complexity and rather counter-intuitive behavior.
For example, adding and renaming files outside of Git is not considered
editing the version until you subsequently do a "Git Add ." Contrast that
with editing or deleting files outside of Git. Yet adding and renaming files
and folders is a significant part of substantive projects, especially in the
early stages and experimental branches.

Granted, this is not a big deal functionally, but what is being lost is
conceptual simplicity (and consistency, in my book) and conceptual
simplicity is a key value point, if not THE key.

Also can we augment checkout to totally CLEAN the working directory prior to
a restore. If necessary we can augment .gitignore to stipulate those files
or folders that should be excluded from the cleaning. This suggestion is in
recognition of the fact that if you  are not versioning the file, it is
typically trash; which becomes the case when the entire working treat is
treated as the versioned document.

Consequently, I recommend the following new commands:
	"Git commit -x"   -- performs a "Git add ." then a "Git commit"
	"Git checkout -x" -- that clean the working tree prior to perform a
checkout

P.S.
Great your work.

George Dennie, BMath
The Point Of Sale People
www.pospeople.com
BUS: 416-496-2921
FAX: 416-496-9496
