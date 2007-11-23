From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: cloning submodules with children submodules
Date: Fri, 23 Nov 2007 20:49:04 +0100
Message-ID: <20071123194904.GL2261MdfPADPa@greensroom.kotnet.org>
References: <BC1DE15A-9225-41D3-A2D7-21A14DF81048@nrlssc.navy.mil>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Paul Martinolich <martinol@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 23 20:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IveWo-0000Xt-Du
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbXKWTtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757146AbXKWTtI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:49:08 -0500
Received: from psmtp09.wxs.nl ([195.121.247.23]:35523 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757157AbXKWTtG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:49:06 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JRZ008LT5PSY5@psmtp09.wxs.nl> for git@vger.kernel.org; Fri,
 23 Nov 2007 20:49:04 +0100 (MET)
Received: (qmail 19076 invoked by uid 500); Fri, 23 Nov 2007 19:49:04 +0000
In-reply-to: <BC1DE15A-9225-41D3-A2D7-21A14DF81048@nrlssc.navy.mil>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65920>

On Fri, Nov 23, 2007 at 01:17:15PM -0600, Paul Martinolich wrote:
> It appears that git clone or git submodule init does not handle  
> submodules under submodules.

I don't see why it wouldn't work.

You seem to think, however, that git submodule update would
call git submodule update/init inside any submodules it clones.
It doesn't.

> The cloning of proj_two works correctly.  However, for proj_one, mod_b  
> is not under mod_B:

You didn't commit the change to mod_B to proj_one.
Furthermore, you didn't push your changes to mod_B to
the repo you specified for mod_B in .gitmodules.

skimo
