From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 14:06:59 +0100
Message-ID: <20090115130659.GA18081@diku.dk>
References: <20090113233643.GA28898@diku.dk> <20090114232456.GA6937@b2j> <20090114235607.GA5546@diku.dk> <20090115014617.GC6937@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 14:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRxU-0008Lv-WE
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbZAONHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbZAONHE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:07:04 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:60481 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268AbZAONHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:07:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 140D952C3A5
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:07:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zTqPIoCfjKjL for <git@vger.kernel.org>;
	Thu, 15 Jan 2009 14:06:59 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id AD7DB52C390
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:06:59 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 1EA926DFAB0
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:05:49 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 98B3239A9FF; Thu, 15 Jan 2009 14:06:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090115014617.GC6937@b2j>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105793>

bill lam <cbill.lam@gmail.com> wrote Thu, Jan 15, 2009:
> On Thu, 15 Jan 2009, Jonas Fonseca wrote:
> > Yes, it works. You can either create a file called config.make with a
> > line saying:
> > 
> > 	LDLIBS = -lncursesw
> > 
> > or use the configure file. If you are not using the tarball generate it
> > with:
> > 
> > 	make configure
> 
> I use the git source. Even after make configure and  ./configure, it
> still links to the non-unicode ncurses.

I haven't tested the configure script on a lot of system, so it might be
a bit debian/ubuntu/gentoo centered in that use of ncursesw requires the
presence of a {/usr/incude/}ncursesw/ncurses.h header. Where are the
unicode ncurses.h files found on your system?

> Should it make ncursesw as 
> default if detected available albeit this can be changed manually?

I would prefer that the "default" (running make without configure) has
as few dependencies as possible. Since the unicode version of ncurses is
probably more rare than the non-unicode version it is probably a bad
idea to use ncursesw by default. However, if you use the configure
script ncursesw is the default, when it is available.

-- 
Jonas Fonseca
