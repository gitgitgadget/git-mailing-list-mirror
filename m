From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: How to compare different files in different branches
Date: Fri, 6 Jun 2008 15:35:39 +0300
Message-ID: <20080606123539.GA3119@mithlond.arda.local>
References: <20080606122421.GA1521@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080606@schottelius.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:36:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bBM-0003wg-0n
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbYFFMfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYFFMfm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:35:42 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:49483 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750776AbYFFMfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:35:42 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F006D27CE; Fri, 6 Jun 2008 15:35:40 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4bAR-0000on-75; Fri, 06 Jun 2008 15:35:39 +0300
Content-Disposition: inline
In-Reply-To: <20080606122421.GA1521@denkbrett.schottelius.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84059>

Nico -telmich- Schottelius wrote (2008-06-06 14:24 +0200):

> I want to compare 'configure.in' from the master branch with
> 'configure.ac' from the gpm-2-dev branch.

You could do:

  $ git diff master:configure.in gpm-2-dev:configure.ac

In general form it means:

  $ git diff <commit1>:<path1> <commit2>:<path2>

You can also view directories and files similar way:

  $ git show <commit>:<path>


And <commit> can be anything that refers to a commit, e.g. a branch
name, a tag, SHA1 or a relative pointer like master^2~5.
