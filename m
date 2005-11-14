From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bugfix: stop if directory already exists
Date: Mon, 14 Nov 2005 00:57:29 -0800
Message-ID: <7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net>
References: <200511131503.32078.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 09:59:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eba9f-00046A-26
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 09:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVKNI5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 03:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVKNI5c
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 03:57:32 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43983 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751006AbVKNI5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 03:57:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114085707.KNGU3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 03:57:07 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511131503.32078.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 13 Nov 2005 15:03:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11775>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> Fix a typo: We do not want to run the directory as command,
> and want to terminate if the directory exists
> Additionally, update the usage message

Thanks.

> Should we use "git clone" or "git-clone" in the usage message?

I think "git clone" is probably preferred, given that we would
eventually want to be able to install them outside /usr/bin/,
leaving "git" wrapper (and very small number of other programs)
in /usr/bin/.

>  usage: git clone ...
>  For more details, see 'man git-clone'

My understanding of UNIX tradition of "usage:" is to be short
and sweet, to primarily help people who already know the command
but sometimes cannot remember how exactly the options are
spelled (e.g. "was that -F to specify the inter-field separator
to "sort" command?  Ah, no, it wants -t -- silly me must be
doing too much awk these days").  And "for more details see man"
goes without saying.
