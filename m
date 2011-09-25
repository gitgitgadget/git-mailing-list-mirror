From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Sun, 25 Sep 2011 21:23:00 +0100
Message-ID: <1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <op.v2byz2p80aolir@keputer.lokaal> <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net> <201109242259.p8OMxqIM026259@no.baka.org> <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net> <m31uv4rc47.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 22:23:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7vES-0001wB-8c
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 22:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab1IYUXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 16:23:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:41709 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab1IYUXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 16:23:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R7vEJ-0001t1-CT
	for git@vger.kernel.org; Sun, 25 Sep 2011 22:23:15 +0200
Received: from 31.64.20.134 ([31.64.20.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 22:23:15 +0200
Received: from a5158017 by 31.64.20.134 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 22:23:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.20.134
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182081>

Jakub Narebski wrote:

> With merging into branch with uncomitted changes your fairly well
> understood 3-way merge (sometimes virtual 3-way merge in the case of
> multiple common ancestors) would turn into 4-way merge.

I don't see why it would be a four-way merge rather than a three-way merge.

> Even if you
> can automate it somehow (I do wonder how Mercurial manages that),
> there could be problem resolving conflicts, unless you happen to touch
> different parts of file.

This behaviour is by design in Mercurial.  It's simple, and it works.  I've
never had a problem with resolving conflicts here, and I don't see why I
ever would.

>> And that, I feel, is a problem with Git.  In some cases, you can't do
>> things how you want -- you have to do things how Git wants.
> 
> Please take into account the fact that when you were creating your
> workflow to suit your situation you were "forced" to fit it to
> Mercurial abilities and best practices.  No wonder that it does not
> fit Git-ish workflows.

No, I came to the distributed world only recently, from Subversion.  I
choose to use clones over plain anonymous branching, over bookmarks, and
over named branching because I prefer the approach.  I can, of course, do
"Git branching" in Mercurial very easily if I want (with Mercurial
bookmarks).

> What you use uncomitted changes for, I would use is a separate branch,
> and keep it rebasing (something like using 'mq' in Mercurial).

Yes, but, as I mentioned, rebasing is less flexible.  A rebase here is
effectively a merge and a commit in one step, whereas my approach separates
the merge and the commit.

>> Another example of this is the lack of support for anonymous branching as
>> part of a normal workflow in Git.  Anonymous branching is very powerful and
>> very simple.  I use it all the time in Mercurial.
> 
> What do you use anonymous branching for?

Anonymous branching is great for minor divergence that isn't really
significant enough to deserve a name.  It's also great for branches that
*are* significant enough to deserve a name, but where you want to defer
naming the branch right up until you merge it into another branch.  At that
point you can 'name' the branch in the commit message.  (Of course, you
could also create a Mercurial bookmark at that point, and then you'd
essentially have a "Git branch".)

> Note that with Git by default pushing "matching" branches, you can
> create private local-only branches.  The have to have _some_ name
> (even if it is 'foo/temp'), but I think that it makes them perhaps
> more work to create, but easier to use (to switch branches)... and for
> single anonymous branch you can always use "detached HEAD".

>From what I read, detached heads are subject to garbage collection.
