From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Comments on Presentation Notes Request.
Date: Wed, 7 Jan 2009 19:14:35 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901071731050.19665@iabervon.org>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKiZ8-0007YP-NX
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbZAHAOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbZAHAOj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:14:39 -0500
Received: from iabervon.org ([66.92.72.58]:45058 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbZAHAOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 19:14:37 -0500
Received: (qmail 29480 invoked by uid 1000); 8 Jan 2009 00:14:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2009 00:14:35 -0000
In-Reply-To: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104855>

On Tue, 6 Jan 2009, Tim Visher wrote:

> Hello Everyone,
> 
> I'm putting together a little 15 minute presentation for my company
> regarding SCMSes in an attempt to convince them to at the very least
> use a Distributed SCMS and at best to use git.  I put together all my
> notes, although I didn't put together the actual presentation yet.  I
> figured I'd post them here and maybe get some feedback about it.  Let
> me know what you think.
> 
> Thanks in advance!
> 
> Notes
> ---------
> 
> SCM: Distributed, Centralized, and Everything in Between.
> 
> * SCM Best Practices
> 
> ** Allow and Encourage Customer Participation
> 
> Most shops seem to attempt to funnel customer participation through
> the developers.  This is a cache miss for many operations such as
> developing the user manual by a design team external to the
> development team.  Basic operations such as commit and update are
> fairly simple to grasp and can even be simplified further through
> scripts and other such tools that non-developers can quickly be taught
> to use.
> 
> Of note is the Tortoise family of tools which integrate directly into
> Windows Explorer.  This makes it fairly easy for anyone who is
> familiar with Windows Explorer to get into using any of the tools that
> there is a Tortoise implementation for.

I still want an office software package with "commit" instead of "save" 
(when in a repository), and a mail program with "push" instead of "attach" 
and "fetch" instead of "open". (See below)

I think that the sales department should be using distributed version 
control, neatly packaged up.

> * The Centralized Model
> 
> ** We Know About This One
> 
> This is traditional, plain vanilla, ubiquitous SCM.
> 
> The great majority of the SCMSes out there are centralized.
> 
> Closely resembles the Client/Server system model.
> 
> ** Work Flow
> 
> <http://whygitisbetterthanx.com/#any-workflow>
> 
> *** 2 basic models: 'Lock, Modify, Unlock' and 'Copy, Modify, Merge'.
> 
> Older systems were primarily Lock, Modify, Unlock implementations.
> You would checkout a file that you intended to work on, and no one
> else would be able to check it out until you unlocked it, signaling
> that you were done editing it.  This is inherently inefficient as on a
> team of developers, the chances that two are working on the exact same
> part of a system without knowing it and coordinating are fairly low.
> Also, any disparate features that still touch the same files in the
> system cannot be worked on simultaneously.
> 
> The answer to this is Copy, Modify, Merge.  In this system, every
> developer gets a complete copy of the HEAD.  Everyone changes the HEAD
> concurrently.  When commits happen, the system attempts to
> intelligently merge them.  If it fails (usually doesn't happen unless
> there is bad coordination), then it asks you to merge them.  This has
> been proven to work well.

Git is almost unique in that, at the point where the user is asked to do a 
merge, the user's work is already preserved.

That is, most systems are: Copy, Modify, Merge, Commit. Git is: Copy, 
Modify, Commit, Merge.

> * The Distributed Model
> 
> ** This Ones New
> 
> At least new as in unfamiliar.  The concept is over a decade old.

In some fundamental ways, this actually resembles the "broadcast email" 
collaboration method. That is, a group is writing a document. Someone 
writes a skeleton, and emails it to everybody else. They make changes to 
different sections. When each person has changed something, they email the 
full document to everybody else. Before people send out their 
versions, they check their email and (painfully) merge the changes into 
what they've done.

This evolved into having a certain location to avoid the painful merge, 
and then to version control. Distributed systems go back to this model, 
except without the "(painfully)" and with all the other benefits of 
version control.

> There are a few different popular distributed SCMSes (Git, Mercurial
> (hg), Bazaar (bzr), Bitkeeper)
> 
> Very closely resembles a peer-to-peer network and the organic
> relationships that evolve in that space.
> 
> In a distributed system, there is no one point where all development
> comes together to for any reason other than policy.  Everyone who is
> working on a system intrinsically has their own copy of the entire
> repository.  All of the history, all of the source code, all of the
> public branches, all of the public tags, etc.  Because of this,
> developers can also have private branches, private tags, private
> commits, private history.  The distinction between public and private
> is very important in this context.  This has several distinct features
> which I'll go into now.
> 
> ** Work Flow (Pick Your Poison)
> 
> <http://whygitisbetterthanx.com/#any-workflow>
> 
> ** Key Properties
> 
> *** Private/Public Concept
> 
> Distributed SCMSes Private/Public ontology is __much__ richer.
> Whereas in a central system, private means only what you have yet to
> commit or what you are leaving untracked, in a distributed system,
> private means anything that you have not yet _chosen_ to make public.
> In other words, you can have private branches, private tags, private
> committed changes to your copy of the head, etc.  Anything that you do
> not specifically publish to a location that others can access is
> intrinsically private.
> 
> In other words, you can finally SCM your sandbox!  You can commit as
> many broken things as you want to a private repository, giving you the
> ability to have a nearly infinite set of undoable and recoverable
> changes, without breaking anyone else's build.  Or, you can just as
> easily ignore TDD, never commit anything for 3 weeks and then do a
> big, massive commit and as long as your final product is tested and
> merges with the rest of the tree, you're good to go and no one cares.

Although you'll be really sad if you accidentally wipe out your work after 
2 1/2 weeks...

> Because you have a rich ontology for private/public data, you can also
> do crazy things like rewriting your local history before anyone else
> sees it.  Because your repository is the only one that has to know
> about the history as long as you're dealing with private data, this is
> a completely safe (although policy debatable) operation.  Of course,
> once data has been published, you really shouldn't mess with its
> history anymore.

You can also see this as writing a new history. If you knew starting out 
everything that you knew when you finished, you might do things 
differently, and the results would likely be more useful. Writing a new 
history lets you start over from where you started, while being able to 
refer to the final working state that you came up with.

> *** Must Learn New Work Flows.
> 
> In order to fully experience the advantages of distributed systems,
> new work flows must be learned.  In other words, it's possible to use
> distributed systems nearly the exact same way as you use a centralized
> system (you just need to learn new commands), but you don't get many
> of the benefits except the speed improvements.  The real game change
> happens when you realize that you can keep things private until their
> finished.  Once you realize that, new branching patterns emerge, new
> work flows happen, you commit more often, and have the ability to
> become much looser and freer in your development process.

My experience bring git to a small company is that people don't need to 
learn new workflows. They can go on with their old workflows and develop 
new ones as they streamline their work. The one exception is really that 
they have to be told that, in git, you commit before merging instead of 
merging before committing.

> *** Impossible To Completely Enforce A Single, Canonical
> Representation of the Code Base.
> 
> By nature, a distributed system cannot enforce a single canonical
> representation of the code base except by policy, and policies can
> always be broken.  Also, any intentionally private data is not backed
> up because it is not shared.  However, backup becomes much simpler
> because you know that no one else is committing to your repository.
> 
> This bears some explanation.  Within a distributed system, you can
> have a single official release point that everyone has blessed (or the
> company has blessed, or the original developer has blessed, or
> whatever).  However, you cannot _stop_ someone else from making a
> release point because their repository is just as valid as yours.  You
> cannot _stop_ developers from sharing code between themselves without
> going out to the official central location.  All you can do is ask
> them not to.

And you might not want to ask them not to. It's really nice to be able to 
reassign a developer to a different task and pass that developer's 
incomplete and not-ready-for-prime-time work to somebody else.

> * Why Git is the Best Choice
> 
> ** (Un)Staged Changes
> 
> Git employs the concept of the Index or Cache or Commit Stage.  This
> is also unique to Git, and it's pretty strange for developers coming
> from a system without it.
> 
> Basically, There are 4 states that any content can be in under Git.
> 
> 1. Untracked: This is content that Git is completely unaware of.
> 2. Tracked but Unstaged: This is content that has changed that Git is
> aware of but will not commit on the next commit command.
> 3. Tracked and Staged: This is the same as unstaged except that this
> content will be committed on the next commit.
> 4. Tracked and Committed:  This is content that has not changed since
> the previous commit that Git is aware of.

1, 4, and something in between are normal; the only extra is 
distinguishing 2 and 3.

> This is very powerful yet somewhat awkward to grasp.  Basically, the
> upshot of this feature is that you can manually build commits if you
> want to.  Say you were working on feature foo and then made some other
> changes because you came across feature bar and thought it would be
> quick to do.  In any other system, the only way you could commit parts
> of what you'd changed is if you were lucky enough for the disparate
> changes to be in different files.  In that case, you could commit only
> the files that you wanted to change for the different features.
> However, if you made disparate changes to the same file, you were
> stuck.  In Git, you can stage only parts of the files to an extreme
> degree.  This allows you to create as many commits as you want out of
> a single change set until the whole change set is committed.

It's pretty common for a system to support:

$ (sys) commit <filenames...>

At its core, the index just lets you tell git about those files on 
multiple command lines instead of just one. And it lets you make 
unincluded changes after you give it a file but before you commit. And it 
lets you fabricate the contents that you're putting in. But really, it's 
about being able to list the things to include one-by-one. (Well, really, 
it's about being able to make 100 commits of a 30000-file project in under 
a second, but that's just the original inspiration.)

> I've found this to be particularly useful when working with an
> existing code base that was not properly formatted.  Often, I'll come
> to a file that has a bunch of wonky white space choices and improperly
> indented logical constructs and I'll just quickly run through it
> correcting that stuff before continuing with the feature I was working
> on.  Afterwords, I'll stage the formatting and commit it, and then
> stage the feature I was working on and commit that.  You may not want
> that kind of control (and if you don't, you don't need to use it), but
> I like it.
> 
> ** Cryptographically Guarantees Content
> 
> One of the most surprising things I learned as I was researching this
> was that most SCMSes do not guarantee that your content does not get
> corrupted.  In other words, if the repository's disk doesn't fail but
> instead just gets corrupted, you'll never know unless you actually
> notice the corruption in the files.  If you have memory corruption
> locally and commit your changes, you just won't know.
>
> Git guarantees absolutely that if corruption happens, you will know
> about it.  It does this by creating SHA-1 hashes of your content and
> then checking to make sure that the SHA-1 hash does not change for an
> object.  The details of this aren't as important as the fact that Git
> is one of the very few systems that do this and it's obviously
> desirable.

You can still get a situation where the content gets corrupted before it 
gets into git, and git happily tracks your corrupt content. But that's 
pretty obvious.
