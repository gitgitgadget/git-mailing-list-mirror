From: John Goerzen <jgoerzen@complete.org>
Subject: Re: "Contributors never merge" and preserving history
Date: Tue, 26 Feb 2008 08:04:57 -0600
Message-ID: <slrnfs8749.prc.jgoerzen@katherina.lan.complete.org>
References: <slrnfs5pfh.lkc.jgoerzen@katherina.lan.complete.org> <alpine.LFD.1.00.0802251202380.14934@woody.linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 15:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU0Um-0006JC-JD
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 15:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759181AbYBZOI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 09:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760052AbYBZOI0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 09:08:26 -0500
Received: from main.gmane.org ([80.91.229.2]:56037 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759155AbYBZOIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 09:08:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JU0Tk-0001Of-5L
	for git@vger.kernel.org; Tue, 26 Feb 2008 14:08:20 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 14:08:20 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 14:08:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75138>

On 2008-02-25, Linus Torvalds <torvalds@linux-foundation.org> wrote:

[ snip ]

> So the reason you should generally pull from downstream rather than 
> upstream is that it keeps your development branch "focused" or "on target" 
> or whatever you want to call it. And that's always a good idea, because 
> now anybody who works together with you knows what he is getting.

Hi Linus,

Thank you very much for these two informative messages.  I think that
there were a lot of shades of gray to the kernel workflow that I failed
to appreciate before, for whatever reason.

I do have a question about the point you make above though.  I'm not
quite understanding what you're saying here.  Technically speaking,
the end result of a merge where you pulled from me would be identical
to a merge where I pulled from you.  Moreover, say I'm pretty far down
on the seniority list, kernel-wise.  Do you expect subsystem
maintainers to honor a request from me to pull from my tree, even if
they've never heard of me before, or would you think they'd only want
git format-patch output?

I ask because let's say I follow that advice above, and there are some
"downstreams" to me.  I pull from them, which involves some merging,
and then I want to format-patch.  It seems format-patch doesn't work
so well with merging.  What would I then do in this situation?  Should
I just use rebase to merge unless I know for sure that upstream will
honor a pull request?  But then again, we get into trouble if one of
my downstreams did a merge.

-- John
