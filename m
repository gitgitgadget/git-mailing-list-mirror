From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git todo-list ?
Date: Tue, 24 Apr 2007 20:24:22 +0100
Message-ID: <200704242024.28010.andyparkins@gmail.com>
References: <f36b08ee0704231544r53d1bfbej7ddee0c66d894f3c@mail.gmail.com> <Pine.LNX.4.64.0704241312210.28708@iabervon.org> <Pine.LNX.4.64.0704242028350.6954@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>,
	Yakov Lerner <iler.ml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 21:25:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgQdE-0007wv-KV
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 21:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423042AbXDXTYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423052AbXDXTYs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 15:24:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:16074 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423053AbXDXTYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 15:24:47 -0400
Received: by ug-out-1314.google.com with SMTP id 44so261824uga
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 12:24:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JTL9kLMBDpO+/wZ22upSZeMGMkwH2Xz4XYFw49lAxs7+cZdta7TH9Tg0wmZrJhKo6MBZM/pfrTVk/zIbFKPCyL+O0/x5zaRSF5A2P9sPACNg4PFTEc6KmDtarmGp6X+jYzphL2le8utdWP+lbC4Gdf26RUr9qhIoO7gE76D/Ee4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sF7GS/AjpOVYhCe/Y/6CwmRTqDRkmOs+cgjYHCuZAiCpGT+NGyETN2cifc509R8N5X73V7DEk/G2uMVOeuESSaOo/Veelg6jsduipmhZQ492te1o26PE3RSkkiAJgXL49vTBOYokl4DphX35gm0BOxncbJ+LfGM0SXMTylGe2ls=
Received: by 10.67.115.9 with SMTP id s9mr801417ugm.1177442683959;
        Tue, 24 Apr 2007 12:24:43 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id e33sm1906427ugd.2007.04.24.12.24.41;
        Tue, 24 Apr 2007 12:24:42 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704242028350.6954@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45486>

On Tuesday 2007, April 24, Johannes Schindelin wrote:

> Like Junio said, it is not starting it, but maintaining. (BTW Andy, I
> am still waiting for that list...)

Ask and ye shall receive.   I had to make it look pretty first didn't I?
Couldn't just send you any old rubbish.

The only remaining things are hardly worth worrying about or weren't accepted
any way.

Enjoy.

----------------------------------------------------------
ADP niggle list
===============

 * git-revert should be called git-invert.  It doesn't remove a change
   from history, it simply applies another commit that does the
   opposite of whatever commit you are "revert"ing.  That's an inversion.
 * git-branch is not verbose enough when creating a new branch, for a new user
   a little reassurance that what they meant to happen has happened would be
   nice.
 * git-fetch output is confusing:
    remote: Generating pack...
    remote: Done counting 189146 objects.
    remote: Result has 186566 objects.
    remote: Deltifying 186566 objects.
    remote:  100% (186566/186566) done
    Unpacking 186566 objects
    24% (44792/186566) done
   Some questions from the point of view of a newbie: what is a pack?  what is
   an object? Why is the remote counting them?  Which remote am I reading
   from?  What am I fetching?  What is "Deltifying"?  How much data do I have
   to download (number of objects doesn't tell me).  How long has this taken?
   How long is left to go?
 * Similar things can be said about git-clone
 * Similar things can be said about git-push
 * git-show-branch output is cryptic.


Not accepted by list
--------------------

 * git-apply output is horrible.  It says a few things about whitespace on
   stdin then just finishes.  When it succeeds.   When it fails, it just says
   failed, it doesn't say why a particular hunk failed.
 * git-rebase/git-cherry-pick/git-reset/etc should all tell the user that they
   need to run git-prune to tidy up after themselves.
 * git-add has no output, whether it works or not
 * git-cat-file is badly named.  git-cat-object would be slightly
   better.
 * In general the principle for messages should be the same as for
   presentations:
    - say what you're going to do
    - do it
    - say what you did
   So for example, "git-branch newbranch existingbranch" would say
    Branching at "existingbranch", hash XXXXXXXXXXXXXXXXXX
     - created branch "newbranch"
     - your working branch is "existingbranch"
   Rather than the nothing that it currently outputs.


Accepted but unimplemented
--------------------------

 * git-rebase --skip requires that the offending file be clean with
     git-checkout HEAD file
   before the skip will work.  Why?  The fact of the skip is enough
   knowledge for rebase to know that I don't care if the merge is lost


Fixed
-----

 * Apart from a little convenience of being able to add trees, I'm not
   really sure that git-add is different from git-update-index --add

   git-add is now more powerful and can replace update-index

 * We should never have to see git-update-index; instead git-rm, git-mv
   and git-add would take its place.  git-add would get new functionality
   where it can be used on already tracked files and hence would be renamed
   to, say git-prepare.

   git-add is now more powerful and can replace update-index.

 * git-fetch has to be in working root.  If I can do git-push from anywhere in
   my tree, why can't I do git-fetch?

 * git-reset has to be in working root.  If you typically sit in, say "src/",
   it's annoying to have to change directory to do a reset.

 * git-verify-tag would be nicer as a switch to git-tag

 * git-commit doesn't (generally) have output - after a commit, it's difficult
   to know if anything happened.  Get users used to the idea of hashes to
   identify commits by telling them which one they just made.  Tell them if
   they made a branch as well, which branch they are now on.

 * git-init-db says "defaulting to local storage area", as if that is
   meant to be a helpful message.

 * git-commit without "-a" and without an "update-index" says "nothing
   to commit", which isn't an adequate message to help a user who hasn't
   realised they need to update the index

 * git-merge output is horrible - this affects git-pull, git-rebase,
   and git-cherry-pick.  Issuing "fatal" errors and then carrying on is very
   confusing.  Errors in merges appear multiple times.  The files upon which
   which there is a conflict are spread throughout the output.  Most of the
   output is not relevant to an average user.

 * It would be really nice to be able to do an arbitrary checkout, rather than
   having to make a branch for it.  Then I could do
    git-checkout remotes/origin/master && make
   (obviously committing with a non-branch HEAD would be prevented).
   I think this is going to be a pre-requisite for submodule support





-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
