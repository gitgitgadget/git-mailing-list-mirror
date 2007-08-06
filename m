From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Mon, 06 Aug 2007 13:34:17 -0700
Message-ID: <7vodhkbdx2.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	 =?ISO-8859-1?Q?=20<AF1190=04E2-A0F4-?= =?ISO-8859-1?Q?479F-B0A1-50B2C7?= =?ISO-8859-1?Q?278995?=
	=?ISO-8859-1?Q?@yahoo.ca>?=
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
	 =?ISO-8859-1?Q?=20<Pine=04.LNX.4.64.?= =?ISO-8859-1?Q?0708031121000.14?= =?ISO-8859-1?Q?781@ra?=
	=?ISO-8859-1?Q?cer.site>?=
	<7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
	<86bqdkbq59.fsf@lola.quinscape.zz> <vpqr6mgwhsf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II9HU-000692-L0
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 22:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbXHFUeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 16:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760402AbXHFUeU
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 16:34:20 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43149 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbXHFUeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 16:34:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806203418.KYDF7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 16:34:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YkaJ1X0011kojtg0000000; Mon, 06 Aug 2007 16:34:18 -0400
In-Reply-To: <vpqr6mgwhsf.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	06 Aug 2007 22:05:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55171>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Unfortunately, the patch solves the "large and irrelevant output" of
> git-diff, but not the performance problem (see the rest of the thread,
> I failed to convince Junio that updating the index was a performance
> improvement while keeping the same user semantics).

That's what update-index --refresh (or status if you insist) are
for, and the coalmine canary you are so dead set to kill are
helping you realize the need for running.
