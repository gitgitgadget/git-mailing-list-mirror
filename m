From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Mon, 06 Aug 2007 07:44:58 +0200
Message-ID: <85y7gpfc85.fsf@lola.goethe.zz>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
	<85myx7dwb3.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org>
	<85bqdndqgr.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org>
	<85bqdmctcl.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org>
	<85bqdlj1lh.fsf@lola.goethe.zz>
	<7vr6mheem0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 07:45:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHvOw-0002O5-Uc
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 07:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbXHFFpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 01:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbXHFFpH
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 01:45:07 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:43254 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992AbXHFFpE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 01:45:04 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 2D4B815B702;
	Mon,  6 Aug 2007 07:45:01 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 1AF1C1143B8;
	Mon,  6 Aug 2007 07:45:01 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-031-166.pools.arcor-ip.net [84.61.31.166])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id CB41A1BF38A;
	Mon,  6 Aug 2007 07:45:00 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E08C11C3D500; Mon,  6 Aug 2007 07:44:58 +0200 (CEST)
In-Reply-To: <7vr6mheem0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun\, 05 Aug 2007 16\:38\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3874/Mon Aug  6 02:38:49 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55115>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>>> So stop this *insane* insistence of emacs. You should learn to just
>>> assume that people don't even have it installed!
>>
>> We were discussing Texinfo, not Emacs.  Please focus.
>
> I would welcome if the set of our documentation output formats
> included *.info pages.
>
> However, as the input format, texinfo _is_ painful.  AsciiDoc is
> 100x easier.

If you are able to figure out what to write.  Can you tell me how to
include one of the man pages in an appendix, with appropriate
substructure?  I can't.  It might be easy, but I find it impossible
to guess from the information just how.

> I've written documentaiton in texinfo format in the past, and one
> thing I found quite painful was maintaining the node header with
> prev/next links --- tedious, error prone and boring.

    File: texinfo,  Node: makeinfo Pointer Creation,  Next: anchor,  Prev: node,  Up: Nodes

    6.4 Creating Pointers with `makeinfo'
    =====================================

    The `makeinfo' program has a feature for automatically determining node
    pointers for a hierarchically organized document.

      When you take advantage of this feature, you do not need to write the
    `Next', `Previous', and `Up' pointers after the name of a node.
    However, you must write a sectioning command, such as `@chapter' or
    `@section', on the line immediately following each truncated `@node'
    line (except that comment lines may intervene).

      In addition, you must follow the `Top' `@node' line with a line
    beginning with `@top' to mark the `Top' node in the file.  *Note
    `@top': makeinfo top.

      Finally, you must write the name of each node (except for the `Top'
    node) in a menu that is one or more hierarchical levels above the
    node's hierarchical level.

      This implicit node pointer insertion feature in `makeinfo' relieves
    you from the need to update menus and pointers manually or with Texinfo
    mode commands.  (*Note Updating Nodes and Menus::.)

> There is no good editor to help you maintain them other than Emacs
> texinfo mode as far as I know.

Then don't maintain them.  It is not necessary.

Anyway, I suggest that people wanting to continue to berave me for
taking the word Texinfo into my mouth do this off-list.  It is very
much clear that Texinfo is no-go as a source documentation format for
Git: it makes a considerable ratio of developers foam at the mouth.
And that simply rules it out.

It also turns out that makeinfo2x-texi is able to produce rather good
Texinfo from stuff written for book output with Asciidoc.  Yes, there
are details missing, but it is nothing one could not slide in with
sed into the Texinfo file.  And adding the absent indexing information
can be done in Asciidoc: that is documented.

In contrast, I have just tried using makeinfo --docbook on AUCTeX
Texinfo documentation, and the docbook XML it produces is not always
properly nested, and when one corrects that, the problems with
processing that just start: that seems not really tested, at least
with makeinfo 4.8.

So there is a good Docbook->info path, but not the other way round.
Anyway, you wrote:

> I would welcome if the set of our documentation output formats
> included *.info pages.

At least for the user manual, I can support this (without index) in a
dozen lines of makefile code and another dozen lines of sed (for
adding the top/dir entry information).  Yes, this caught me quite by
surprise.  For the indexing, of course one will have to insert the
appropriate Asciidoc markup into the source files.  I can also work on
that, but it should likely be a colloborative effort: it leads to a
working Index also in the PDF output without the need to involve
Texinfo.

As for making the man pages part of the main manual: I don't know my
way around Asciidoc enough to be able to do this.  It might be
possible to fudge around this issue with sed again, converting the
manual page sources to book section sources.  I am sure there is a
more elegant way to do this sort of transformation/conversion either
on the Asciidoc or XML level, but it's beyond me.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
