From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to commit removed file?
Date: Tue, 02 Jan 2007 23:14:03 -0800
Message-ID: <7vwt44pop0.fsf@assigned-by-dhcp.cox.net>
References: <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
	<20070103060640.GD20259@mellanox.co.il>
	<7vhcv8r4ac.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 08:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H20KF-0005ly-U4
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 08:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbXACHOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 02:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbXACHOL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 02:14:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47564 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbXACHOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 02:14:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103071410.DYQW29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 02:14:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6XEP1W00N1kojtg0000000; Wed, 03 Jan 2007 02:14:24 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <7vhcv8r4ac.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 02 Jan 2007 22:51:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35848>

Junio C Hamano <junkio@cox.net> writes:

> ...  That's a
> great news.
>
> I am not interested to make it "all" myself -- if somebody else
> does it, that is fine, though ;-).

Just in case you do not know me, sorry for too much negative
tone in my message.  I was just venting. It was not like I was
offended by something you said or anything like that.

The "commit path..." feature, while I would even agree that it
sometimes is useful in simple cases, is something that goes
quite against what git does normally, and anybody would
understand why after inspecting what git-commit has to do to
implement that.  I personally hate that "feature".

Having said that, I am known to support features that I do not
agree with myself for other people, and sometimes even implement
them myself.  But that does not mean I have to like them ;-).
