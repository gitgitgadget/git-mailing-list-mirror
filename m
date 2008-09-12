From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Fri, 12 Sep 2008 13:01:29 +0200
Message-ID: <20080912110129.GX10360@machine.or.cz>
References: <20080909231009.GD10544@machine.or.cz> <36ca99e90809100118m4c2c0904q5f3effb301b0d779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 13:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6QB-0005G7-8k
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 13:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbYILLBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 07:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbYILLBb
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 07:01:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35741 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbYILLBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 07:01:31 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7407C393A816; Fri, 12 Sep 2008 13:01:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <36ca99e90809100118m4c2c0904q5f3effb301b0d779@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95711>

  Hi,

On Wed, Sep 10, 2008 at 10:18:08AM +0200, Bert Wesarg wrote:
> On Wed, Sep 10, 2008 at 01:10, Petr Baudis <pasky@suse.cz> wrote:
> >  Hi!
> Hi,
> 
> Thanks for the release.  I have some notes:
> 
> 1. .gitignore is not up-to-date

  thanks, fixed.

> 2. tg tells me v0.2

  This works for me.

> What do I need to publish my TopGit controlled branches, is it enough
> to push with:
> 
> 	push = refs/heads/t/*:refs/heads/t/*
> 	push = refs/top-bases/t/*:refs/top-bases/t/*

  Yes, if you keep all of your TopGit-controlled branches in t/*.
Or just call 'tg remote' on the publishing remote and it will set up
this stuff for you.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
