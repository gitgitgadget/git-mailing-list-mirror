From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Sun, 15 Apr 2007 23:01:54 -0700
Message-ID: <7vodlox3fx.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
	<20070416055111.GC23255@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:02:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKI6-00023I-4g
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbXDPGB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbXDPGB4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:01:56 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55267 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbXDPGB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:01:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416060155.SPEY1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 02:01:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ni1v1W0031kojtg0000000; Mon, 16 Apr 2007 02:01:55 -0400
In-Reply-To: <20070416055111.GC23255@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 16 Apr 2007 08:51:11 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44584>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Display the subject of the commit just made.
>
> Useful e.g. to figure out what I did from screen history,
> or to make sure subject line is short enough and makes sense
> on its own.
>
> Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>
>
> ---
>
>> Quoting Junio C Hamano <junkio@cox.net>:
>> Close but no cigar.  You broke it for a merge commit, I think.
>> 
>> Perhaps
>> 
>> 	pretty="format:Created${initial_commit:+ initial} commit %h: %s%n"
>> 	git-diff-tree --always --shortstart --summary --root --pretty="$pretty" HEAD
>
> OK, thanks fo rpointing this out.
> But why the extra %n at the end?

Because I *got* *rid* *of* "echo".
