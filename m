From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 18:54:34 -0700
Message-ID: <7vlkpqahlx.fsf@assigned-by-dhcp.cox.net>
References: <7vsljyajxj.fsf@assigned-by-dhcp.cox.net>
	<BAY110-F2347BACD15C6BACC34E839B84F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 03:55:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCo9D-00072K-9x
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 03:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWHOByg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 21:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWHOByg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 21:54:36 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:1423 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751400AbWHOByg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 21:54:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815015435.OLJS18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 21:54:35 -0400
To: "trajce nedev" <trajcenedev@hotmail.com>
In-Reply-To: <BAY110-F2347BACD15C6BACC34E839B84F0@phx.gbl> (trajce nedev's
	message of "Mon, 14 Aug 2006 18:40:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25435>

"trajce nedev" <trajcenedev@hotmail.com> writes:

> So you're just going to continue passing numbers around in the hope
> that someday they'll be used for something?
>
> Trajce Nedev

It is more like "fearing someday we might modify the callees and
they may start returning error codes".

Admittedly, "someday" has a tendency not to come, but making the
callees void and changing the callers who are already checking
the error codes to ignore what are returned from them somehow
feel backwards and pushing that someday further into the future.

Either patches to implement the error checking in the callees,
or arguments that particular callees the series touch do not
have reasonably graceful error return path are welcome (the
former advocating against and the latter advocating for the
application of the patch).  
