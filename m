From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 22:55:35 +0200
Message-ID: <20070524205535.GP4489@pasky.or.cz>
References: <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521211133.GD5412@admingilde.org> <7viraixeme.fsf@assigned-by-dhcp.cox.net> <20070524184549.GW942MdfPADPa@greensroom.kotnet.org> <7vy7jevyjx.fsf@assigned-by-dhcp.cox.net> <20070524191438.GZ942MdfPADPa@greensroom.kotnet.org> <7vy7jeufmn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Verdoolaege <skimo@kotnet.org>,
	Martin Waitz <tali@admingilde.org>, Jan Hudec <bulb@ucw.cz>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:55:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrKLV-0006rC-M0
	for gcvg-git@gmane.org; Thu, 24 May 2007 22:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbXEXUzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 16:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbXEXUzj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 16:55:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52552 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265AbXEXUzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 16:55:38 -0400
Received: (qmail 1745 invoked by uid 2001); 24 May 2007 22:55:35 +0200
Content-Disposition: inline
In-Reply-To: <7vy7jeufmn.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48305>

On Thu, May 24, 2007 at 10:32:32PM CEST, Junio C Hamano wrote:
> And she does not have to.  She can do the development/fixes in
> (temporarily) checked out subproject tree, and push it back to
> the .git/subproject/kernel26/ repository in the superproject
> before she leaves (i.e. before branch switching at superproject
> level needs to obliterate it).  The change stored in the
> .git/subproject/kernel26/ repository in the superproject can
> further be pushed back to its 'origin', be it the true
> "upstream", or "the standalone repository for the subproject" I
> mentioned above.
..snip..
> It's just bare/pure layout is easier to understand because it is
> essentially a "mirror" of the upstream.

I OTOH think that it's less confusing to just keep it the same for all
the normal repositories - and you yourself did not rule out the
possibility to have local changes in the repository, in which case we
certainly should use the separate-remotes layout or we go back to last
year's refs mess.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
