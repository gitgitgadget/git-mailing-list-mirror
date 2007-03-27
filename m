From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Tue, 27 Mar 2007 00:22:56 -0700
Message-ID: <7vps6vqhf3.fsf@assigned-by-dhcp.cox.net>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org>
	<7vzm5zs1aq.fsf@assigned-by-dhcp.cox.net>
	<200703270915.12408.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 09:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW61Y-0006yq-Md
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 09:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbXC0HW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 03:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbXC0HW6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 03:22:58 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60858 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312AbXC0HW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 03:22:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327072256.VYUZ748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 03:22:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fjNw1W00J1kojtg0000000; Tue, 27 Mar 2007 03:22:57 -0400
In-Reply-To: <200703270915.12408.chriscool@tuxfamily.org> (Christian Couder's
	message of "Tue, 27 Mar 2007 09:15:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43239>

Christian Couder <chriscool@tuxfamily.org> writes:

> Without the first "test -d blah", if "bisect start" was not already used, 
> then the user will only see :
>
> 'You need to give me at least one good and one bad revisions.'
>
> And then when using "git bisect good" or "git bisect bad" to give good or 
> bad revision:
>
> 'You need to start by "git bisect start"
> Do you want me to do it for you [Y/n]?'

Doesn't that suggest the existing messages from "git bisect good/bad"
can use the same improvement you added only to "bisect run"?
