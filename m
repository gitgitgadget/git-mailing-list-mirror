From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add autoconf-based build infrastructure for tig
Date: Sat, 09 Jun 2007 10:47:08 -0700
Message-ID: <466AE79C.4050605@midwinter.com>
References: <20070531215508.GB9260@diku.dk> <20070603193521.GA10161@midwinter.com> <20070609093101.GA25039@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jun 09 19:47:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx51v-0007xn-D7
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 19:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbXFIRrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 13:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756477AbXFIRrO
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 13:47:14 -0400
Received: from tater.midwinter.com ([216.32.86.90]:46346 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752951AbXFIRrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 13:47:13 -0400
Received: (qmail 21439 invoked from network); 9 Jun 2007 17:47:13 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=M850EUz1pl8KBNUcDfAfopq5oGF+DE7yJazK0WNAy+q3N3O6kp4Aa3ubQrcwLvX+  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 9 Jun 2007 17:47:13 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070609093101.GA25039@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49587>

Jonas Fonseca wrote:
> I've only played little with this patch, but overall I like most of the
> changes. I would, however, want to look into making the dependency on
> autoconf optional (like it is for git) and avoid using automake at all.
> It would make the autoconf.sh bootstrap script obsolete, since the
> Makefile can just take care of it, and it would keep the build system
> simple.
>
> So the idea is for configure to also generate a Makefile.config that can
> be sourced by the Makefile. Then of course inclusion of the config.h
> file should depend on some -DHAVE_CONFIG_H flag for the compiler.
>
> What do you think? You are of course welcome to come up with a patch for
> this proposal, but else I would like to get your permission/sign-off to
> include the configure.ac script and the tig.c changes you made.

That sounds perfectly sensible to me. Not sure when I'll have time to 
work on that proposal, but in the meantime you can use whatever bits of 
my original patch you like. Sorry about the lack of a Signed-off-by line 
in the original post -- I use git for private stuff at work 99% of the 
time and it sometimes slips my mind to add that extra header line for 
public changes. So, retroactively (though if you like I can resend the 
whole patch with this line):

Signed-off-by: Steven Grimm <koreth@midwinter.com>

-Steve
