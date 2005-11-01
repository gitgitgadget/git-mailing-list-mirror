From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 17:18:49 +0000
Message-ID: <b0943d9e0511010918ob2dbcfcv@mail.gmail.com>
References: <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <20051031213616.GO11488@ca-server1.us.oracle.com>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
	 <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
	 <436787BD.9080705@citi.umich.edu>
	 <20051101153650.GB26847@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chuck Lever <cel@citi.umich.edu>, Petr Baudis <pasky@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 18:21:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWzmg-0008R0-NC
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 18:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVKARSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 12:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVKARSu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 12:18:50 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:36408 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750972AbVKARSt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 12:18:49 -0500
Received: by xproxy.gmail.com with SMTP id i30so1365293wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 09:18:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MDmKhoWc+QAG/uX4HnNybhU/YDRUfLJ1JaZw3R6EjoFDoWeaCGl90Vz5TNJiIkipMP/jLqz1m3jpum22zBd9eBEkU4plYFcPeYmmP9UAmujkZ+WZTTCE/PwjY95EywQLARZxV/FVxdzLUW0kQgzhXr/ymAojR3W9/qIcXLJVpvY=
Received: by 10.70.72.15 with SMTP id u15mr2648516wxa;
        Tue, 01 Nov 2005 09:18:49 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Tue, 1 Nov 2005 09:18:49 -0800 (PST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <20051101153650.GB26847@watt.suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10941>

On 01/11/05, Chris Mason <mason@suse.com> wrote:
> On Tue, Nov 01, 2005 at 10:20:29AM -0500, Chuck Lever wrote:
> [ ... ]
> > would show pretty-printed commit information for change 45.
> >
> >    stg revisions --revert=45
> >
> > would revert the patch back to the way it was in change 45.  notably,
> > you don't throw away changes 46 through 90 when you do this.  a new
> > change is added which changes the state of the patch to the way it was
> > in change 45.  (well, that's how it's supposed to work, anyway).
> >
> > i'm interested to hear what folks on the list think of the idea.
>
> I'm probably not familiar enough with stgit, but it
> looks to me as though you're tracking individual patch history only.

That's true, but you can use a 'git tag' command to mark the whole
stack as something useful and this would include the state of all the
patches on the stack. This would be a whole stack history, not
individual patch history. Maybe we should implement this as well (or
maybe only this).

Anyway, I wasn't sure that's the right implementation and that's why I
didn't include Chuck's patch yet.

--
Catalin
