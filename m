From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: EGIT: problems using eclipse project below root of working tree
Date: Thu, 30 Apr 2009 02:17:50 +0200
Message-ID: <200904300217.50469.robin.rosenberg.lists@dewire.com>
References: <3ae83b000904291128j27ad6c1ah3422f091c956533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 02:18:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJyV-0003iw-6m
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 02:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbZD3ARz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 20:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754349AbZD3ARy
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 20:17:54 -0400
Received: from mail.dewire.com ([83.140.172.130]:12718 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197AbZD3ARy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 20:17:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2C7B51023426;
	Thu, 30 Apr 2009 02:17:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5fyWVPKhKvR; Thu, 30 Apr 2009 02:17:52 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 4D1EB10233FE;
	Thu, 30 Apr 2009 02:17:52 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <3ae83b000904291128j27ad6c1ah3422f091c956533@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117983>

onsdag 29 april 2009 20:28:22 skrev John Bito <jwbito@gmail.com>:
> My Java project is part of a larger repository, so the Eclipse project
> I'm opening is rooted one level below the directory containing .git/.
> 
> When I open only the subproject (the root project shows as closed in
> the project explorer), all the members of the working directory of the
> subproject show in the Project Explorer as if they were untracked
> files (query icon).  If I open the subproject after opening the root
> project, the members correctly appear as committed (can icon).
> Opening the root project after opening the subproject seems to produce
> an error in references to jars in the subproject - not obviously
> related to EGIT.
> 
> If the root project is open, changes made in the subproject are listed
> twice in the Commit dialog (once prefixed by root-project-name: and
> once prefixed by subproject-name:).  If the root project is closed,
> the Commit dialog lists the changes once (prefixed by
> subproject-name).
> 
> I think the commit dialog gives me the correct status, but I'd have
> more confidence if the icons in the Project Explorer were consistent.
> I don't want to work with the root project open because it's MUCH
> bigger than the Java code I'm working on and Eclipse seems faster with
> only the subproject open.  I'm also concerned that if I let it commit
> with both the root and subproject instances of the changes checked,
> I'll cause a problem that'll take some time to unwind (not interested
> in experimenting with that at the moment).
> 
> Should I add this as a bug?

We had such a bug, fixed in february, I think, but we now have projects at 
this and and other levels. If you are talking 1) nested repos or 2) nested projects, 
then 1) Egit doesn't work well with them and 2) Eclipse doesn't work well with them.

We have been fiddling around recently with bugs relating to what happends in the repo
after fetch. Those would result in lost decorations. If you have an "exact" receipe for
reproducing the failure, a bug report helps. Otherwise we know there is some work
to do related to nested repos and odd setups in general.

-- robin
