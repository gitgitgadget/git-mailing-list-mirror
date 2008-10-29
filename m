From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Wed, 29 Oct 2008 16:12:51 -0700
Message-ID: <20081029231251.GB31926@spearce.org>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Oct 30 00:14:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvKEo-0007uB-Lm
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbYJ2XMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbYJ2XMw
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:12:52 -0400
Received: from george.spearce.org ([209.20.77.23]:47606 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbYJ2XMw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:12:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 73A413835F; Wed, 29 Oct 2008 23:12:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99434>

Sverre Rabbelier <alturin@gmail.com> wrote:
> Please use a subtree merge to put this in contrib/gitstats.

Yea, about that...
 
> Sverre Rabbelier (237):
>       Created a script to setup a repo to test metrics on.
>       Converted the setupRepo script to python to allow creating the same repo.
>       Added the use cases in text form.
>       Added a README.
>       Initial commit for notes branch
>       Changelog for 28-05-2008
>       Changelog for 29-05-2008
>       Changelog for 30-05-2008
>       Changelog for 31-05-2008
...

How is this going to look in the "What's in git.git" email?
We don't use ChangeLog files in git.git and we don't have
notes branches, and we already have a README.

Most stuff in contrib/ has its commit messages with a prefix string
to make it more clear when looking at the shortlog what is being
impacted.  Maybe this should be re-written with filter-branch to
include a prefix before it merges.

-- 
Shawn.
