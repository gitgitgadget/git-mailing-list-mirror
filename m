From: Andreas Krey <a.krey@gmx.de>
Subject: egit vs. git behaviour (was: [RFC/WIP] Pluggable reference backends)
Date: Wed, 12 Mar 2014 11:26:01 +0100
Message-ID: <20140312102601.GA26257@inner.h.apk.li>
References: <531D9B50.5030404@alum.mit.edu> <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com> <20140310155230.GA29801@sigill.intra.peff.net> <531E2986.8050604@alum.mit.edu> <CAJo=hJt6zoJ=53JNUT6fLXM+5_4Af8enE67z3Ozv4DOz1jU1Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 11:39:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNgZS-0007ul-AF
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 11:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbaCLKja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 06:39:30 -0400
Received: from continuum.iocl.org ([217.140.74.2]:52347 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbaCLKj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 06:39:29 -0400
X-Greylist: delayed 803 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Mar 2014 06:39:28 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s2CAQ1q26945;
	Wed, 12 Mar 2014 11:26:01 +0100
Content-Disposition: inline
In-Reply-To: <CAJo=hJt6zoJ=53JNUT6fLXM+5_4Af8enE67z3Ozv4DOz1jU1Eg@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243930>

On Mon, 10 Mar 2014 19:39:00 +0000, Shawn Pearce wrote:
> Yes, this was my real concern. Eclipse users using EGit expect EGit to
> be compatible with git-core at the filesystem level so they can do
> something in EGit then switch to a shell and bang out a command, or
> run a script provided by their project or co-worker.

A question: Where to ask/report problems with that?

We're currently running into problems that egit doesn't push to where
git would when the local and remote branches aren't the same name. It
seems that egit ignores the branch.*.merge settings. Or push.default?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
