From: P Baker <me@retrodict.com>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers on 
	active trees]
Date: Tue, 31 Mar 2009 11:30:40 -0400
Message-ID: <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>
	 <20090330153245.GD23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 17:34:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lofyl-0003D4-NQ
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 17:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763187AbZCaPas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763249AbZCaPaq
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 11:30:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:25675 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763183AbZCaPao convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 11:30:44 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3150239qwh.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5VtJvUGWdnoe7PeWOd0BhDQD6PMrnoTo3iVLBVHfw2M=;
        b=KCf/ugDkfQW6drZLO4adDs2wq6zVoSnul2Ai28XRAD3u42dLPyht5RKVO1872VzXrE
         7dhsV2z9O99sNMnf3wR1MrWKTtamEJAEXj3cl4foIhqDlY2IdYNoorK8x4Y0UP0iAM+P
         c7p5dYxhznFieVnvjLxA57pFXta1q0DldZOXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=QZlp8ujaBybWuCe+MJVVnLPyDxc9zp+oAvCxLFoHdoDqnSkEOFpW2ZUOeSzY61/IZs
         k1LZd6D6gVvlbM7abJk+2WqhfbKdA6T96dxfwn4zHG0WgS8SOQuizLbkIuaoAPrUFZQB
         I4nrBsg3hpYqtjVPadhLNVXJ3MUhk45RRHv9Q=
Received: by 10.220.99.205 with SMTP id v13mr2254662vcn.65.1238513440258; Tue, 
	31 Mar 2009 08:30:40 -0700 (PDT)
In-Reply-To: <20090330153245.GD23521@spearce.org>
X-Google-Sender-Auth: 21b1d1eff9a2f0e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115266>

Great, thanks Shawn. I've included my responses to your
questions/comments below, and would love to continue the dialog - any
help with the application would be much appreciated. I'll work my
responses into my application and send it out again.

On 3/30/09, Shawn O. Pearce <spearce@spearce.org> wrote:
> Hi!  As someone who has coded around git submodule by creating "repo"
>  for Android, I'm certainly interested in git submodule improvements,
>  so this is a great idea for a GSoC project.  I have some comments
>  below that may help improve your proposal before you submit it.
>

I was going to send out another request for comments to the list, but
you beat me to it. The first part of my proposal is to get community
involvement, is this mailing list the best place to do that, or
something external, like a publicly editable site (e.g. a survey or
wiki)?

>
> > As opposed to ???remotes,??? which also incorporate external code i=
nto a
>  > project,
>
>
> I'm not sure what you mean by that.  Typically a "remote" in Git is
>  thought to be a configuration that says where to download a fork of
>  this project from.  By default you get one remote, called "origin",
>  which is where you initially cloned your fork from, but you can add
>  many more, such as other developers you frequently collaborate with.
>
>  This is quite different from the problem that submodule tries
>  to address, as its dealing with forks of of the *same* project.
>  But a submodule is trying to point to forks of *other* projects,
>  whose histories are (possibly) unrelated to this project's history.
>

Right. My point is that due to either perceived or real problems with
git-submodules, some folks have abandoned it and instead used
workarounds (see
http://flavoriffic.blogspot.com/2008/05/managing-git-submodules-with-gi=
trake.html?showComment=3D1210125780000#c1605130977296198852
for one example of such a comment). That so much effort has been put
into solutions external to git, shows that there is some pent up
demand for a solution built into git.

>
>  > The tentative timeline is:
>  >
>  > End of May ??? Conclusively finish the public discussion regarding=
 where
>  > git-submodules needs to go
>  > Beginning of June ??? Produce final specifications (including meth=
od stubs)
>  > Middle of July ??? Finish active code and test development
>  > End of July ??? Merge code into production release, fix public sub=
mitted bugs
>  > Middle of August ??? Prepare code for final release and finish
>  > user-facing documentation
>
>
> IMHO, this is too vague.  *What exactly* are the features you want
>  to add to git submodule?  Break this down by features, not by phases
>  of coding.
>

The features I have been considering are:
*move objects of submodules into base .git/ directory
**This would, as I understand it: protect submodules from being
overwritten and changes lost when switching between branches of the
superproject that might or might not contain the submodules and
centralize their management into one location.  The added benefits of
fully using git's ability to branch and merge submodules makes it
worth adding some complexity within the .git directory.

*use .git instead of .gitmodules
**I actually don't know why this was included with the project
description, I searched for an explanation of the desired name change
on the mailing list and in commit messages, but came up with nothing.

*git submodule update --init should initialize nested levels of submodu=
les
**As an ease of use command, either an additional flag to recurse can
be added, or it can act by default. As a requested feature on the
mailing list, this is worth implementing.

*ability to update submodule pulled from svn repo
**One workaround is to clone it as local copy using git-svn and then
import that local clone as a submodule; clearly a clunky solution.
There are many requests for this feature (see
http://panthersoftware.com/articles/view/4/git-svn-dcommit-workaround-f=
or-git-submodules
for a typical example), and it makes sense integrating git-submodule
with git-svn would expand submodule's usefulness.

*make submodules deal with updated references
**Instead of issuing merge conflicts on updated submodule references,
this will allow submodules on default detached HEAD so that changes
from the local repo can be committed without first pulling changes
from the shared repo. See
http://flavoriffic.blogspot.com/2008/05/managing-git-submodules-with-gi=
trake.html?showComment=3D1211380200000#c3897235118548537475
for an explanation of how this made 'submodules...unsuitable for
active development'. Clearly losing this kind of functionality impairs
the overall usability of git and should be fixed.

*protect changes in local submodules when doing =E2=80=9Cgit submodule =
update=E2=80=9D
**This is similar to the previous point, in that changes need to be
protected or merged or warnings issued when updating the submodule.
The potential to lose work with no warning is a big no-no.

*make git submodules easy to remove
** See http://pitupepito.homelinux.org/?p=3D24, for an example of why
this is a pain. Adding a submodule has ui, removing one should as
well.

>  Further, you spend roughly a month writing method stubs.

Week max: end of May to beginning of June, but if I

>
>  Also, we very much prefer Git patches to update the documentation
>  at the same time that the code changes.

=46air enough. I was planning on starting documentation during the
stubbing phase, and then finishing it once having written the code.

>
>
>  > A few specific changes that this project will likely include are:
>  >
>  > *use .git instead of .gitmodules
>  > *move objects of submodules into .git/ directory
>  > *git submodule update --init should initialize nested levels of su=
bmodules
>
> > *protect changes in local submodules when doing ???git submodule up=
date???
>
>  As I said above, I'd like to see this described in the timeline
>  better, each of these could be done independently, so you could work
>  on one item try to get it completed, tested, documented, and merged
>  into Junio's tree, and then start the next item.

Ok, makes sense. I can redo the timeline like that, I'll order them by
my priority and look for community input on re-ranking them and adding
or subtracting features.


>
>  I'd like to know more about each of these items, and less about
>  the general reasoning of where you got these feature ideas from.
>  What exactly are you talking about changing, and why? I don't need
>  to see detailed code at this stage, but I'd like a better descriptio=
n
>  of the user-visible changes that each bullet point might cause,
>  and why you feel this change is better than what we have today.
>

See above.

Phill Baker
