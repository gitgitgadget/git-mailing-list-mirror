From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Fetch svn branches only and have git recognize them as
 branches?
Date: Thu, 12 Mar 2015 23:33:38 +0000
Message-ID: <20150312233338.GA16358@dcvr.yhbt.net>
References: <CAMMCKnc9AKjuwQ_RNxD_g3tn=xFQkbO1i-U=rP2VLWPi7qizGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Koehmstedt <bkoehmstedt@berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Mar 13 00:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWCbo-0003NO-MN
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 00:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbbCLXdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 19:33:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34362 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbbCLXdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 19:33:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CC21F5CD;
	Thu, 12 Mar 2015 23:33:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAMMCKnc9AKjuwQ_RNxD_g3tn=xFQkbO1i-U=rP2VLWPi7qizGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265383>

Brian Koehmstedt <bkoehmstedt@berkeley.edu> wrote:
> My latest failed attempt was this:
> 
> [svn-remote "svn"]
>         url = http://abc.com/repo/branches
>         fetch = :refs/remotes/svn/branches
>         branches = *:refs/remotes/svn/*
> 
> git svn fetch svn
> This fetched all the branch directories as one branch.

You probably do not need the "fetch" line there, only:

[svn-remote "svn"]
        url = http://abc.com/repo/branches
        branches = *:refs/remotes/svn/*

I haven't used the branches/tags functionality of git-svn in
many years, though.
