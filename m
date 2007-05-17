From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 19:11:50 +0200
Message-ID: <20070517171150.GL5272@planck.djpig.de>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu May 17 19:12:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HojWD-0000jH-DN
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbXEQRL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755859AbXEQRL4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:11:56 -0400
Received: from planck.djpig.de ([85.10.192.180]:1794 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744AbXEQRLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 13:11:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 302F288060;
	Thu, 17 May 2007 19:11:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBXUbE2byLgq; Thu, 17 May 2007 19:11:50 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 7448F88061; Thu, 17 May 2007 19:11:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705171857.22891.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47540>

On Thu, May 17, 2007 at 06:57:22PM +0200, Johan Herland wrote:
> Of course, it all depends on whether the $Id$ conversion is triggered by 
> git-archive...

Another possibility might be to add a commandline switch to git-archive
so you can decide whether the commit id should be added as a header to
the tar file (which it already supports) or as a ordinary file (which
should be reasonable trivial to implement). The question if whether
it would be worth to add that feature. Don't know if there are many
other users out there that need it.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
