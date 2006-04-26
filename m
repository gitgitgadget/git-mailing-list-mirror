From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Wed, 26 Apr 2006 13:17:49 -0700
Message-ID: <7vy7xsm6qa.fsf@assigned-by-dhcp.cox.net>
References: <20060325235859.GO26071@mythryan2.michonline.com>
	<1143336048205-git-send-email-normalperson@yhbt.net>
	<46a038f90604251745u1b15ad99ka1aeff1cd8d8c344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <junkio@cox.net>, git <git@vger.kernel.org>,
	"Ryan Anderson" <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Wed Apr 26 22:17:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYqSQ-0001kq-FT
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 22:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWDZURv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 16:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWDZURv
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 16:17:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59083 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964861AbWDZURv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 16:17:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426201750.CDEY15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 16:17:50 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604251745u1b15ad99ka1aeff1cd8d8c344@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 26 Apr 2006 12:45:41 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19218>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

>  * This box has nothing listening on port 25. It doesn't get email
> from the net, being a LAN machine, so I've told the debian config
> system that we don't need an smtp daemon. Net::SMTP doesn't know how
> to use /usr/bin/sendmail

Wouldn't --smtp-server=that.smtp.server work for you?  Ah, that
would not work if your use is to send a local mail.  Hmph...
