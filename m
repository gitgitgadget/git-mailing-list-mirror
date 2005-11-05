From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Sat, 5 Nov 2005 20:23:33 +0000
Message-ID: <b0943d9e0511051223g74c2be43h@mail.gmail.com>
References: <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
	 <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
	 <436787BD.9080705@citi.umich.edu>
	 <20051101153650.GB26847@watt.suse.com>
	 <b0943d9e0511010918ob2dbcfcv@mail.gmail.com>
	 <20051101181352.GD26847@watt.suse.com>
	 <b0943d9e0511011330v7045c568u@mail.gmail.com>
	 <20051102154108.GM26847@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chuck Lever <cel@citi.umich.edu>, Petr Baudis <pasky@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 21:24:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYUZd-0006jn-Mm
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 21:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVKEUXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 15:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVKEUXf
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 15:23:35 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:59991 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbVKEUXe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 15:23:34 -0500
Received: by xproxy.gmail.com with SMTP id i30so130020wxd
        for <git@vger.kernel.org>; Sat, 05 Nov 2005 12:23:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gaysjL5Fd/bbevllfzZVtE++y3eyHOvGjm1pzregtlBuSyvprJpri62kgFgkzLa85CpBUn4blref7hI3B3NBmgXgxZx6JwJo9p1jnU7h6ZlZKAPqnV5rtEk14Nj+EChf+VzYSewduagc9UIuWq5yu0opRrOHrSEuQ/ttzCHQ7D8=
Received: by 10.70.31.10 with SMTP id e10mr550686wxe;
        Sat, 05 Nov 2005 12:23:33 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Sat, 5 Nov 2005 12:23:33 -0800 (PST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <20051102154108.GM26847@watt.suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11183>

Sorry for the delay in replying.

On 02/11/05, Chris Mason <mason@suse.com> wrote:
> I think we're talking past each other a little, partially because
> I'm not sure exactly what features you want from revision control on the
> patches.

That's unclear for me too :-). I would like to have a way of checking
the changes to individual patches, just to be able to go back if some
changes broke it. It's also useful to have some kind of revision
control for the whole stack, but this can be achieved with tags at the
moment. What I usually do is export the series when I'm happy with it
and keep that directory safe. I could add revision control for the
directory containing the exported series but this would be somehow
outside StGIT.

> But, my suggestion is to remember that once you add some sort of
> revision control, people are going to want all of the features they are
> used to with git/hg/their favorite SCM.  You'll probably get better
> results if you patch git to your needs then if you try to reimplement
> things all over again.

That's true. I think that people who want a full revision control of
the patches should rather use separate branches instead of stacked
patches. It's indeed more convenient to be able to add or remove
features with push/pop but providing yet another SCM layer on top of
these would make the tool hard to understand (and maybe make Quilt
fans run away from it).

The current StGIT features are enough for my needs but I'll
accept/implement new features based on others' requirements.

BTW, the latest StGIT snapshot has support for a 'patches' command
which shows the patches modifying a file or set of files (that's
because I needed this feature recently).

--
Catalin
