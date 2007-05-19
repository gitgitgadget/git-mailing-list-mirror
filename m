From: Jeff King <peff@peff.net>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 07:52:45 -0400
Message-ID: <20070519115245.GA10035@coredump.intra.peff.net>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sat May 19 13:52:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpNUU-00059h-Mg
	for gcvg-git@gmane.org; Sat, 19 May 2007 13:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbXESLwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 07:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757560AbXESLwt
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 07:52:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3059 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756374AbXESLws (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 07:52:48 -0400
Received: (qmail 23116 invoked from network); 19 May 2007 11:52:49 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 19 May 2007 11:52:49 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 19 May 2007 07:52:45 -0400
Content-Disposition: inline
In-Reply-To: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47740>

On Sat, May 19, 2007 at 03:30:11AM -0700, Robin H. Johnson wrote:

> Problem:
> --------
> A bunch of my commits are NOT present in git-log, git-rev-list, or any
> tool that provides the history of my branches.
> 
> If I hack around and recover the commitid, I can pass it to git-show,
> and the commit does still exist in the data.
> 
> git-fsck --unreachable does not list the commit in question either, but
> does list other blobs and trees.

Are you sure it isn't in your reflog? Try 'git reflog show' or 'git log
-g'.

-Peff
