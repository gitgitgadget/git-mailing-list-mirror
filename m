From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: For real now: bug tracking and secretary tasks in git
Date: Sat, 9 Jan 2010 01:38:50 +0100
Message-ID: <20100109013850.16f82412@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 01:39:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTPMF-0001So-OW
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 01:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab0AIAi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191Ab0AIAi4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 19:38:56 -0500
Received: from zoidberg.org ([88.198.6.61]:57232 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab0AIAiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 19:38:54 -0500
Received: from perceptron (xdsl-78-35-164-239.netcologne.de [::ffff:78.35.164.239])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 09 Jan 2010 01:38:52 +0100
  id 004E0077.4B47D01D.000047A2
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136500>

I thought about Cc'ing everyone who was involved in previous
discussions about this but that would have been a huge list so I
didn't. No more introductory stuff needed; onwards to the wonderfully
formatted proposal thingy!

I) SUMMARY OF EVERYTHING THAT EVER HAPPENED
-------------------------------------------

Mass consensus in previous discussions[1][2] goes a bit like this:

1. It would be desirable to have people who do the work of interfacing
   between bug reporters and developers. These same people could make
   sure reports didn't get lost. These people are the *secretaries*.
   They should be pretty reliable.

2. People who contribute to git shouldn't be forced to work with the
   tracker. Having a tracker that isn't actively maintained by dedicated
   secretaries is pretty much worthless anyway, so there's no need to
   pretend that forcing developers to use a tracker interface is any
   kind of improvement.

3. The "human element" is important. For example, automatic reminders
   are a lot less valuable than reminders from an actual person.

II) PROPOSAL
------------

Of course, since I am semi-formally proposing this, I'm also
volunteering to make it happen, BUT I think that no single person can
handle all the list traffic conscientiously enough to do a really good
job. This proposal can only work if more volunteers are found. If you
(and of course I'm speaking to YOU personally now) want to help out,
speak up now!

The proposal goes like this:

* Set up bug tracker (done; it's at http://gitbugs.jk.gs/).
* Optionally make it an official public bug tracker.
* To conform to (2) above, tasks are only ever assigned to secretaries.
  Whoever assigns a task to himself is responsible for finding someone
  to actually get the task done, and to keep that person on his toes.
  The bug tracker has features that make this easier (there is no
  actual field for "assigned to external entity 'dscho'" in the
  interface because there is no bug tracker software that doesn't suck,
  but a comment gets the job done, and you can send reminders to
  yourself).
* Tasks filed by the general public get pre-screened by secretaries;
  worthwhile tasks are (semi-manually, to conform with (3)) forwarded to
  this list. The task is updated with summaries of whatever gets
  discussed on the list whenever appropriate.
* Tasks get pruned mercilessly to remove anything that is irrelevant,
  e.g. comments that do not contribute anything to getting the task
  done.
* Things reported to the list get posted to the bug tracker by
  secretaries (unless, for example, patches have already been accepted
  by a maintainer), in order to be able to keep track of them more
  easily. The task contains links to list discussions related to it.
  To make it easier for a group of secretaries to collaborate, and for
  any interested party to see the progress of a discussion, whenever a
  secretary adds a task to the tracker, he replies to the list post
  that prompted him to do so, with a subject starting with
  "[TASK]" (ideally containing the task's summary line, too) and the URL
  of the task in the message body.

Advantages:

* Secretaries don't need to coordinate their activities much. As such,
  there can be dozens of secretaries without scalability issues, which
  would reduce the workload on each of them.
* People who report things don't have to involve themselves in a
  technical discussion that may be completely over their heads. For
  example, when Joe Randomuser reports that a certain command does weird
  things, he most likely won't want to hear anything about whether the
  current strategy for confabulating stochastic index entries in a
  distributed manner is error-free, nor does he benefit at all from
  getting all that technical stuff delivered to his mailbox.
* People who report things can have more confidence that their report
  doesn't get lost in The Noise(tm).
* Git developers don't have to deal with incomplete/nonsensical reports
  all if they are submitted to the tracker.
* Git developers can choose themselves how much they want to interact
  with the bug tracker.

Disadvantages:

* There is a certain level of redundancy in this approach. It's not
  clear to me whether that's a bad thing. I tend to think that it isn't.

III) THIS SECTION IS USELESS
----------------------------

Having section headings for just two sections looked stupid, so here is
another one.

If there are no general objections to the proposal, I will start using
the tracker for tracking less-than-all reports posted to this list.
Whether the tracker really takes off depends on everyone who reads
this... and I'm sure there are lots of great ideas that just didn't
occur to me that you guys can share here.

[1] http://thread.gmane.org/gmane.comp.version-control.git/108109
[2] http://thread.gmane.org/gmane.comp.version-control.git/110117
