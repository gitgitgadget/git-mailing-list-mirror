From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [SoC] egit: pre-proposal, problem recognition
Date: Sun, 23 Mar 2008 22:44:10 +0000
Message-ID: <200803232244.11031.robin.rosenberg.lists@dewire.com>
References: <47E532DD.7030901@gmail.com> <20080323075241.GL8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	gsoc@spearce.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 23:45:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdYwI-0006Mj-Fw
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 23:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbYCWWog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbYCWWog
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 18:44:36 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27717 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbYCWWof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 18:44:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 50B4680284F;
	Sun, 23 Mar 2008 23:44:33 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kvQxM0ji8ouM; Sun, 23 Mar 2008 23:44:32 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 068DE802658;
	Sun, 23 Mar 2008 23:44:31 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080323075241.GL8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77973>

Den Sunday 23 March 2008 07.52.41 skrev Shawn O. Pearce:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:

Welcome Marek.

> > Let's start from some clean-up:
> > http://git.or.cz/gitwiki/EclipsePluginWishlist - isn't this site a
> > little outdated? It appears that tasks: Commit, Switch Branch (without
> > dirty workspace/merge support) are already done, aren't they?
>
> Yea, I think you may be right.  I haven't been too current on egit
> lately, but I think these did get implemented.  Sometimes the wiki
> is out of date.  Happens because we would rather be working on code
> than updating the wiki.  :)

Deleting some stuff isn't that hard once you realize it needs to be done. 
Done.

> > Some operations look for me as rather straight-forward to implement -
> > not appropriate for a whole GSoC project (or do I underestimate?).
> > Namely: Create/Delete Branch, Create/Delete Tag, Gitignore, Checkout(?).
>
> I think you are right.  Doing all of them might be a GSoC project,
> but a lot of it is just busy work and not that interesting of a
> challenge.  Sure, it has to be done by someone, and everyone will
> appreciate the effort once its complete, especially if its done well.
> But doing just one of them as a GSoC project would be too small.
I agree it's not really the challenge a GSoc project should be. Leave for 
newcomers that wants something simple to chew. We can do that a patch
at a time.

> > GSoC2008 site states, that most wanted tasks are (that's reasonable)
> > Push and Merge implementation. Fetch operation also looks to be not
> > implemented yet?
>
> Fetch and clone are in progress.  Robin Rosenburg (the current egit
> maintainer) has it just about finished and will probably contribute
> it soon.  But I think its going to cause merge conflicts with my own
> revwalk work.  So that's why fetch isn't on the GSoC 2008 ideas list.
Yes, fetch (and clone) over git and git+ssh works on my machine. I did not go 
into the http based version which is a different story altoghether so it is 
still open.

> > So what can I do:
> > I think that 1-2 from 3 main jgit+egit tasks (Push, Fetch, Merge) appear
> > to be well-sized for a GSoC project. IMO, there is also need for a lot
> > of smaller improvements in egit itself: preferences, preference page,
> > user-friendliness related: more icons and information, help in dialogs,
> > wizards, menus etc. I'm thinking of taking 1 main task - implementing
> > first jgit part, then egit part. And if I finish it before time, I could
> > work on set of such smaller improvements in egit itself, to make it
> > easier/nicer for user.
>
> Yes, I agree with that, except no fetch, as it will hopefully merge
> before GSoC summer officially starts.  A lot of the polish you are
> talking about leaving to the end of the project is critical for any
> good GUI.  I would not mind seeing it worked once the major features
> are completed.
>
> I did want to start on push work myself.  But if a student comes
> along and does it for me, then awesome. :)

Push implies writing a highly efficient packing mechanism (actually could
work without the efficiency in form of delya packing, but I'm not sure we want 
that).

> > operation) as main-task, but Merge also looks interesting. What is more,
> > I perceive Merge and Fetch operations as most wanted, because being on
> > project critical-path, blocking implementation of other tasks. Merge
> > seems also to be used very often itself.
>
> Yes.  Lots of interesting git features (cherry-pick, revert, rebase)
> are heavily based upon diff/apply and merge.  diff/apply can be
> implemented in terms of merge in many cases, and we do that a lot
> in C Git. So we do really need a working merge implementation.

A subproject of that is making graphical merge resolution inside Eclipse. That
might not be such a big project though depending on how much support
there is in eclipse. I haven't looked into it really.

> > For Merge: I'll need to implement 3-way merge algorithm. Wiki says that
> > one can look at Eclipse, if it is already implemented there. IMHO it's
> > better to implement it at jgit level, independently of egit, basing on
> > original git implementation, don't you think (I've seen that there are
> > some efforts to implement git plugin for NetMeans, basing on jgit
> > library)? I wonder how laborious this task is, i.e. as for Fetch/Push:
> > does translation of this algorithm written in C to Java requires
> > significant changes or improvements to existing jgit code?
>
> Yea, I wrote that statement about using merge code from Eclipse,
> but lately I have been thinking that is a bad idea.  Another person
> has stated to talk about using jgit to build a Git NetBeans plugin,
> and in another case there may be some idea of compiling jgit to
> CLR and using it for a Git Mono plugin.
My mind wanders...

> There is currently little-to-no merge support in jgit.  All of it
> needs to be ported in, or obtained from a suitable Java library that
> we can embed and ship as part of the package.  C Git for example
> embeds and ships libxdiff for most of its diff/merge code.
>
> > What do you think about importance of each task and what is your feeling
> > about time needed to implement each?
>
> I think merge is a huge task, especially if you have to do your own
> file level merge implementation by porting in say libxdiff to Java.
> Focusing on merge may take the better part (or all!) of a GSoC
> summer, but if you finished early then I would suggest doing the
> much needed UI additions like you discussed above.
>
> > I've got some experiences with JSch (bad experience...) and Trilead SSH
> > (much more postive) - BSD-licensed SSH implementations for Java.
>
> Interesting that JSch wasn't a good experience.  Eclipse has just made it
> an official part of the core platform, even without the IDE and its CVS
> plugin.  I was sort of hoping that given it is now fully integrated into
> Eclipse, and its key management is just part of the workspace, that we
> could take advantage of that in egit.
The current fetch uses Ganymedes for SSH. It seesm to work well and has
lots of features for key management. There is an SHA-1 implementation there
also that should be a bit faster than Sun's default.

>
> > To this time I was working on many smaller projects, and one bigger (>1
> > year, BSc and grids related), mostly in small teams, sometimes
> > distributed. It seems to be great experience if I can join git
> > community:)
>
> You can join any time.  GSoC is just a good execuse.  :)
>
> > PS BTW: I've wonder what "Checkpoint project" in Eclipse Team menu
> > stands for?
>
> That's my fault.  A long time ago egit stored the workspace back
> out as trees, rather than using the standard .git/index file.
> It was slow and cost a lot of time, so I tried to put that activity
> onto a low priority background job.  The job caused more problems,
> so Robin got rid of it.  But the menu option to allow the user to
> force a checkpoint is still there.
I left it and almost forgot about it. We should probably drop it completely.

(sorry for not cleaning up my response fully here. bedtime)

-- robin
