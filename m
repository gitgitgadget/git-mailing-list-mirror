From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 00:00:36 -0700
Message-ID: <7v647wx0q3.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
	<20070416055111.GC23255@mellanox.co.il>
	<7vodlox3fx.fsf@assigned-by-dhcp.cox.net>
	<20070416061813.GD23255@mellanox.co.il>
	<20070416065119.GF23255@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdLCa-00055y-Jh
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbXDPHAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXDPHAh
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:00:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59179 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbXDPHAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:00:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416070037.RXAA1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 03:00:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nj0c1W0021kojtg0000000; Mon, 16 Apr 2007 03:00:36 -0400
In-Reply-To: <20070416065119.GF23255@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 16 Apr 2007 09:51:19 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44598>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Quoting Michael S. Tsirkin <mst@dev.mellanox.co.il>:
>> > Because I *got* *rid* *of* "echo".
>> 
>> so I think we are stuck with echo.
>
> So ... is it good to go?

I am not quite convinced that giving a short summary is
necessary yet, probably for the same reason you questioned why
we do --shortstat.
