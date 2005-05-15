From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: README rewrite
Date: Sun, 15 May 2005 08:17:09 -0700
Message-ID: <20050515151709.GC7391@tumblerings.org>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org> <4286F146.2090302@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 17:23:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXKxg-0006dQ-MA
	for gcvg-git@gmane.org; Sun, 15 May 2005 17:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEOPXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 11:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVEOPXL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 11:23:11 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:55447 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261658AbVEOPWN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 11:22:13 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DXKrd-0004PD-Nq; Sun, 15 May 2005 08:17:09 -0700
To: Wink Saville <wink@saville.com>
Content-Disposition: inline
In-Reply-To: <4286F146.2090302@saville.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 14, 2005 at 11:50:46PM -0700, Wink Saville wrote:
> Zack,
> 
> Good improvements, especially for neophytes like me who don't read enough 
> and get confused when cg-init has the word DEPRECATED in its help:)
> 
> Questions/Suggestions:
> 
> 1) How do I actaully apply the patch supplied in the email, where 
> readme.patch was the contents of the email. I tried as below, but that 
> didn't work.
> 
>    wink@tuxws cogito-0.10 $ cg-patch < readme.patch
>    patching file README
>    patch unexpectedly ends in middle of line
>    Hunk #1 FAILED at 1.
>    1 out of 1 hunk FAILED -- saving rejects to file README.rej

Don't use cg-patch. Just go into the Cogit directory and do

patch -p0 < readme.patch

> 
> I "read" the patch and would like to suggest some additional information 
> regarding cg-pull and revisons. My understanding is that it pulls the new 
> "change sets" from the "parent" to my repository. I then should be able to 
> compare the differences as per:
> 
>   "Using cg-pull is useful for a variety of purposes, for instance if you 
>   want
>    to construct a diff against the latest version of the upstream sources, 
>    but
>    don't want those changes to disturb your ongoing work. cg-pull will 
>    update
>    your .git directory with the history you need to construct your diff,
>    without merging that history into your tree, potentially breaking your
>    changes."
> 
> But I don't know how to cg-diff after the cg-pull? Well as I was writing 
> this it dawned on me that if I did a cg-pull I should try:
> 
>    cg-diff -r origin
> 
> by golly it worked.
> 
> So it appears a "cg-diff" with no parameters will show me the changes 
> between my working tree and the "HEAD of my repository" and appears to be 
> the same as cg-diff -r HEAD. ("working tree" appears to mean the contents 
> of what I "see" and therefore includes my uncommitted changes and 
> "Repository" refers to contents under .git. Is that correct?)

Yes.

> 
> A "cg-diff -r origin" gives me the differences between my "working tree" 
> and my "origin's" current state (as defined by previous "updates" plus any 
> unmerged pull's and there could be several pulls without merges).
> 
> Is the above correct?

Yes.

> 
> Another area of confusion for me is what are revisions I think I understand 
> what "origin" and "HEAD" are but how would I reference others? For instance 
> how to cg-diff between the HEAD and the revision before HEAD (or the one 3 
> days ago or ...)? Can "tags" be used as "revisions" (i.e. as "-r tag-xxx").
> 
> Actually looking in the repository I see that "origin" appears to be a 
> "branch" not a revision, what is the relationship between a branch, tag and 
> revision's? I have some experience with subversion and in subversion they 
> are actually all the same, simply the state of a "sub-tree" within the 
> repository at a particular "time". That time is defined by the repositories 
> current revison number which is incremented after each succesful commit to 
> the repository.

I don't understand branches yet, but tags are just a cute name for a
revision. A revision is identified by the SHA1 hash ID, which is ugly to
type, so you create use a tag for revisions you want to make special use of,
like for new project releases.

Be well,
Zack

> 
> Cheers,
> 
> Wink
> 
> 
> -- 
> No virus found in this outgoing message.
> Checked by AVG Anti-Virus.
> Version: 7.0.308 / Virus Database: 266.11.10 - Release Date: 5/13/2005
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
