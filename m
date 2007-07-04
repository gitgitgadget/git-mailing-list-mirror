From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Usability of git-update-ref <headname>
Date: Tue, 03 Jul 2007 21:12:56 -0700
Message-ID: <7vtzskq01j.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90707031908x3fb2eb59ob0a57a33777363fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 06:13:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5wEw-0002Uu-Pw
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 06:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXGDENF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 00:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbXGDENE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 00:13:04 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46270 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXGDEND (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 00:13:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704041257.ZETJ11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 00:12:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KGCw1X00C1kojtg0000000; Wed, 04 Jul 2007 00:12:56 -0400
In-Reply-To: <46a038f90707031908x3fb2eb59ob0a57a33777363fb@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 4 Jul 2007 14:08:46 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51559>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Am I using the wrong command? I'd be happy to remove the bogus head
> and create a new one, but I don't think we have git-rm-ref.

Yes you are.  Forget about update-ref.  That is strictly for
script consumption.

>  # I think I'm on master, but I'm acually on maint
>  git-branch foo-feature
>  git-checkout foo-feature
>
>  # realise I've branched in the wrong place

   $ git reset --soft master
