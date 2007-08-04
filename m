From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 18:27:56 +0200
Message-ID: <857iobfenn.fsf@lola.goethe.zz>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<46B4A35E.5040601@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:28:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMTx-0000ms-S5
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762135AbXHDQ17 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760381AbXHDQ17
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:27:59 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:40729 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759289AbXHDQ16 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 12:27:58 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 61E8C3030B5;
	Sat,  4 Aug 2007 18:27:57 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 41599345BE8;
	Sat,  4 Aug 2007 18:27:57 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id E535C36E86E;
	Sat,  4 Aug 2007 18:27:56 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 556EE1C4F932; Sat,  4 Aug 2007 18:27:56 +0200 (CEST)
In-Reply-To: <46B4A35E.5040601@midwinter.com> (Steven Grimm's message of "Sun\, 05 Aug 2007 00\:03\:42 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54879>

Steven Grimm <koreth@midwinter.com> writes:

> David Kastrup wrote:
>> A system such as info, in contrast, is hierarchical, and organized
>> with indexes and cross references making it much easier to find
>> things.
>
> Really? I find info a huge pain in the butt most of the time.
> I can't just do a simple text search for the information I want in
> the relevant manpage; I have to go navigating around to the
> appropriate subsection (and that's assuming I know where it is)

You are presumably talking about the standalone reader.  I never use
it, so can't really say much about it.  With Emacs, you just do C-s
and search.  Hitting C-s again will extend the search to the section,
and then to the whole file.

> and am forced to use the emacs-style pager whether I like it or not
> (not a big emacs fan here). It always ticks me off when I go to read
> the manpage for some command and it tells me to go read the info
> page if I want complete documentation.
>
> I would definitely not want to move to a documentation system that
> prevented me from typing "man git-commit" to get a list of all the
> command line options for that command.

Nobody said that we would want to get rid of man pages.

Anyway, with the info reader, you should at worst use something like
info git
i git-commit RET
to get to the git-commit man page equivalent.

> However, that said, I have no objection to an alternate view of the
> same information that's organized differently.
>
> Am I alone in my dislike of info, I wonder?

I don't use the standalone info reader.  It is likely quite less
sophisticated and convenient than what Emacs does with info files.
The few times I have used it, I felt inconvenienced IIRC, though it
has supposedly been improved some time ago after being left in the
lurch for quite long.  But actually you can also use yelp to browse
info pages (point it at, say, info:coreutils).

So I would definitely agree with your assessment that _replacing_ the
man pages by info would not be the right way to go.  However, nobody
asked for that.  The idea was to use _Texinfo_, and this produces
plain text, HTML, info files, quite nice PDF and some other formats.
Of _course_, we want to have man pages as well.  I pointed out a
reference to the GCC project where they explain how they generate man
pages from Texinfo.  One would have to check whether this can be
applied to the git pages, of course.

There was also the question how to integrate documentation into
something like gitk, and there is a Tkinfo widget that could
conceivably be used.  Texinfo files can also be converted into flat
text files with basic markup (and man pages don't give you more than
that, anyway).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
