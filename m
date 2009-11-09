From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 07:22:17 +0000 (UTC)
Message-ID: <loom.20091109T080510-448@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com>  <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 08:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7OaM-0006FI-Rz
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 08:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbZKIHWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 02:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbZKIHWg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 02:22:36 -0500
Received: from lo.gmane.org ([80.91.229.12]:57739 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZKIHWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 02:22:35 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7OaG-0006Df-Ie
	for git@vger.kernel.org; Mon, 09 Nov 2009 08:22:40 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 08:22:40 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 08:22:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132446>

Avery Pennarun <apenwarr <at> gmail.com> writes:

> There are three methods I know of to manage this:
> 
> 1) Just commit whatever version of a subproject you want as a subtree
> of your current project, and if you want to replace/delete/upgrade it,
> just do that.  (You rarely want to track the actual *history* of the
> third party tool, just the history of versions *you* used, which is
> easy to do.)

Ok. Does that mean that new component2 and common component1 should leave on the 
new branch (having in mind that old component2 and component1 are still living 
on previous branch)? So, how many efforts will I need to get both component1 
versions in sync (it is supposed that most of the changes in this component are 
common for both)? Is is supposed that having 2 branches for this component is 
cheaper (from development cycle POW)?

> 2) Use git-submodule to link repositories together.  (Arguably, one
> major reason 'repo' was written is that git-submodule is too
> complicated, though.)

> 3) Try my git-subtree tool, which basically makes it easier to
> split/join repositories (similar to #1) without losing the history
> (similar to #2).

I'll try to learn it.

I suppose, both these tools (repo and git-subtree) are the indication of some 
contradiction between  the tool and SCM practice (especially, for big projects).

> 
> Basically, performance is linear with the number of files in your
> repo.  If you can check out just a "slice" of your repo (say 10% of
> the whole), you'll have faster performance (eg. 10x) from any VCS.

Yes, I just wish to see this feature in some VCS. Why not Git? ;-)

> So I can see an argument that Windows users would want arbitrary
> "slices" much more often than Linux+git users, but I think this is
> largely due to performance, not because people really *want* to be
> stuck with a restricted view of the repo.

How offten do you use this info? I mean the whole stuff?
