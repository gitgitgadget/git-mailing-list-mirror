From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: failing test t9400 (Re: [PATCH] git-update-ref: add --no-deref
 option for overwriting/detaching ref)
Date: Wed, 09 May 2007 18:58:20 +0200
Message-ID: <20070509165820.GX942MdfPADPa@greensroom.kotnet.org>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
 <7vk5viuim5.fsf@assigned-by-dhcp.cox.net>
 <20070509153831.GW942MdfPADPa@greensroom.kotnet.org>
 <7vr6pqt1fu.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 18:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlpUw-0001Ez-2j
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbXEIQ6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbXEIQ6h
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:58:37 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:58945 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756297AbXEIQ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:58:36 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JHS00ILK9T97J@psmtp13.wxs.nl> for git@vger.kernel.org; Wed,
 09 May 2007 18:58:21 +0200 (MEST)
Received: (qmail 3628 invoked by uid 500); Wed, 09 May 2007 16:58:20 +0000
In-reply-to: <7vr6pqt1fu.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46751>

On Wed, May 09, 2007 at 09:19:01AM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> > Shouldn't these tests be skipped if I don't have all that stuff installed?
> > There doesn't even seem to be an option to turn off these tests.
> 
> I agree.  We would need something like this, but I have no easy
> way to test it myself, short of uninstalling what I need on the
> box.  As you do not have them, maybe you can give it a quick
> whirl?

Seems to work, albeit with a nasty warning,

bash-3.00$ sh t9400-git-cvsserver-server.sh 
Can't locate DBD/SQLite.pm in @INC (@INC contains: /usr/lib/perl5/5.8.0/i686-linux-thread-multi /usr/lib/perl5/5.8.0 /usr/lib/perl5/site_perl/5.8.0/i686-linux-thread-multi /usr/lib/perl5/site_perl/5.8.0 /usr/lib/perl5/site_perl .) at -e line 1.
BEGIN failed--compilation aborted at -e line 1.
*   ok 1: skipping git-cvsserver tests, Perl SQLite interface unavailable
* passed all 1 test(s)

skimo
