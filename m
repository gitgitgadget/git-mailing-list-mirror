From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 19:49:36 +0200
Message-ID: <85myx7dwb3.fsf@lola.goethe.zz>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNl2-0005Bt-KT
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764883AbXHDRtl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764844AbXHDRtl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:49:41 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:33008 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755204AbXHDRtk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 13:49:40 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 1DDD0303048;
	Sat,  4 Aug 2007 19:49:39 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id EAA2A2C6B6E;
	Sat,  4 Aug 2007 19:49:38 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 8B62E1C72F8;
	Sat,  4 Aug 2007 19:49:38 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id F3C971C4F932; Sat,  4 Aug 2007 19:49:36 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 4 Aug 2007 09\:59\:08 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54888>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 4 Aug 2007, David Kastrup wrote:
>> 
>> A system such as info, in contrast, is hierarchical, and organized
>> with indexes and cross references making it much easier to find
>> things.
>
> You must be kidding. Texinfo is the worst documentation format EVER.

Oh come on.  It was the first hyperlinked and hierarchical format
before HTML even existed.  Its age shows, but the replacements have
not managed to produce anything more useful.  There have been
discussions about replacing the _info_ format with an HTML or XHTML
subset, however, that conveys the same amount of hierarchical
information.

> And the readers universally suck too, unless you're a total GNU
> emacs fan and have been for a decade, and have problems
> understanding people who don't like the all-in-one mentality.

Actually, a decade ago the Emacs-internal info reader was worse than
it is now.

Any, after you have in your usual amicable manner declared anybody
insane that would not use the same tools as you, let us come back to
the plain facts again.

> There are absolutely _zero_ advantages in Texinfo over AsciiDoc.

There are, of course, advantages to Texinfo.  Any system that is not
completely braindead has some unique advantages, and not everything
not designed by you is braindead.

One advantage to Texinfo is that it is _structured_: whether or not
you like the available info readers, there is the information "up",
"next", "previous" in every node, and every node has a hyperlinkable
name which you can use for referring to it.  And the info readers are
aware of that, and you can navigate using single keystrokes.

Now it may well be possible to put the same information into AsciiDoc
files, but there are no _readers_, bad or not, that would make use of
it.

I can specify something like

(info "(gcc) Extended Asm")

and when you are reading mail in Emacs, you can click on that line and
get to the respective page in a manual comprising hundreds of pages.
You can, of course, also type
info "(gcc) Extended Asm"
into your command line and use the standalone info reader to get
immediately to that line.

You can also get there by typing

info gcc
i assem <TAB>
and picking the right of three choices from the index.  The standalone
reader may not be pretty, but it does the job of accessing those
informations, and you can with single keypresses go up and forward in
a hierarchically organized, _structured_ manual of hundreds of pages.

And as opposed to AsciiDoc, there _are_ readers that make use of this
information.

> It has all the same disadvantages, except the source files are
> *also* unreadable (which is the one really nice feature of AsciiDoc
> - you can ignore everything else, and just read the original .txt
> file).

So what?

    makeinfo --plaintext

exists.  The important thing for a source file format is that it is
_writeable_.  Restricting a source file format to carry just that kind
of information which can be made to look pretty is a mistake in my
book.

Anyway, here are some sections from AUCTeX's README generated from
readme.texi:

    Introduction to AUCTeX
    **********************

    This file gives a brief overview of what AUCTeX is.  It is *not* an
    attempt to document AUCTeX.  Real documentation for AUCTeX is available
    in the manual, which should be available as an info file after
    installation.

    1 Installation
    **************

    Read the `INSTALL' or `INSTALL.windows' file respectively for
    comprehensive information about how to install AUCTeX.

       The installation routine tries to make the modes provided by AUCTeX
    the default for all supported file types.  If this does not happen in
    your case, add
         (load "auctex.el" nil t t)
       to your init file and consult the section about loading the package
    in the `INSTALL' file.

       If you want to change the modes for which it is operative instead of
    the default, use
         M-x customize-variable RET TeX-modes RET

       If you want to remove a preinstalled AUCTeX completely before any of
    its modes have been used,
         (unload-feature 'tex-site)
       should accomplish that.

       If you are considering upgrading AUCTeX, the recent changes are
    described in the `CHANGES' file.

Actually, the indentation could be prettier if the quote environments
were properly set off as paragraphs.

Anyway, here is the corresponding source (it suffers from the
complications that it is the start of the file, and that the README
can be produced both as a top-level standalone file, as well as a
subordinate chapter in the containing complete documentation).

    @include macros.texi
    @ifset rawfile
    @chapheading Introduction to @AUCTeX{}
    @raisesections
    @end ifset

    @ifclear rawfile
    @node Introduction, Installation, Copying, top
    @chapter Introduction to @AUCTeX{}
    @end ifclear

    @ifset rawfile
    This file
    @end ifset
    @ifclear rawfile
    This section of the @AUCTeX{} manual
    @end ifclear
    gives a brief overview of what @AUCTeX{} is.  It is @strong{not} an
    attempt to document @AUCTeX{}.  Real documentation for @AUCTeX{} is
    available in the
    @ifset rawfile
    manual, which should be available as an info file after installation.
    @end ifset
    @ifclear rawfile
    rest of the manual.
    @end ifclear

    @section Installation

    Read the
    @ifset rawfile
    @file{INSTALL} or @file{INSTALL.windows} file
    @end ifset
    @ifclear rawfile
    section @ref{Installation}, or @ref{Installation under MS Windows},
    @end ifclear
    respectively for comprehensive information about how to install
    @AUCTeX{}.

    The installation routine tries to make the modes provided by @AUCTeX{}
    the default for all supported file types.  If this does not happen in
    your case, add
    @lisp
    (load "auctex.el" nil t t)
    @end lisp
    to your init file and consult the section
    @ifset rawfile
    about loading the package in the @file{INSTALL} file.
    @end ifset
    @ifclear rawfile
    @ref{Loading the package}.
    @end ifclear

    If you want to change the modes for which it is operative instead of the
    default, use
    @example
    @kbd{M-x customize-variable RET TeX-modes RET}
    @end example

    If you want to remove a preinstalled @AUCTeX{} completely before any of
    its modes have been used,
    @example
    (unload-feature 'tex-site)
    @end example
    should accomplish that.

    If you are considering upgrading @AUCTeX{}, the recent changes are
    described in
    @ifset rawfile
    the @file{CHANGES} file.
    @end ifset
    @ifclear rawfile
    @ref{Changes}.
    @end ifclear


This is reasonable writeable, and it contains all the information for
hyperlinking and cross-referencing the stuff.  It is not necessarily
overly pretty, but it can be converted very efficiently both into
single file PDF which can be either navigated on its own or printed,
or into raw text files similar to the existing documentation, or into
HTML or into info, for which efficient _hierarchical_ readers exist.

Now XML certainly has all the expressivity needed to represent the
same information, but you still need a reader that actually makes use
of it.  And you have to have the information also expressed in
AsciiDoc, and the requirement that it still looks good in the _source_
code makes it awkward designing an appropriate ASCII way of
representing the information.

AsciiDoc may have the _potential_ to do the same, but at the current
point of time, I don't see that there are tools for conveniently
navigating hundred-page and longer AsciiDoc documents.  And there are
for Texinfo.

I am fine if you don't like Texinfo and would rather use something
different with the _same_ amount of information content as Texinfo
has, and with readers that make use of it.  Heck, _if_ the source
format can be made to represent the same information, it might be
possible to create Texinfo or at least info pages from it.

Texinfo is not really the point.  It is just there to show that it
_is_ possible to work with documentation that provides a _structured_
view into a _large_, coherent document.  Of course, by far the best
reader for it (or rather the generated info files) is Emacs, and
that's definitely a drawback for those who don't work with it.  The
standalone reader has been sub-par for decades.  At the current point
of time, it may be considered tolerable, but not exciting.  But at
least it exists.

Man pages don't scale to hundreds of pages, and neither does the
current organization of git documentation do this.  If you can propose
something that works at least as well as Texinfo for navigating
hundreds of pages of information, go ahead.

It is not that Texinfo is great.  It is just that I don't see an
alternative that sucks less right now.  Lots of _formats_ would have
potential for it, but the readers for making use of such documentation
are just not there.  And PDF is not really a good alternative, since
fonts, pagination and linear order are not optimized for screen, but
for print.  And of course, it is much slower to display, and has no
up/down navigation, but only forward/back.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
