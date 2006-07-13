From: Junio C Hamano <junkio@cox.net>
Subject: Re: when is "git diff" output suitable for patch?
Date: Thu, 13 Jul 2006 14:51:20 -0700
Message-ID: <7v3bd5uqav.fsf@assigned-by-dhcp.cox.net>
References: <20060713212127.GA30770@fieldses.org>
	<7vhd1lurei.fsf@assigned-by-dhcp.cox.net>
	<20060713213116.GK19366@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 23:51:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G195i-0002uN-8G
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWGMVvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWGMVvX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:51:23 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64941 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030416AbWGMVvW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:51:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713215122.GZHY22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 17:51:22 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060713213116.GK19366@fieldses.org> (J. Bruce Fields's message
	of "Thu, 13 Jul 2006 17:31:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23857>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> As far as I recall "git diff" never defaulted to -M.
>
> Hm.  Is this related?:
>
> commit 42efbf6d8a5b4902c55a2f6e96034625c056ba1f
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Sat Mar 11 17:44:10 2006 -0800
>
>     git-diff: -p disables rename detection.

Ah, sorry, it _did_ default to -M; it was in such an ancient
past and the shell wrapper wasn't initially done by me, so I
misremembered.
