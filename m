From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 22:32:07 +0200
Message-ID: <85bqdlhge0.fsf@lola.goethe.zz>
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
	<alpine.LFD.0.999.0708051118590.5037@woody.linux-foundation.org>
	<85y7gphkdd.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 22:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHmm2-0008LK-EU
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 22:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbXHEUcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 16:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbXHEUcM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 16:32:12 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:56949 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692AbXHEUcL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 16:32:11 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id E5E9830337D;
	Sun,  5 Aug 2007 22:32:09 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id D54F3ABE0E;
	Sun,  5 Aug 2007 22:32:09 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 49A0130A9F3;
	Sun,  5 Aug 2007 22:32:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 01C261C3D500; Sun,  5 Aug 2007 22:32:07 +0200 (CEST)
In-Reply-To: <85y7gphkdd.fsf@lola.goethe.zz> (David Kastrup's message of "Sun\, 05 Aug 2007 21\:06\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3864/Sun Aug  5 19:21:44 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55069>

David Kastrup <dak@gnu.org> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So by advocating Texinfo, you're advocating something that is
>> OBJECTIVELY WORSE than what we have now.
>>
>> And I tried to explain why, by pointing out that info files (which
>> was the case you tried to push as an advantage) aren't actually an
>> advantage to any normal user.
>
> Linus, your "normal user" does not get any documentation that can
> usefully be employed for navigating a large body of documentation.
>
> Anyway, this particular flame feast might be somewhat irrelevant: I
> have read up a bit on AsciiDoc and Docbook.

Ok, it turns out that

docbook2x-texi --info --to-stdout usermanual.xml >usermanual.info

cranks out (after a few inexplicable warnings/errors) a completely
functional info file.  The one thing that is conspicously missing is
indexing and info-dir information, and that's because it is not in the
source in the first place.

Whether you want to believe it or not, this already helps me
_considerably_ find my way around git.

So info, at least for the manual, can at the current point of time be
supported by merely adding Makefile targets.

Since an index is useful for other output formats, I don't think that
there should be objections to adding indexing info into the manual.
This takes the AsciiDoc form of ((primary)) for a primary entry
appearing in the text, and (((primary[, secondary[, third]]))) for a
hierarchical entry not appearing in the text itself.

Correct?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
