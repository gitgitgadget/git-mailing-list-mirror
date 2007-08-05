From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Mon, 06 Aug 2007 00:15:24 +0200
Message-ID: <857io9hblv.fsf@lola.goethe.zz>
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
	<alpine.LFD.0.999.0708051221290.5037@woody.linux-foundation.org>
	<46B6446D.4030607@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: bkorb@gnu.org
X-From: git-owner@vger.kernel.org Mon Aug 06 00:15:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHoO0-0004pq-AF
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 00:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbXHEWPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 18:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXHEWPa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 18:15:30 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:35688 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601AbXHEWP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 18:15:29 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id D7318366608;
	Mon,  6 Aug 2007 00:15:27 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id B852323D296;
	Mon,  6 Aug 2007 00:15:27 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 7AA1135E684;
	Mon,  6 Aug 2007 00:15:27 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AFB7B1C3D500; Mon,  6 Aug 2007 00:15:24 +0200 (CEST)
In-Reply-To: <46B6446D.4030607@gnu.org> (Bruce Korb's message of "Sun\, 05 Aug 2007 14\:43\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3867/Sun Aug  5 22:29:23 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55075>

Bruce Korb <bkorb@gnu.org> writes:

> Linus Torvalds wrote:
>
>> AsciiDoc is *also* a source format. But the source format is
>> already readable IN ITSELF. Which is the whole point!
>
> Readable, just not writable.  It's markup language is a bunch of
> special characters that require familiarity to understand.

Well, one problem I find that the documentation of both Asciidoc and
the connected Docbook toolchain is horribly subpar.

One part of the problem is that asciidoc.txt is written in Asciidoc,
and so you can't pick apart markup from content in the explanations
when reading the "readable in itself" documents.

Another problem is that most of the details of conversion to Docbook,
and what results in what XML output, are completely glossed over.  And
then there are further problems in that downstream Docbook processors
are documented even worse.

Then there is the problem that the markup can be redefined: the
sectioning underlines explained in the asciidoc documentation differ
from that _used_ in the documentation and again from that used in the
git documentation.

Now I can, in fact, use
docbook2x-texi --info --to-stdout user-manual.xml >user-manual.info
and get a working info file: not just basically working, but quite
fine (missing an index, though).

So there are "minor details" to fill in, like generated file names and
info directory entries.  Would you think that there is _any_ way of
finding out how to represent this in Docbook, or if you find out that,
how to get it from Asciidoc into Docbook?

Forget it.

Or things like including the manual pages in an appendix or elsewhere.
Any chance for that?  Slim, at least for me.

Texinfo source certainly looks less pretty than Asciidoc, but then
makeinfo can produce plain text output from it looking quite like
Asciidoc.  And whatever you may think about Texinfo as a format and
the generated info files and their readers: it is damn well
documented.

Asciidoc is quite readonly in many respects at the moment for me, and
I don't even know where to start in order to fix that.

And it does not help that there are multiple conversions involved with
a pretty opaque in-between XML representation.  In contrast, Texinfo
has a single well-documented source format and direct converters to
the target formats.

And its syntax is straightforward enough to write additional
converters if one wants to (makeinfo can even produce Docbook output,
so perhaps I may have a chance to reverse-engineer some required
information from there).

Whatever.  It is pretty clear that Texinfo is not going to be
interesting enough to maintain for most git developers to continue
this particular thread, as it won't progress beyond a simple and ugly
advocacy and name-calling thread.

Anyway, the necessary structural information (indexing, directory info
etc) presumably can be spliced into Asciidoc documents once somebody
finds out how to do this, and then Texinfo can be _generated_ from it
for those who need it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
