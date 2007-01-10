From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Wed, 10 Jan 2007 14:11:57 -0800
Message-ID: <7vy7oa8rbm.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 23:12:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4lg9-0007iv-NI
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 23:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXAJWMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 17:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbXAJWMP
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 17:12:15 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40400 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbXAJWMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 17:12:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110221213.CTPD97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 17:12:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9aBN1W00g1kojtg0000000; Wed, 10 Jan 2007 17:11:23 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 10 Jan 2007 11:28:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36533>

Junio C Hamano <junkio@cox.net> writes:

> This comes on top of yours.  
>
> I'm reproducing all the merges in linux-2.6 history to make sure
> the base one, yours and this produce the same result (the same
> clean merge, or the same unmerged index and the same diff from
> HEAD).  So far it is looking good.

Looks like this is good to go -- among the 2700+ merges I've
finished about 1000 of them and the results from the three
implementation exactly match.
