From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 05 Aug 2006 02:28:31 -0700
Message-ID: <7vpsffedkw.fsf@assigned-by-dhcp.cox.net>
References: <20060805031418.GA11102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 11:28:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9ISS-0004ae-DD
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 11:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422803AbWHEJ2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 05:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWHEJ2d
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 05:28:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:29941 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422803AbWHEJ2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 05:28:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805092832.XZAB554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 05:28:32 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060805031418.GA11102@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Aug 2006 23:14:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24894>

Jeff King <peff@peff.net> writes:

> +    M ) color $1; echo "modified: $name"; uncolor $1;;
> +    D*) color $1; echo "deleted:  $name"; uncolor $1;;
> +    T ) color $1; echo "1change: $name"; uncolor $1;;

Is "1" a typo?

> +    C*) color $1; echo "copied: $name -> $newname"; uncolor $1;;
> +    R*) color $1; echo "renamed: $name -> $newname"; uncolor $1;;
> +    A*) color $1; echo "new file: $name"; uncolor $1;;
> +    U ) color $1; echo "unmerged: $name"; uncolor $1;;
> +    O ) color $1; echo "$name"; uncolor $1;;
