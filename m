From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 09:30:04 +0200
Message-ID: <85wswbiwoz.fsf@lola.goethe.zz>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 09:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHE5q-0000ss-43
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 09:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbXHDHaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 03:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbXHDHaM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 03:30:12 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:47306 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755143AbXHDHaK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 03:30:10 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id DA05937A4CD;
	Sat,  4 Aug 2007 09:30:08 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id CB47B2C6A17;
	Sat,  4 Aug 2007 09:30:08 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 5539B36E868;
	Sat,  4 Aug 2007 09:30:08 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 94F051C4F932; Sat,  4 Aug 2007 09:30:05 +0200 (CEST)
In-Reply-To: <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri\, 03 Aug 2007 21\:38\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54808>

Junio C Hamano <gitster@pobox.com> writes:

> Steven Grimm <koreth@midwinter.com> writes:
>
>> Am I correct in observing that "*roff -man" and HTML are the only
>> two output formats we care about, or do people use other formats in
>> their private branches?
>
> I obviously do not speak for others, but the only format I care
> about personally is the *.txt one.  We picked asciidoc primarily
> because the source language was readable.

[...]

> It might be more worthwhile to research what other "Text-ish
> lightweight mark-up" systems are availble, and if there is one
> that is more efficient and can go to at least html and man,
> one-time convert our documentation source to that format using
> your Perl magic.  The minimum requirements are:
>
>  * The source is readable without too much mark-up distraction;
>
>  * Can go to roff -man;
>
>  * Can go to html.

Naturally I am biased, but Texinfo might be an option.  The source is
editable without too much distraction, one can generate HTML, printed
output, cross-referenced info files (those are really convenient for
Emacs users), cross-referenced PDF output.  For man pages, one could
follow the path outlined in
<URL:http://gcc.gnu.org/onlinedocs/gccint/Man-Page-Generation.html>.
That is probably the weakest point.

Plain, user-readable ASCII text without any Texinfo markup can also be
generated.  One can even include images in info, PDF and HTML and have
those replaced by ASCII art in the plain text output.

There are some disadvantages: AFAIR, utf-8 characters will in general
not fly.  One needs to code accented characters more or less
explicitly.

Texinfo conversions are fast.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
