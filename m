From: Hermes Trismegisto <junkio@cox.net>
Subject: Re: [PATCH 0/5]
Date: Wed, 25 Apr 2007 12:04:32 -0700
Message-ID: <7vlkggxolb.fsf@assigned-by-dhcp.cox.net>
References: <1177437675887-git-send-email-lcapitulino@mandriva.com.br>
	<20070424175224.5afcf827@localhost>
	<7vhcr55w5w.fsf@assigned-by-dhcp.cox.net>
	<20070425110435.2d222979@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:04:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgmn7-0006jK-Fa
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992927AbXDYTEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992932AbXDYTEe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:04:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34144 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992927AbXDYTEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:04:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425190433.JAGR1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 15:04:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rX4Y1W00D1kojtg0000000; Wed, 25 Apr 2007 15:04:32 -0400
In-Reply-To: <20070425110435.2d222979@localhost> (Luiz Fernando
	N. Capitulino's message of "Wed, 25 Apr 2007 11:04:35 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45544>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

> Em Tue, 24 Apr 2007 13:56:11 -0700
> Junio C Hamano <junkio@cox.net> escreveu:
>
> | I suspect that you need to quote your human readable name, as it
> | has a full-stop in it ("N.").  Maybe git-send-email should be
> | taught about it.
>
>  It worked when I tested it sending the series to me and CC'ing
> my gmail address.

Hmmm.  Maybe vger and my ISP have stricter filter based on set
of addresses that appear on To/Cc lines than the way you receive
mails?

In git-send-email, I notice that $author_name address on From:
line is quoted in dq pairs (in sub send_message) but none of the
addresses in @cc taken from the Signed-off-by lines are not
inspected nor quoted.  I do not know what is being done to To:
recipients offhand and I am too lazy to check.

>  Will send this series by hand and figure out a better way to
> do this...

Thanks.  They look reasonable, at least from my cursory look.
