From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 1/1] git-cvsexportcommit.perl: Fix usage() output.
Date: Tue, 15 Nov 2005 18:10:41 +1300
Message-ID: <46a038f90511142110x3aa22882j768f33ec1a882dab@mail.gmail.com>
References: <20051114164047.GB9131@raven.localdomain>
	 <20051114164505.GF9131@raven.localdomain>
	 <7vbr0mx4fj.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511141420u11e396d3q9a6710c79abe0ca3@mail.gmail.com>
	 <7vsltyvnjf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kevin Geiss <kevin@desertsol.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 06:11:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebt5g-0003mm-U8
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 06:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVKOFKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 00:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVKOFKm
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 00:10:42 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:61 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932383AbVKOFKl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 00:10:41 -0500
Received: by zproxy.gmail.com with SMTP id 40so1283493nzk
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 21:10:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NKq5TCy/S8PZIozeGuEhphISrQ+CPIk3ZM6xWZTU6mL+v8wStouYP8AmP+ZJnPCffTAGAtIS6tnbshVdQDLMj3halAVag+5h4w74gmwry4LVyuaDRHeT5dFZvCOGGADJKC4Mtj+Ob/d5SdvpmJJLvVf0d0VVlwVkbH4YzCYPS2s=
Received: by 10.64.193.9 with SMTP id q9mr3789249qbf;
        Mon, 14 Nov 2005 21:10:41 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Mon, 14 Nov 2005 21:10:41 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git list <git@vger.kernel.org>
In-Reply-To: <7vsltyvnjf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11876>

On 11/15/05, Junio C Hamano <junkio@cox.net> wrote:
> Given that you are far more familiar with that part of the code,
> and I suspect I'd be asking your help in archimport as well, a
> repo I can pull from would be more preferable (and sign-off by
> you is certainly an added bonus).  If a public repo is too much
> hassle, however, e-mail forwarding is perfectly fine as well.
> Your choice.

It is _easy_. I've setup a server for git-related paraphernalia at
work already ;)

The URL is:
  http://locke.catalyst.net.nz/git/git-martinlanghoff.git/#tojunio

gitweb at:
  http://locke.catalyst.net.nz/gitweb?p=git-martinlanghoff.git;a=summary

That gitweb has per-branch RSS feeds, if you are an rss junkio ;-) you
can just subscribe to it...

A word of warning, though: those branches rewind/rebase often, and I
won't apologise about it. You should be able to just delete your
'martinlanghoff' head and refetch it. Anyone else reading this... just
_don't_ base your work on my branch as it's bound to break.

> BTW, there is no "mana" points involved in deciding if I
> directly pull from somewhere.  Even if that were the case, you
> have accumulated enough of them already ;-).

:-)

/me is happy that you've forgotten about my brown-paper-bag patch with
a random character in the middle!

> Although some might find "${\function}" expansion too cute for
> their taste, Keven's code is fine as-is for me.  I launched the
> baloon just wanting to see what others have to say ;-).

Fine w me -- TIMTOWDI. I do understand, however, your interest in
having full paths in the usage line to make debugging easier. Whatever
is consistent with the project in general.

cheers,


martin
