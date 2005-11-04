From: David Brown <git@davidb.org>
Subject: Re: binary safe?
Date: Fri, 4 Nov 2005 08:54:19 -0800
Message-ID: <20051104165419.GA12145@old.davidb.org>
References: <86br115r0z.fsf@blue.stonehenge.com> <7v7jbpbb3l.fsf@assigned-by-dhcp.cox.net> <46a038f90511031500p3d6ed433s6efe3f5a5e60bcf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 17:57:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY4pa-0007rl-Ko
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 17:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVKDQyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 11:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKDQyU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 11:54:20 -0500
Received: from adsl-64-172-240-129.dsl.sndg02.pacbell.net ([64.172.240.129]:49862
	"EHLO mail.davidb.org") by vger.kernel.org with ESMTP
	id S1750717AbVKDQyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 11:54:19 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.54 #1 (Debian))
	id 1EY4pX-0003Ci-4R
	for <git@vger.kernel.org>; Fri, 04 Nov 2005 08:54:19 -0800
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90511031500p3d6ed433s6efe3f5a5e60bcf8@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11143>

On Fri, Nov 04, 2005 at 12:00:54PM +1300, Martin Langhoff wrote:

> Yes it works, and cvsimport -k will do the right thing for you.

Unless it has changed from 0.99.9b, 'cvsimport -k' will very much scramble
some binary files.  '-k' passes the '-kk' option which causes CVS to strip
the keywords down.  It needs to pass -ko through if you want it to be able
to handle binary files.

However, since CVS (RCS really) can remember the state of this flag, it
does work to  'cvs admin -ko filename' beforehand, and then do the
cvsimport without the '-k' option.

Dave
