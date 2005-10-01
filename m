From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Support SPARSE in Makefile, better SPARSE_FLAGS
Date: Sat,  1 Oct 2005 00:13:58 -0400
Message-ID: <20051001001358.n59rjyg48400c0kw@webmail.spamcop.net>
References: <1128026765.24397.46.camel@dv>
	<7vek779kg0.fsf@assigned-by-dhcp.cox.net> <1128087662.14543.14.camel@dv>
	<433D8FA6.2080808@zytor.com> <1128118469.7352.15.camel@dv>
	<433DB950.3010909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 06:14:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELYl8-0007vC-St
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 06:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVJAEOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 00:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVJAEOA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 00:14:00 -0400
Received: from c60.cesmail.net ([216.154.195.49]:35985 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S1750724AbVJAEN7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 00:13:59 -0400
Received: from unknown (HELO epsilon.cesmail.net) ([192.168.1.40])
  by c60.cesmail.net with SMTP; 01 Oct 2005 00:14:00 -0400
Received: (qmail 20545 invoked by uid 99); 1 Oct 2005 04:13:58 -0000
Received: from static-68-161-241-229.ny325.east.verizon.net
	(static-68-161-241-229.ny325.east.verizon.net [68.161.241.229]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Sat,  1 Oct 2005 00:13:58 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433DB950.3010909@zytor.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9583>

Quoting "H. Peter Anvin" <hpa@zytor.com>:

> Pavel Roskin wrote:
> >
> > I know.  That's what I'm using in the wrapper (plus -m64 and some
> > warnings).  But it should be the default.  Until then, hassle-free
> > sparse support in the Makefile is only possible for the projects that
> > already know the architecture (e.g. the Linux kernel).
> >
>
> I think that's debatable.  It introduces main-compiler dependencies into
> sparse which is undesirable.

I see sparse is already moving in this direction.  Right now, it's somewhere in
the middle, which is quite inconvenient.  It hardcodes gcc version numbers but
not the architecture.

> A much simpler option would be to write a "sparsegcc" script which would
> be invoked just like gcc, extract the appropriate macro information
> based on options, and then invoke sparse.

I guess that's what cgcc is trying to be.  Since it also runs the compiler, no
special support for cgcc should be needed in Makefile other than using $(CC).

--
Regards,
Pavel Roskin
