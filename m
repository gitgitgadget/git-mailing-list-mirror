From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 2/2] git-rebase.txt: clarify that --abort checks out
	<branch>
Date: Tue, 05 Jul 2011 17:43:16 -0400
Message-ID: <1309902196.31762.30.camel@drew-northup.unet.maine.edu>
References: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 05 23:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeDQ8-0007SQ-Eb
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 23:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab1GEVoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 17:44:34 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:51990 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab1GEVoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 17:44:34 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p65LhMAd018630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 5 Jul 2011 17:43:27 -0400
In-Reply-To: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p65LhMAd018630
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1310507047.28858@b1qWVAi554bDazz88jVW5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176628>


On Fri, 2011-07-01 at 22:38 -0400, Martin von Zweigbergk wrote:
> The description for 'git rebase --abort' currently says:
> 
>     Restore the original branch and abort the rebase operation.
> 
> The "restore" can be misinterpreted to imply that the original branch
> was somehow in a broken state during the rebase operation. 

When you are in the middle of a rebase you _are_not_on_any_branch_. This
is why "Restore the original branch" is used. I have to admit that it
could potentially be clearer, but your solution alas is not.

> It is also
> not completely clear what "the original branch" is --- is it the
> branch that was checked out before the rebase operation was called or
> is the the branch that is being rebased (it is the latter)? Although
> both issues are made clear in the DESCRIPTION section, let us also
> make the entry in the OPTIONS secion more clear, like so:
> 
>     Abort the rebase operation and check out <branch>.

So when I rebase I'm really checking out another branch--which, just to
increase confusion, doesn't actually exist? What if there isn't another
branch (rebase -i on a single-branch repo, for instance)? This doesn't
solve the problem.

> 
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---
> 
> This was basically suggested by Jonathan in [1] ('git rebase
> --discard'/'git rebase --abort --stay' or whatever it should be
> called). Since I have not had much time for Git lately, I thought I
> would just post these two patches for now, in case it will take time
> before I get a chance to move even the simple work in [1] forward.
> 
> 
>  [1] http://thread.gmane.org/gmane.comp.version-control.git/174655/focus=174683

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
