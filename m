From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bugfix: stop if directory already exists
Date: Mon, 14 Nov 2005 13:30:19 -0800
Message-ID: <7vlkzqx6hg.fsf@assigned-by-dhcp.cox.net>
References: <200511131503.32078.Josef.Weidendorfer@gmx.de>
	<7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net> <437858A1.9010007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 22:32:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbluC-0000br-He
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 22:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKNVaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 16:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVKNVaV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 16:30:21 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:18875 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932144AbVKNVaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 16:30:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114212951.UIYK20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 16:29:51 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437858A1.9010007@op5.se> (Andreas Ericsson's message of "Mon, 14
	Nov 2005 10:28:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11852>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>>
>>> usage: git clone ...
>>> For more details, see 'man git-clone'
>> And "for more details see man" goes without saying.
>
> But we name them differently, as hpa pointed out some week ago.
>
> When I see "usage: <prog> <command>" I expect to find the info in "man 
> <prog>".

... meaning, "man git", which would list the subcommands.

And a user who got "usage: git clone blah" and did "man git"
once is intelligent enough to know and remember "man git" lists
the subcommands, what she wanted to know about was listed as
"git-clone(1)", and she had to do "man git-clone", so next time
around we should be able to expect her to do "man git-commit".
Am I overestimating the users or overtaxing them?
