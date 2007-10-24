From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: Howto request: going home in the middle of something?
Date: Wed, 24 Oct 2007 09:44:14 -0400
Message-ID: <20071024134414.GA15710@falcon.digizenstudio.com>
References: <200710181144.22655.wielemak@science.uva.nl> <20071018112758.GN18279@machine.or.cz> <200710221044.24191.wielemak@science.uva.nl> <20071023135655.x6g6mln1j4880wog@intranet.digizenstudio.com> <256C87B5-3ADE-4A96-9530-A45B97601BAA@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Wielemaker <wielemak@science.uva.nl>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Wed Oct 24 15:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkgXF-0001af-HU
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 15:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679AbXJXNoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 09:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758731AbXJXNoY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 09:44:24 -0400
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:45887
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757679AbXJXNoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 09:44:23 -0400
Received: (qmail 13338 invoked from network); 24 Oct 2007 13:44:23 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-01.prod.mesa1.secureserver.net (64.202.189.88) with ESMTP; 24 Oct 2007 13:44:23 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 7EF80100099;
	Wed, 24 Oct 2007 13:44:23 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CdoKWMRyHmK; Wed, 24 Oct 2007 09:44:15 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id CE728100078;
	Wed, 24 Oct 2007 09:44:15 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id E108B7B52D; Wed, 24 Oct 2007 09:44:14 -0400 (EDT)
Mail-Followup-To: Matthias Kestenholz <mk@spinlock.ch>,
	Jan Wielemaker <wielemak@science.uva.nl>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <256C87B5-3ADE-4A96-9530-A45B97601BAA@spinlock.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62217>

On Tue, Oct 23, 2007 at 10:28:46PM +0200, Matthias Kestenholz wrote:
> Hi,

Hi,

> If someone tracks the main branch you are working on and fetches
> while you are travelling home, he has the WIP commit as a new tip
> in his tree.
> If he bases further work upon the WIP commit, he'll need to rebase
> or merge his changes onto your new tip once you have amended or
> replaced the commit. If you are working on the
> master branch, you should really avoid rewinding it. Rewinding topic
> branches is ok, but a temporary branch is still better to clearly tell
> potential fetch-ers that this is only Work in Progress, and not meant
> to be published in the current state.

Good point. Although I guess if some workflow lets you directly hack on a
public branch, it can have lots of other issues beyond just the WIP
being pulled accidentally, no?

Cheers.
-- 
Jing Xue
