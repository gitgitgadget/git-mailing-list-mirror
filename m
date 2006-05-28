From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] git-fetch: Shell syntax fix for NetBSD
Date: Sun, 28 May 2006 23:28:03 +0200
Message-ID: <20060528212803.G53d5b45d@leonov.stosberg.net>
References: <20060528204510.G51ab1cf8@leonov.stosberg.net> <7vbqthdfpa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 23:28:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkSo3-0000Ll-OS
	for gcvg-git@gmane.org; Sun, 28 May 2006 23:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWE1V2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 17:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWE1V2K
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 17:28:10 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:28626 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750897AbWE1V2I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 17:28:08 -0400
Received: from leonov.stosberg.net (p213.54.89.85.tisdip.tiscali.de [213.54.89.85])
	by ncs.stosberg.net (Postfix) with ESMTP id F3C25589000C;
	Sun, 28 May 2006 23:27:54 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id ED0921044F0; Sun, 28 May 2006 23:28:03 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqthdfpa.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20896>

Junio C Hamano wrote:

> Funny.  Without the posixy open parenthesis, bash barfs ;-).
> 
>         git-fetch: line 219: syntax error near unexpected token `;;'
>         git-fetch: line 219: `                 *^*) continue ;;'
> 
> So how about doing this instead?  Does NetBSD default shell
> still work with it?

This looked so simple that I didn't notice the command
substitution...

Yes, your version works correctly here.

Regards,
Dennis
