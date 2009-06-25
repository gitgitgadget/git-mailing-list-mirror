From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: peeking into another repo
Date: Thu, 25 Jun 2009 02:11:05 -0700
Message-ID: <20090625091105.GB2901@dcvr.yhbt.net>
References: <20090613225334.GH5867@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 11:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJkzP-0000l1-3U
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 11:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbZFYJLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 05:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbZFYJLF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 05:11:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54181 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbZFYJLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 05:11:04 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 0DCFC1F44D;
	Thu, 25 Jun 2009 09:11:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090613225334.GH5867@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122187>

Yann Dirson <ydirson@altern.org> wrote:
> Hi Eric,
> 
> I have started to work on conversion of svn:externals into git
> submodules [1].

Cool.

> I need to access the revmap of the submodules git-svn repos, but at
> first glance I'm under the impression the Git::SVN class is not able
> to provide me that support.  Do you confirm this ?  What approach
> would you advise ?

Huh?  I don't see why not, all the rev_map_* and *_rev_map_* are
defined in Git::SVN.

One thing you need to be careful with when dealing with multiple SVN
repositories however is that the SVN::Ra class doesn't behave well with
multiple repositories (or even connections to different
directories/branches) in the same process.

> Best regards,
> -- 
> Yann
> 
> [1] http://repo.or.cz/w/git/ydirson.git?a=shortlog;h=refs/heads/t/svn-externals

Sorry it's taken taken so long to respond to these messages.  I've had
very limited Internet access the past few weeks and have been busy
with non-computer stuff.

-- 
Eric Wong
