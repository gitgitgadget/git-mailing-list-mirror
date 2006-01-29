From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Sat, 28 Jan 2006 21:14:26 -0500
Message-ID: <118833cc0601281814i503bf934ge32b12e7b090c44@mail.gmail.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 03:14:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F325d-0007Pu-0q
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 03:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWA2COb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 21:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWA2COb
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 21:14:31 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:18212 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750811AbWA2COb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 21:14:31 -0500
Received: by pproxy.gmail.com with SMTP id o67so79057pye
        for <git@vger.kernel.org>; Sat, 28 Jan 2006 18:14:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S2q8peI+2HnbmIAgzUgT0ibtwjXbGeRh9DEfqpLzgNZ07G3fh3nbERJdj+kHtVi93rvOQBBDxgAfmWO/qYahbXRjRmuDNOxHxoGxhSzvEBTKI/ZyKULHo0UHNFdykh2h2dFf+QSVPCTqxyyt6z0heNFTvfzEVosMCXZwJ7R7zJQ=
Received: by 10.35.121.2 with SMTP id y2mr19499pym;
        Sat, 28 Jan 2006 18:14:26 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Sat, 28 Jan 2006 18:14:26 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15202>

> Can I hear experiences from other big projects that tried to use
> git [*1*]?  I suspect there are many that have tried, and I
> would not be surprised at all if git did not work out well for
> them.

I've been playing with Gnumeric under git.

-rw-rw-r--    1 welinder research     270M Nov  5 09:46
gnumeric/.git/objects/pack/pack-91291de5477ddd06545b052460239b3dae89ad72.pack

270M is about 40% of the cvs repository size.  Given
compression I would have expected bigger savings.

Conversion isn't perfect, probably because the cvs tree has
seen some hacking over the years.  (I am not posting the URL
because I don't want to kill gnome.org.)

We haven't switched yet, but I expect that we will.  We are
looking for (in no particular order):

1. Offline history.
2. Patch sets and other things that'll make it easier to maintain
    more than one branch.

In other words, pretty-much anything but cvs will fit the bill, :-./

M.
