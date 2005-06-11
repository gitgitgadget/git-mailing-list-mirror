From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 18:48:14 +1000
Message-ID: <2cfc4032050611014878d54c71@mail.gmail.com>
References: <E1DgodI-0003ov-Fl@highlab.com>
	 <7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	 <E1DgyW0-0004PE-Ct@highlab.com>
	 <2cfc403205061023346c03a25b@mail.gmail.com>
	 <7vpsutz88z.fsf@assigned-by-dhcp.cox.net>
	 <2cfc403205061100204cd43334@mail.gmail.com>
	 <7vu0k5xrfz.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 10:44:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh1bA-0004t1-9B
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 10:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFKIs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFKIs1
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 04:48:27 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:58591 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261226AbVFKIsO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 04:48:14 -0400
Received: by rproxy.gmail.com with SMTP id i8so419731rne
        for <git@vger.kernel.org>; Sat, 11 Jun 2005 01:48:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KQ9uSYeSfJXxVgJXWq1OwOz8vYZofkwPvCBveVbC+eoaE1b+gXdFcFJB87f2Rpzl60NSM8j++jNOD9AOlZ0JG6in0wJfH3/GU+L8QSiZohKCmHMHA3CHfHOl8d2zNsObVYTuCuUn7Ulc8kjzgFOMPcCOeMYHo4D4K4mw/uh9/S4=
Received: by 10.38.101.3 with SMTP id y3mr66242rnb;
        Sat, 11 Jun 2005 01:48:14 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 11 Jun 2005 01:48:14 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0k5xrfz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I grant you that what the current "git" wrapper offers is not
> Porcelain enough, and to perform anything meaningful you either
> need to use Porcelain or bare Plumbing commands yourself.  But
> when that day comes, "git update-cache" is not something you
> would want to have anyway.  You would rather want to have things
> like "git add" and "git remove", which are written in terms of
> git-update-cache.
> 
> See what I am saying?

Ok, that's fair enough. It is a sound to expose bits of plumbing to
the porcelain in a very slow and deliberate way as the porcelain is
polished, rather than automatically surfacing plumbing as it gets
created by over-enthusiastic plumbers.

My own learning experience has been exactly the other way around to
the intended use of the git script - I have been learning to use the
core git commands, writing my own wrappers where that is convenient
and adopting those of others only when I completely understand what
they are doing - I have been learning it inside out, I guess.

For example, I only recently discovered what git-commit-script does  [
and I like it - btw - nice behaviour ]!

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
