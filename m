From: Johannes Sixt <j.sixt@viscovery.net>
Subject: gitk dev branch: F5 gives error after commit
Date: Mon, 07 Jan 2008 17:52:06 +0100
Message-ID: <478258B6.20006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 17:52:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBvDM-000056-ND
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 17:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbYAGQwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 11:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbYAGQwK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 11:52:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55984 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbYAGQwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 11:52:09 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JBvCp-0003en-R8; Mon, 07 Jan 2008 17:52:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1B9646B7; Mon,  7 Jan 2008 17:52:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69795>

I use the dev branch of gitk (on Windows), commit 476ca63 (gitk: Index
[fnvr]highlights by id rather than row).

1. Start it with:

    gitk --all -300

2. Make a commit.
3. Hit F5. Here I see the error message:

   Error reading commits:
   fatal: bad revision '^-300'

At this time the label of the current branch is already gone from the
commit list. There are no other changes made in the display.

Hitting F5 again does nothing. I have to create a new view to get an
updated display.

Any help is appreciated. Thanks,
-- Hannes
