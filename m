From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update git-annotate/git-blame documentation
Date: Mon, 16 Apr 2007 00:52:04 -0700
Message-ID: <7vtzvgvjrv.fsf@assigned-by-dhcp.cox.net>
References: <20070416053525.GA18821@localdomain>
	<20070416062034.GC19759@localdomain>
	<81b0412b0704160024i4c202efey5eb54d382d003bbd@mail.gmail.com>
	<20070416072623.GB20240@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdM0V-0007Cv-MW
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbXDPHwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbXDPHwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:52:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44476 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469AbXDPHwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:52:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416075206.TSBO1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 03:52:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id njs41W00C1kojtg0000000; Mon, 16 Apr 2007 03:52:05 -0400
In-Reply-To: <20070416072623.GB20240@localdomain> (Andrew Ruder's message of
	"Mon, 16 Apr 2007 02:26:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44608>

Andrew Ruder <andy@aeruder.net> writes:

> On Mon, Apr 16, 2007 at 09:24:08AM +0200, Alex Riesen wrote:
>> On 4/16/07, Andrew Ruder <andy@aeruder.net> wrote:
>> >+-L n,m::
>> >+       Annotate only the specified line range (lines count from 1).
>> >+
>> >+-l::
>> >+       Show long rev (Default: off).
>> >+
>> >+-t::
>> >+       Show raw timestamp (Default: off).
>> 
>> Very nice, mentioning this small details. Thanks!
>
> Those particular items I didn't write, so I'm going to bounce that
> thanks off to whoever did. :)

I almost never give line numbers to -L, by the way.

	$ git log --grep=-L -- builtin-blame.c builtin-pickaxe.c

would give enough raw material to update the section with.
