From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Fri, 03 Aug 2007 22:23:55 -0700
Message-ID: <7v1wejj2j8.fsf@assigned-by-dhcp.cox.net>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708040046400.23671@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHC7N-0004zY-Lh
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 07:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbXHDFX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 01:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbXHDFX6
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 01:23:58 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41764 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbXHDFX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 01:23:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804052358.KEOC7193.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 01:23:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XhPw1X0051kojtg0000000; Sat, 04 Aug 2007 01:23:56 -0400
In-Reply-To: <Pine.LNX.4.64.0708040046400.23671@iabervon.org> (Daniel
	Barkalow's message of "Sat, 4 Aug 2007 00:57:03 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54791>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It's worth noting that we're a substantial portion of the asciidoc user 
> base, at least based on asciidoc's "Projects using AsciiDoc" page. We 
> could probably be influential in the asciidoc development if we tried 
> (maybe starting with a config file mechanism for controlling what 
> characters are markup instead of literal, so that we'll be able to make 
> documents which will work the same with all versions of asciidoc).

Tempting, but...

 * The breakage that triggered this thread was not about asciidoc
   but about docbook-xsl.  AsciiDoc project cannot do much about
   it.

 * The slowness while formatting our manual pages are 50% from
   xmlto toolchain and even if AsciiDoc were were to be sped up
   20x, we will still spend 4-5 minutes to format ~140 manual
   pages.
