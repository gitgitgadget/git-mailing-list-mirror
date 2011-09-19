From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: Where is information of "git read-tree" stored?
Date: Mon, 19 Sep 2011 21:52:10 +0200
Message-ID: <j586pb$emh$1@dough.gmane.org>
References: <loom.20110919T103707-867@post.gmane.org> <7vzki0a0yd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 21:56:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5jxN-0004ls-6D
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 21:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab1IST4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 15:56:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:39358 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab1IST4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 15:56:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R5jxG-0004fk-GA
	for git@vger.kernel.org; Mon, 19 Sep 2011 21:56:38 +0200
Received: from p4fd18d8c.dip0.t-ipconnect.de ([79.209.141.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 21:56:38 +0200
Received: from Manuel.Spam by p4fd18d8c.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 21:56:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd18d8c.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Firefox/6.0.2 SeaMonkey/2.3.3
In-Reply-To: <7vzki0a0yd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181697>

Junio C Hamano wrote:
> It is unclear to me what you meant by "connection" "lost" and "recreated"
> above, but I am guessing I can ignore them, as long as I take it that you
> mean by that local mirror from the subversion repository "Bproject" below.

Yes. And the reference to it isn't pushed to the remote GIT server. If I clone 
the remote repo, then "git remote -v" doesn't show the reference anymore.

> That "how to" may be badly written and this may have been unclear to you
> but the first four steps are to be done _only once_ to set things up, and
> after that you need to run only the fifth step whenever you want to update
> from the Bproject. Could you suggest a better wording to update the doc?

As long as I don't understand what's going on here, I can't suggest how to 
improve the documentation.

> The very first "subtree merge" (the one that is recorded with the commit
> after the read-tree) records all paths from Bproject renamed to elsewhere
> in the merge result (you can view it with "git show -M
> $that_merge_commit")

Tried that, but the stuff, I saw on screen, doesn't make clear how GIT knew 
about what to do here.

I also still don't know how I can restore that whole setup if anything, I have 
on my local side, gets lost. Means, that anything, that I have left, is the 
stuff, I pushed to the remote GIT and the SVN, I want to have in my own tree. 
Which steps do I have to perform to restore the setup and have it working again 
without getting conflicts?

Maybe the risk of getting problems is too high and I should copy over stuff, I 
got from SVN, from time to time manually to my GIT repo?

Yours

Manuel
