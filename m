From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH 0/7] guilt patches, including git 1.8 support
Date: Sun, 20 Jan 2013 16:24:25 -0500
Message-ID: <20130120212425.GA101005@meili.valhalla.31bits.net>
References: <20130116022606.GI12524@google.com>
 <50FC5F6B.6070103@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:25:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx2O5-0000AE-Eu
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 22:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab3ATVYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 16:24:43 -0500
Received: from josefsipek.net ([64.9.206.49]:1682 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab3ATVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 16:24:30 -0500
Received: from meili.valhalla.31bits.net (c-68-40-59-75.hsd1.mi.comcast.net [68.40.59.75])
	by josefsipek.net (Postfix) with ESMTPSA id 0C9FD11840;
	Sun, 20 Jan 2013 16:24:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50FC5F6B.6070103@opera.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214052>

On Sun, Jan 20, 2013 at 10:19:39PM +0100, Per Cederqvist wrote:
> On 01/16/13 03:26, Jonathan Nieder wrote:
> >Hi Jeff and other guilty parties,
> >
> >I collected all the guilt patches I could find on-list and added one
> >of my own.  Completely untested, except for running the regression
> >tests.  These are also available via git protocol from
> >
> >   git://repo.or.cz/guilt/mob.git mob
> >
> >Thoughts?
> 
> Regarding the "Change git branch when patches are applied" feature,
> it has saved me a number of times since I implemented it. I've been
> using it extensively, and have not had any problems with it.
> 
> Nevertheless, for backwards compatibility with the currently
> released guilt version I think it should be conditional, and
> disabled per default for one full release cycle.  I've implemented
> this. My code is available from git://repo.or.cz/guilt/ceder.git
> 
> The following commits are not included in your list:
> 
> a194375 Added guilt.reusebranch configuration option.
> 1dd97bd Minor testsuite fix.
> 640caee The tests should not fail if guilt.diffstat is set.

At $WORK, we started doing thorough reviews before committing.  I'm kinda
sold on this feature.  I agree with the off-by-default config flag.

> I don't want Guilt to fork. Jeff, it would be really great if
> you could set up a public repo again!

Yep.  I'm trying to reclaim control of the repo.or.cz guilt repo... I no
longer have access to jsipek@cs.sunysb.edu and I don't remember the
password.

Jeff.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
