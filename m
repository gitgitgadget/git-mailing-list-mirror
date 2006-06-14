From: Eric Wong <normalperson@yhbt.net>
Subject: Re: oprofile on svn import
Date: Tue, 13 Jun 2006 19:01:08 -0700
Message-ID: <20060614020108.GB12083@hand.yhbt.net>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 04:01:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqKh0-0004TG-GF
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 04:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWFNCBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 22:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWFNCBK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 22:01:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37065 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964882AbWFNCBJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 22:01:09 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 79CA87DC005; Tue, 13 Jun 2006 19:01:08 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21821>

Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm going back to cvsimport tomorrow. My svn import that had been
> running for five days got killed this morning when the city decided to
> move the telephone pole that provides my electricty.
> 
> Some oprofile data, this doesn't make a lot of sense to me. Why is it
> in libcypto so much?

The sha1 calculation is done in libcrypto, afaik.

Anybody want to see how my latest patches to git-svn (and using SVN perl
libraries) stacks up against the mozilla repo?  Speedwise, I don't
expect git-svn to be too different than git-svnimport, but it should use
much less memory (I'll probably port the hacks to git-svnimport, too).

I'll see about freeing up one of my machines to test the mozilla repo.
Unfortunately, all of my hardware is a few years old and not extremely
fast.

-- 
Eric Wong
