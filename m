From: Andrew Ruder <andy@aeruder.net>
Subject: Re: [PATCH] Try 2: Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 3 May 2007 19:03:39 -0500
Message-ID: <20070504000339.GA2476@localdomain>
References: <463A6930.8090603@larsen.st> <7vfy6dzf25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 04 02:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjlGy-0001fd-Je
	for gcvg-git@gmane.org; Fri, 04 May 2007 02:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767492AbXEDADl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767496AbXEDADl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 20:03:41 -0400
Received: from www.aeruder.net ([65.254.53.245]:1177 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767492AbXEDADl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 20:03:41 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 4CB7740192
	for <git@vger.kernel.org>; Thu,  3 May 2007 19:03:40 -0500 (CDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vfy6dzf25.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46123>

On Thu, May 03, 2007 at 04:02:26PM -0700, Junio C Hamano wrote:
> I do not get this whole business.  Why would you even want to
> support that to begin with?

The biggest problem being that on macs it is typical to have two copies
of perl installed (/usr/bin/perl and /opt/local/bin/perl with
DarwinPorts or otherwise).  It'd be nice to have a way to tell git
makefiles to put #!/usr/bin/env perl at the top so it just pulls
what is first in the path rather than having to hardcode it to either
/opt/local/bin/perl or /usr/bin/perl.

Say you are packaging a mac os x package of git.  Now for the user to
run something like git-svn they'd need the svn bindings obviously, but
of course, some people install them against their system perl, lots of
people install them against their darwinports or otherwise, and it'd be
really nice to just have those various perl scripts use whatever the
person has set up (going by what they have first in their path).

- Andy

-- 
Andrew Ruder <andy@aeruder.net>
http://www.aeruder.net
