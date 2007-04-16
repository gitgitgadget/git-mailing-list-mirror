From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Sun, 15 Apr 2007 23:04:02 -0700
Message-ID: <7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
	<20070416053435.GA23255@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKJs-0002c0-71
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbXDPGEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbXDPGEF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:04:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:32897 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbXDPGEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:04:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416060403.SEWE1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 02:04:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ni431W0041kojtg0000000; Mon, 16 Apr 2007 02:04:03 -0400
In-Reply-To: <20070416053435.GA23255@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 16 Apr 2007 08:34:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44585>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Quoting Junio C Hamano <junkio@cox.net>:
>> Subject: Re: [PATCH] display shortlog after git-commit
>> 
>> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
>> 
>> > Display the subject of the commit just made.
>> 
>> WHY?  You just made the commit.
>
> BTW, Junio, why does git-commit need to display the diffstat?
> You just made the commit ...

Don't ask me.  It was not my idea.

We only had --summary per popular list request, and it made
certain amount of sense since addition/deletion are notable
events that do not happen with _every_ commit.
