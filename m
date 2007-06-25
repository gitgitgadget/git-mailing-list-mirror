From: Junio C Hamano <gitster@pobox.com>
Subject: Re: most commonly used git commands?
Date: Mon, 25 Jun 2007 00:48:01 -0700
Message-ID: <7vodj41nm6.fsf@assigned-by-dhcp.pobox.com>
References: <20070625064017.GA2839@mellanox.co.il>
	<7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
	<20070625071752.GB15343@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:48:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jIu-0004YD-5X
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbXFYHsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXFYHsF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:48:05 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34156 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbXFYHsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:48:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625074801.WVNA17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 03:48:01 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fjo11X0051kojtg0000000; Mon, 25 Jun 2007 03:48:02 -0400
In-Reply-To: <20070625071752.GB15343@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 25 Jun 2007 10:17:52 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50874>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Quoting Junio C Hamano <gitster@pobox.com>:
>> Perhaps they are most commonly used by the person who came up
>> with that list first ;-)?
>> 
>> I think "add" deserves to be there, I am not sure "apply" is.
>
> git add is supposed to be rare, no?
> That's why git commit lists file additions/removals ...

No.  You are talking in terms of pre-1.5 git.  The semantics of
"git add" has been clarified since then --- it adds contents,
and is not about telling git that there are new files it did not
know so far.
