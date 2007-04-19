From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 19:11:59 -0700
Message-ID: <7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
	<200704181426.29969.andyparkins@gmail.com>
	<462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>
	<4626C4B9.1040707@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 04:12:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeM7y-0000Gh-RH
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 04:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993106AbXDSCMD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 22:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993107AbXDSCMD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 22:12:03 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:33716 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993106AbXDSCMA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 22:12:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419021200.PUKH1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 22:12:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oqC01W0011kojtg0000000; Wed, 18 Apr 2007 22:12:00 -0400
In-Reply-To: <4626C4B9.1040707@midwinter.com> (Steven Grimm's message of "Wed,
	18 Apr 2007 18:24:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44975>

Steven Grimm <koreth@midwinter.com> writes:

> And in particular -- this being the original topic of the thread --
> when an svn user sees me doing that, they do not immediately think of
> the fact that merging between immutable revisions may have some
> benefits. They see me typing four commands (commit, fetch, rebase,
> reset) to do the same thing they can do in one command with svn, and
> conclude that git is harder to use.

No arguments there.  While I know I will never use such a
workflow myself, I think it makes sense to _allow_ local
changes to be merged to the new revision if the user chooses to
use such a workflow.

The necessary places to change are limited to the Porcelain-ish
layer, and adding '-m' option to "git pull", just like "git
checkout" has the corresponding option to allow merging local
changes, should not be a rocket science.  In fact, I vaguely
recall keeping a couple of patches to do so in 'pu' several
months ago, perhaps for a few weeks.

Maybe git has matured too much.  In earlier days, people
complained about lack of features and existence of misfeatures,
and bashed the maintainer with patches.  These days, the bashing
is done with more words and less patches.
