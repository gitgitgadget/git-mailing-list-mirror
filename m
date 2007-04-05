From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: bisect: "start" accepts one bad and many good commits
Date: Wed, 04 Apr 2007 21:55:23 -0700
Message-ID: <7vejmzxvwk.fsf@assigned-by-dhcp.cox.net>
References: <20070405053353.f4cebf57.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 06:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZK0O-0005rP-4x
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 06:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbXDEEzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 00:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbXDEEzZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 00:55:25 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42750 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161152AbXDEEzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 00:55:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405045524.ZNXE25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 00:55:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jGvP1W00E1kojtg0000000; Thu, 05 Apr 2007 00:55:23 -0400
In-Reply-To: <20070405053353.f4cebf57.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 5 Apr 2007 05:33:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43792>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Thanks.

> +If you know beforehand more than one good commits, you can narrow the
> +bisect space down without doing the whole tree checkout every time you
> +give good commits. You give the bad revision immediately after `start`
> +and then you give all the good revisions you have:
> +
> +------------
> +$ git bisect start v2.6.20-rc6 v2.6.20-rc4 v2.6.20-rc1 --
> +                   # v2.6.20-rc6 is bad
> +                   # v2.6.20-rc4 and v2.6.20-rc1 are good
>  ------------

We would probably want mnemonic to help people remember the
order of parameters: Bad comes before Good, simply because B
sorts earlier than G.
