From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH (amend)] gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'}
Date: Tue, 29 Aug 2006 09:18:35 +0200
Message-ID: <20060829071835.G795d5eff@leonov.stosberg.net>
References: <20060824151246.G465d67c8@leonov.stosberg.net> <11567801982990-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 09:18:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHxrt-0006g6-6L
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 09:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWH2HSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 03:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWH2HSh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 03:18:37 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:46723 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S1750833AbWH2HSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 03:18:37 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id 9E662E8B1D; Tue, 29 Aug 2006 09:18:35 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <11567801982990-git-send-email-jnareb@gmail.com>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26190>

Jakub Narebski wrote:

> Dennis, could you check that it works for you in 'next'
> version of gitweb? The patch you sent is pre-rename even...

Yes, it works for me.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>

There is another trivial failure with mod_perl: The configuration file
will only be read on the first invocation of the script.  I didn't
notice it until today, because I never used a configuration file before.

Regards,
Dennis
