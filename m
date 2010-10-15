From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 13:30:06 -0500
Message-ID: <i9a6kn$d7o$1@dough.gmane.org>
References: <loom.20101012T114900-532@post.gmane.org> <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com> <loom.20101014T095743-275@post.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 20:31:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6p3d-0003aH-2o
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 20:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332Ab0JOSbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 14:31:01 -0400
Received: from lo.gmane.org ([80.91.229.12]:51614 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328Ab0JOSbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 14:31:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P6p3R-0003VB-JI
	for git@vger.kernel.org; Fri, 15 Oct 2010 20:30:57 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 20:30:57 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 20:30:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159127>

"Christian Halstrick" <christian.halstrick@gmail.com> wrote in message 
news:loom.20101014T095743-275@post.gmane.org...
> Thank's a lot for all your responses. I know now how to solve my problem. 
> I'll
> definitely not going to commit my unit-test before my fix and publish that
> because then I would have commits in the history where tests fail. But 
> other
> suggested solutions do work.
>
> Still, all that sounds like workarounds for a lacking feature. Checkout 
> content
> to the worktree without altering the index. What do you think, couldn't 
> that be
> added as an option to checkout?
>
> -- Chris

FWIW, my understanding of the index is that it is the middle-man for moving 
things from your work-tree to the object-store AND for moving things from 
the object-store to your work-tree.  Therefore, when you checkout the blob, 
it first gets copied from the object-store to your index and then from the 
index to your work-tree.

However, there is an option in git-commit to copy files directly from the 
working-tree to the object-store by totally bypassing the index, but no one 
seems to do this or recommend doing this as normative practice.  None the 
less, this "exception" in the git-commit manpage does seem to set the 
precedent, so maybe it is also conceivable to copy objects directly from the 
object-store to the work-tree by totally bypassing the index.

Please note that I am responding because I am interested in the discussion 
and not because I know the answer.  I am not a git programmer so my 
observations only symptomatic and/or theoretical as a user.

v/r,
Neal 
