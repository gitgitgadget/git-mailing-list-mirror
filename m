From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 15:28:46 +1300
Message-ID: <46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	 <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 03:32:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eotjf-0002z2-EE
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 03:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVLUC2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 21:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVLUC2s
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 21:28:48 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:18279 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932263AbVLUC2r convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 21:28:47 -0500
Received: by wproxy.gmail.com with SMTP id 57so39159wri
        for <git@vger.kernel.org>; Tue, 20 Dec 2005 18:28:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PgmrAuiNc+SwOUM2Eq0H8do0kR3OX7yAjOROx+rOVYUUKdIW6yRTNBsTb1WPcu9IbY/KKsEUyQzGb2RlCZOkV3MzVGhr4+eOEfETdGZxl3jI9jZQ+KBO9W8zHBqn8ZGurY/h3O+rNMG65paoZVbXidXDEDKlgYG8q6Jfu6R4jo4=
Received: by 10.54.113.6 with SMTP id l6mr287232wrc;
        Tue, 20 Dec 2005 18:28:46 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Tue, 20 Dec 2005 18:28:46 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13861>

On 12/21/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin, is this happening when your developers push into the
> shared repo?

yes...

> If so, do your developers use git-shell?

no...

>  Do their
> umask set properly even when they come over ssh and gets into
> noninteractive shell?

Oh DUH. PEBKAK. .bash_profile != .bashrc

I think I owe you an apology and a couple of beers -- I'm an idiot. No
wonder I feel "at home" with "git"...

cheers,


martin
