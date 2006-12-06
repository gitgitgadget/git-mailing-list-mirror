X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 6 Dec 2006 16:45:46 -0500
Message-ID: <20061206214546.GB25465@fieldses.org>
References: <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org> <45773002.5020409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 21:46:00 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45773002.5020409@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33525>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs4aQ-0004fL-2h for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937677AbWLFVpv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937678AbWLFVpv
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:45:51 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36798 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937677AbWLFVpu (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 16:45:50 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gs4aI-0007Ld-2x; Wed, 06 Dec 2006
 16:45:46 -0500
To: Graham Percival <gpermus@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, Dec 06, 2006 at 01:02:58PM -0800, Graham Percival wrote:
> I'm in the middle of exam period, I have a term papers to write, and I 
> have two weeks of lilypond bug reports and doc typos to process.  I 
> don't care if git can do branches really nicely or walk my dog or cure 
> cancer.  I can look at that stuff later -- right now I just want to fix 
> things and upload them.

Yeah.  It's a tricky problem; different people need different things,
and to cover everything (and explain it correctly) the documentation
needs to be long; but to ensure that impatient people can get to what
they need quickly, there needs to be a short, clear path to their
particular need.

A few down-to-earth approaches that could help:

	- Clearer section/chapter titles, so we can generate tables of
	  contents where people can quickly find stuff--so, titles that
	  explain what the section will show you how to do with
	  minimized use of jargon that the user doesn't know yet ("how
	  to keep a repository up-to-date" as opposed to "git-fetch and
	  remotes").

	- As in "Everyday Git", think about what different groups of
	  users need.  But where possible, try to order documentation
	  with the stuff needed by the largest group of people first.
	  (For example, right now all the tutorials start with "git
	  init-db" and "git commit", assuming people are starting a
	  project from scratch, when the more typical usage is probably
	  someone joining an existing project, and possibly doing only
	  read-only stuff at first.)

	- Clearer ordering and dependencies, so when people find the "how
	  to resolve merges" section, they can quickly see what else
	  they'd need to read before that.  (And, yeah, I realize 99% of
	  the time they won't actually do that--they'll just dive right
	  in and try a few examples.  But at least they'll know where to
	  turn if that gets them in trouble....)

