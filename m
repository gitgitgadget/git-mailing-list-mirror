From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn added files to my commit?!
Date: Fri, 11 Aug 2006 11:18:17 -0700
Message-ID: <20060811181816.GC3152@localdomain>
References: <m2vep7yqzh.fsf@gmail.com> <20060805211337.GA31264@hand.yhbt.net> <m2fygazbdc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 11 20:18:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBbaW-0003p2-29
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 20:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWHKSSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWHKSSV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 14:18:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58501 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932399AbWHKSSU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 14:18:20 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 353A57DC025;
	Fri, 11 Aug 2006 11:18:17 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 11 Aug 2006 11:18:17 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m2fygazbdc.fsf@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25236>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > Looks like a bug, might as well cc the ml as it's a public repo.  I had
> > issues accessing it with the SVN:: libraries, though (probably a
> > permissions handling issue with git-svn) and had to use the
> > command-line.
> 
> The repos is public, but you need --username=readonly
> --password=readonly.

I've fixed one bug wrt to having limited permissions to a repository
when using the SVN:: libraries, but I can't seem to $ra->get_log() to
play nicely with limited read permissions.  Interesting, I'll be playing
with this sometime this weekend if I can maintain a stable internet
connection.

-- 
Eric Wong
