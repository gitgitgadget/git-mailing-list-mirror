From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Thu, 02 Aug 2007 23:30:51 -0700
Message-ID: <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGqga-0008Hz-Kl
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbXHCGay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbXHCGay
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:30:54 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34136 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515AbXHCGax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 02:30:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803063053.DQCZ11888.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Aug 2007 02:30:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XJWs1X0071kojtg0000000; Fri, 03 Aug 2007 02:30:53 -0400
In-Reply-To: <20070803053717.GA16379@midwinter.com> (Steven Grimm's message of
	"Thu, 2 Aug 2007 22:37:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54676>

Steven Grimm <koreth@midwinter.com> writes:

> 	Okay, enough arguing about whether the empty diff lines are
> 	useful or not -- here's a patch to get rid of them.

I do not think this addresses anything but -p (i.e. textual
diff) output.  If we _were_ to really do this, I think the patch
I sent earlier today, with possible improvements I suggested,
would be a better direction to go.
