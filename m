From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Sparse fix for builtin-diff
Date: Sun, 07 May 2006 13:43:26 -0700
Message-ID: <7vpsiplg5t.fsf@assigned-by-dhcp.cox.net>
References: <20060507145046.GA24882@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 22:43:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcq6J-0005se-6S
	for gcvg-git@gmane.org; Sun, 07 May 2006 22:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWEGUn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWEGUn2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 16:43:28 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4085 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932221AbWEGUn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 16:43:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507204327.FTST9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 16:43:27 -0400
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <20060507145046.GA24882@peppar.cs.umu.se> (Peter Hagervall's
	message of "Sun, 7 May 2006 16:50:47 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19717>

Peter Hagervall <hager@cs.umu.se> writes:

> You gotta love sparse:
>
> builtin-diff.c:88:4: error: Just how const do you want this type to be?

LOL.

> -		const
> -			const unsigned char *tmp_u;
> +		const unsigned char *tmp_u;

I wondered how this bit snuck in, but it was like that
from the beginning, my bad.

Thanks.
