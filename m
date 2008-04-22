From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Welcome to Git's GSoC 2008!
Date: Mon, 21 Apr 2008 21:32:01 -0400
Message-ID: <20080422013201.GA4828@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	David Symonds <dsymonds@gmail.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	Marek Zawirski <Marek.Zawirski@gmail.com>,
	Miklos Vajna <vmiklos@frugalware
X-From: git-owner@vger.kernel.org Tue Apr 22 03:33:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo7Nj-0007VK-8C
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 03:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761876AbYDVBc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 21:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbYDVBc0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 21:32:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52968 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbYDVBcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 21:32:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jo7MO-00041A-JM; Mon, 21 Apr 2008 21:31:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C59E20FBAE; Mon, 21 Apr 2008 21:32:02 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80050>

Congratulations, and welcome to the Git community!

By now I hope you are aware that your project proposal has been
selected by the Git community, and will be funded thanks to the
extremely generous folks at Google.

This year Git was fortunate enough to receive funding for 6 students,
and we are looking forward to the successful completion of the
following interesting projects:

  GitTorrent
      Student: Joshua Roys
      Mentor:  Sam Vilain

      Josh and Sam will be working to implement native git object
      transport via a peer-to-peer system, potentially allowing
      popular projects such as the linux kernel to be available
      via more servers than just git.kernel.org.

  git-statistics
      Student: Sverre Rabbelier
      Mentor:  David Symonds

      Sverre and David are looking to mine the commit history of
      a project and identify "good" changes from "bad" changes.
      Such information may help maintainers to better judge the
      risk associated with new changes, and help new contributers
      to more quickly locate individuals who are experienced in
      a particular section of code (e.g. automatically identify
      module maintainers).
    
  Gitweb caching
      Student: Lea Wiemann
      Mentor:  John 'warthog' Hawley

      Lea and John will be working to port the caching gitweb fork
      that runs on kernel.org back into the main tree, as well as
      implementing even more improved caching for really large sites
      like kernel.org, repo.or.cz, or anyone else using gitweb for
      a large number of repositories and users.
    
  Eclipse plugin push support
      Student: Marek Zawirski
      Mentor:  Shawn O. Pearce

      Marek and myself will be working to implement pack generation
      in jgit, allowing the 100% native Java implementation of Git
      to create pack files locally, as well as upload pack files to
      a remote repository over the native Git transport.  Marek is
      also looking forward to improving some of the user interface
      aspects of the Eclipse Git team provider plugin.
    
  git-merge builtin
      Student: Miklos Vajna
      Mentor:  Johannes Schindelin

      Miklos and Dscho will be porting the git-merge shell script
      to C, permitting it to make use of builtin functions like
      merge base computation, and making the program overall more
      portable to non-POSIX systems.  Porting some of the popular
      merge strategies (e.g. git-merge-ours) will also be done as
      time permits.
    
  git-sequencer
      Student: Stephan Beyer
      Mentor:  Christian Couder, Daniel Barkalow

      Stephan, Christian and Daniel will be working to port the
      current "git rebase --interactive" to C, as well as create
      a general "commit sequencer" that can be used as the backing
      implementation for "git-am", all three forms of "git-rebase",
      and possibly implement an "interactive rebase GUI" within
      git-gui and/or gitk.


Student projects will be worked on roughly full time (~40 hours/week)
between May 26th and August 18th.

Right now you should spend some time talking to your mentor(s),
so you can both get to know each other better.  Here's a rough
idea of some of the things you should be trying to work on with
your mentor over the next several weeks:

 - Get a copy of Git installed, and become familiar enough with
   it that you can make changes and commit them.

 - Clone the project you will be working to improve.

   - Can you compile it?
   - Can you run your compiled version?
   - Can you make a silly modification (make it say "hello world!")
     and see that modification when you test it?

 - Discuss where you will be publishing your work.  Publish the
   base (unmodified) code to make sure you can publish your own
   work later.

   I highly recommend creating a repository on repo.or.cz.  It is
   free, and for many of you the upstream project (git.git or
   egit.git) is already hosted there, so you just create a fork
   from it.

 - Start dicussing with your mentor your timeline and goals.

   Yes, you covered this in your proposal.  But now that its actually
   something you will be working on this summer it will really help
   both you and your mentor if you can work out a more detailed
   plan of the tasks ahead of you.

 - Discuss your personal schedule(s) with your mentor(s)/student(s).

   Will you be planning to be offline for any period of time?
   Taking a summer vacation/holiday for a week?  Now would be a
   good time to share this information, so everyone knows what to
   expect this summer.

 - Consider reviewing the GPL if you have not read it.

   Nearly all Git related code is covered by the GNU Public License.
   Individual authors (that's you) retain the copyright on works
   they create.  (egit/jgit is a special case, I'll take it up with
   Marek on another thread.)

 - Ask you mentor to introduce you around.

   You and your mentor are not working in a vacuum.  Hundreds of
   people have contributed to Git over the years and there is
   a wealth of knowledge in the community that you can leverage
   to your benefit.  Work with your mentor to develop additional
   contacts with other contributors who are knowledgable in the
   area of your project.  Don't hesistate to ask these folks for
   help when you get stuck, especially if your mentor is unable to
   answer you immediately.

We realize you are still taking classes, and have project deadlines,
homework and exams to still worry about.  But now that you are
accepted into GSoC its also time to start setting aside a few
hours a week to plan out your summer, so you can make the most of
this opportunity.

We are excited to have you join us, and are really looking forward
to these projects!

Final note: I am your friendly organization administrator.  If you
have any questions that your mentor can't answer, etc., please
email me.  I'm here to help both the student and the mentor make
the most of this summer.

-- 
Shawn.
