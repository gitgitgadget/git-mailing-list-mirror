From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 21:30:30 +0200
Message-ID: <200610212130.31414.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <20061021181149.GM75501@over-yonder.net> <20061021191949.GA8096@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 21:30:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMY6-0005Kx-8k
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 21:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbWJUTaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 15:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422843AbWJUTaX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 15:30:23 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:32609 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422839AbWJUTaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 15:30:22 -0400
Received: by hu-out-0506.google.com with SMTP id 28so615570hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 12:30:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MTKL+ddqj6OA5iTtj+bRExIhNk3rvCVGXa9zc57ydKq9aUlomEHASZealcOkOLPAVnFG5zbn2+hZwV6FTfEaotJM2bSrZHH9n8ojF4eIJ2gCKGQRwOADORwlu+n7I7XTazKg8E0hbaBv5033yzJOb+BJ+KHSKHuV+A6mLtuwXS8=
Received: by 10.67.121.15 with SMTP id y15mr4274384ugm;
        Sat, 21 Oct 2006 12:30:20 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 50sm116599ugb.2006.10.21.12.30.19;
        Sat, 21 Oct 2006 12:30:20 -0700 (PDT)
To: Jeff King <peff@peff.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061021191949.GA8096@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29664>

Jeff King wrote:

> The difference, I think, is that it's easier in git to move the upstream
> around: you simply start fetching from a different place. I'm not clear
> on how that works in bzr (if it invalidates revnos or has other side
> effects).

That's good example of fully distributed approach. I can fetch directly
(actually, I cannot) from Junio private repository, I can fetch from
public git.git repository, either using git:// or http:// protocol,
I can fetch from somebody else clone of git repository: intermixing
those fetches, and revids (commit-ids) remain constant and unchanged.
-- 
Jakub Narebski
Poland
