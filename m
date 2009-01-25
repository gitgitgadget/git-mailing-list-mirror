From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 10:44:25 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0901251916010.14855@racer>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1543968957-1232909065=:12651"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 19:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR9ze-0002hn-1z
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbZAYSoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbZAYSoh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:44:37 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:36213 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbZAYSoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:44:37 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0PIiPdH014366;
	Sun, 25 Jan 2009 10:44:25 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0PIiPPl014363;
	Sun, 25 Jan 2009 10:44:25 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0901251916010.14855@racer>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107077>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1543968957-1232909065=:12651
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT

On Sun, 25 Jan 2009, Johannes Schindelin wrote:

> That would break existing scripts using "git diff" rather badly.  We already 
> did not allow something like "git config alias.diff ..." from changing the 
> behavior of "git diff", so I cannot find a reason why we should let 
> diff.primer (a misnomer BTW) override the behavior.

I took special care to protect all core scripts from the effects.  Quote from 
patch 1/3:
> Protect git-format-patch, git-apply,
> git-am, git-rebase, git-gui and gitk
> from inapplicable options.

I fact, by introducing the cpp macro DIFF_MACHINE_FRIENDLY() and the 
command-line options "--machine-friendly" and "--no-primer", I made such 
protection declarative.  Don't you find it preferable that existing programs and 
scripts would explicitly declare their desire for machine-friendly output?

The name "primer" is open to discussion, of course.  But I like it.
From Merriam-Webster:
primer n 1: a device for priming 2: material used in priming a surface
prime vb 1: fill, load 2: to prepare for firing 3: to apply the first color, coating or preparation to <~ a wall>

Thanks for your input.  More input welcome.
                                    -- Keith
---559023410-1543968957-1232909065=:12651--
