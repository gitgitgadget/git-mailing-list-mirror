From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] "test" in Solaris' /bin/sh does not support -e
Date: Mon, 26 Jun 2006 12:04:03 +0200
Message-ID: <20060626100402.G5761a3ea@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net> <20060626082754.G6ec0a61e@leonov.stosberg.net> <7vwtb4i89d.fsf@assigned-by-dhcp.cox.net> <20060626094211.G3b49c5c3@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 12:05:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Funwy-0001xa-1n
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 12:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWFZKEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 06:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWFZKEI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 06:04:08 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:54181 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S964864AbWFZKEH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 06:04:07 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id 5DC31AEBA065;
	Mon, 26 Jun 2006 12:04:00 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 4EFD01104B8; Mon, 26 Jun 2006 12:04:03 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060626094211.G3b49c5c3@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22672>

Dennis Stosberg wrote:

> A lot of bashisms have been removed from the shell scripts since
> that SHELL_PATH override was added in September 2005; I will have a
> look whether it's still necessary.

Solaris is really horrible sometimes.  "/bin/sh" is linked to
"/usr/bin/sh".  The manual sh(1) reads:

     The /usr/bin/sh utility is a  command  programming  language
     that executes commands read from a terminal or a file.

     The /usr/xpg4/bin/sh utility is a standards compliant shell.

Argh!  Why don't they put their "standards compliant" shell to
/bin/sh?  The current one doesn't even support the $( )-style command
substitution, so making the scripts run with that shell would be
_really_ ugly.

Regards,
Dennis
