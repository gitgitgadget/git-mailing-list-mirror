From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git svn: Support multiple branch and tag paths in the svn repository.
Date: Thu, 25 Jun 2009 15:25:27 -0700
Message-ID: <7v3a9o0x48.fsf@alter.siamese.dyndns.org>
References: <4A3A4945.6050307@drmicha.warpmail.net>
	<1245335463-4488-1-git-send-email-git@drmicha.warpmail.net>
	<4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com>
	<20090625093602.GA3997@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxNv-0004vb-Mz
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 00:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZFYWZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 18:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbZFYWZZ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 18:25:25 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50748 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbZFYWZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 18:25:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625222527.DUKE17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jun 2009 18:25:27 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8NRT1c00K4aMwMQ03NRTUD; Thu, 25 Jun 2009 18:25:27 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=BNPWM5ARfUQA:10 a=Hbzmh3xeAAAA:8
 a=Ee8u8gBEAAAA:8 a=B-dM-7SxBEeJZNig-7MA:9 a=wledtB7ksqsmAAlS3yja54cfPA4A:4
 a=BEwxGj72lFYA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122250>

Eric Wong <normalperson@yhbt.net> writes:

> Acked and and pushed out to git://git.bogomips.org/git-svn along with a
> followup patch ...

Hmmm...

t9138-git-svn-multiple-branches.sh does not seem to pass for me.

    ...
    A    svn_project/tags_A/1.0
    A    svn_project/tags_A/1.0/a.file
    Checked out revision 3.
    ./test-lib.sh: line 329: .: filename argument required
    .: usage: . filename [arguments]
    FATAL: Unexpected exit with code 2
