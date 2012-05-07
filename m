From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn dcommit <branch> committed to trunk anyway
Date: Mon, 7 May 2012 11:44:39 +0200
Message-ID: <87txzsba0o.fsf@thomas.inf.ethz.ch>
References: <CAH3AnroP+ckzgijibPDEupBCfUFu5Bwsq8YP58h+igXoJyJEyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 11:44:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKUr-0001Q1-5g
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab2EGJop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 05:44:45 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:21211 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab2EGJoo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 05:44:44 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Mon, 7 May
 2012 11:44:43 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.209.244) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 7 May
 2012 11:44:42 +0200
In-Reply-To: <CAH3AnroP+ckzgijibPDEupBCfUFu5Bwsq8YP58h+igXoJyJEyg@mail.gmail.com>
	(Jon Seymour's message of "Sun, 6 May 2012 18:30:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.209.244]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197250>

Jon Seymour <jon.seymour@gmail.com> writes:

> I expected git svn dcommit <branch> to push commits into the svn
> branch called <branch> (a repo relative URL of
> /branches/foobar1/foobar2/<branch>)
>
> However, it decided to push into trunk instead, which was not the
> intended effect.
>
> What have I misunderstood about how git svn dcommit is supposed to work?

Did the commits you dcommitted have any git-svn-id lines?  It dcommits
(or at least it's supposed to :-) in the directory listed in the
git-svn-id line found by (roughly)

  git log --first-parent -1 --grep=^git-svn-id:

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
