From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 01:52:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0708040133500.23671@iabervon.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr>
 <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com>
 <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708040046400.23671@iabervon.org>
 <7v1wejj2j8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:52:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCZ9-0000k7-Jr
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 07:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbXHDFwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 01:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbXHDFwl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 01:52:41 -0400
Received: from iabervon.org ([66.92.72.58]:3980 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199AbXHDFwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 01:52:40 -0400
Received: (qmail 27320 invoked by uid 1000); 4 Aug 2007 05:52:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Aug 2007 05:52:39 -0000
In-Reply-To: <7v1wejj2j8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54796>

On Fri, 3 Aug 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It's worth noting that we're a substantial portion of the asciidoc user 
> > base, at least based on asciidoc's "Projects using AsciiDoc" page. We 
> > could probably be influential in the asciidoc development if we tried 
> > (maybe starting with a config file mechanism for controlling what 
> > characters are markup instead of literal, so that we'll be able to make 
> > documents which will work the same with all versions of asciidoc).
> 
> Tempting, but...
> 
>  * The breakage that triggered this thread was not about asciidoc
>    but about docbook-xsl.  AsciiDoc project cannot do much about
>    it.
> 
>  * The slowness while formatting our manual pages are 50% from
>    xmlto toolchain and even if AsciiDoc were were to be sped up
>    20x, we will still spend 4-5 minutes to format ~140 manual
>    pages.

For the latter, asciidoc ought to be able to generate manpages. Not sure 
what to do about docbook (for the user manual); it seems generally prone 
to compatibility problems. Perhaps we should go through latex instead, 
since that's extremely stable these days, or go straight to html.

	-Daniel
*This .sig left intentionally blank*
