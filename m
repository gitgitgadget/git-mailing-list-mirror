From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list bug?
Date: Wed, 08 Mar 2006 12:16:32 -0800
Message-ID: <7vacc0iten.fsf@assigned-by-dhcp.cox.net>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 21:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH55K-0004aF-Js
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 21:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWCHUQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 15:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWCHUQf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 15:16:35 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11687 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932572AbWCHUQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 15:16:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060308201448.LHMF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Mar 2006 15:14:48 -0500
To: "Catalin Marinas" <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0603080819i227c637fo@mail.gmail.com> (Catalin Marinas's
	message of "Wed, 8 Mar 2006 16:19:48 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17385>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> Sorry if this was previously discussed. I ran git-rev-list on a linear
> graph and tried to filter the results by a file name:
>
>   git rev-list since.. path/to/file
>
> but it always shows the child commit of "since" even if it didn't
> touch the file. The same behaviour is for git-log (since it uses
> git-rev-list) but git-whatchanged seems to be fine.
>
> Is this the intended behaviour? The "stg patches" command based on
> git-rev-list used to work fine a few weeks ago but now it is always
> reporting the bottom patch in the stack as modifying a given file.

I can confirm that this is a recent breakage, but since it is
unfortunately my day-job day the more detailed analysis and fix
needs to wait.  Sorry.
