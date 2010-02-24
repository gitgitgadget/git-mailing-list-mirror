From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git as an sfc member project
Date: Wed, 24 Feb 2010 08:22:05 -0800
Message-ID: <20100224162205.GA20340@spearce.org>
References: <20100224154452.GA25872@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 17:22:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkK0A-0004dx-VJ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 17:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab0BXQWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 11:22:12 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58772 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab0BXQWL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 11:22:11 -0500
Received: by gwj16 with SMTP id 16so1191996gwj.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 08:22:10 -0800 (PST)
Received: by 10.150.248.24 with SMTP id v24mr333821ybh.148.1267028529641;
        Wed, 24 Feb 2010 08:22:09 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm794737yxg.28.2010.02.24.08.22.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 08:22:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100224154452.GA25872@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140951>

Thanks for getting this started!

Jeff King <peff@peff.net> wrote:
> >    * Detailed description of the project.
> 
> Git is a free & open source, distributed version control system
> designed to handle everything from small to very large projects with
> speed and efficiency.
> 
> Every Git clone is a full-fledged repository with complete history and
> full revision tracking capabilities, not dependent on network access or
> a central server. Branching and merging are fast and easy to do.
> 
> Projects using git include the Linux kernel, X.org, Perl, Gnome, Ruby on
> Rails, Wine, and more.

<plug type="shameless" for="$DAY_JOB">
You could also mention the Android Open Source Project.  Every one  
of those Android handsets on the market... the VCS used by the
team that engineered those is Git, preciously because it allows
the handset builder to manage their changes.

We wouldn't have 8+ devices on the market without Git.

:-)
</plug>
 
> >    * FLOSS License(s) used by the project
> 
> Core git is licensed under GPLv2. JGit, a pure-Java implementation of
> git, is licensed under the Eclipse Distribution License.

Slightly reworded:

  The core git code is licensed under GPLv2.

  The JGit code, a pure-Java implementation of git, is licensed under
  the Eclipse Distribution License, which is a new-style BSD license.


> >    * Roadmap for future development.
> 
> Git is currently a stable, widely-used version control system. We
> continue to accept enhancements and bug fixes, with a new major release
> about every 18 months, minor releases every 2-3 months, and bugfix
> releases every few weeks. The development remains highly distributed,
> with 281 individual contributors during the past year.

I'm not sure this really answers their question.  I think we
should make it clear WTF is going on with Git and its "roadmap".
How about this instead?

  Git is a stable, widely-used version control system.  The majority
  of the key functionality is already implemented.  Consequently the
  project does not maintain a formal roadmap, but instead accepts
  a wide range of relevant enhancements and fixes directly from
  the user community.

  Based on prior history, major new releases occur about every 18
  months, minor releases about every 2-3 months, and maintenance
  releases every few weeks.  Development is highly distributed,
  with over 280 individual contributors during the past 12 months,
  and over 730 contributors since the project's inception.


> >    * link to the website.
> 
> http://git-scm.org

http://www.eclipse.org/jgit/
 

> >    * Link to the code repository.
> 
> http://git.kernel.org/?p=git/git.git

http://repo.or.cz/w/jgit.git


> >    * Brief history of the project, including past governance decisions.
> 
> [JGit?]

JGit was started in 2006 by Shawn Pearce to provide an efficient,
portable implementation of Git for Java based applications.  The
project moved to the Eclipse Foundation in late 2009, but remains a
standalone component and is widely embedded in non-Eclipse software.

 
> >    * Existing for-profit or non-profit affiliations, funding
> >      relationships, or other agreements that the project or its leaders
> >      have with other organizations.
> 
> Git has participated in the Google Summer of Code.
> 
> [Eclipse affiliations for JGit?]

JGit is hosted by the Eclipse Foundation, and is run in accordance
with the foundation's development processes.

 
> >    * Names, email addresses, and affiliations of key developers, past and
> >      present.
...
> Shawn O. Pearce <spearce@spearce.org>

Well, if you want to list current affiliations for me, I guess I can
now claim:

 * Google employee
 * Eclipse Foundation project committer
 * Apache Software Foundation project committer

Also, JGit has Robin Rosenberg <robin.rosenberg@dewire.com> as
a key developer.  If you are listing JGit on the application,
I think he deserves the credit too.
 
-- 
Shawn.
