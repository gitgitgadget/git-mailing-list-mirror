From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 0/3] Split fetch and merge logic
Date: Fri, 16 Feb 2007 12:10:34 -0800
Message-ID: <7vd54950ed.fsf@assigned-by-dhcp.cox.net>
References: <874ppmplw7.fsf@gmail.com>
	<7vwt2i7bq7.fsf@assigned-by-dhcp.cox.net>
	<8aa486160702160040t3f42b5a0xbd12f333805ad4d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 21:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI9Pu-0005rK-Tn
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 21:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946106AbXBPUKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 15:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946107AbXBPUKg
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 15:10:36 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36665 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946106AbXBPUKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Feb 2007 15:10:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216201036.EETY21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 15:10:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QLAa1W00y1kojtg0000000; Fri, 16 Feb 2007 15:10:35 -0500
In-Reply-To: <8aa486160702160040t3f42b5a0xbd12f333805ad4d7@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Fri, 16 Feb 2007 09:40:51
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39946>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> In the past we've had problems when we have changed the merge logic
> (as shows 4363dfbe3). This patch makes the two process completely
> independent, and concentrate the merge logic in one place (leaving
> git-parse-remote.sh independent of the merge logic).

But that is a solved problem, isn't it?  What else does it
solve?  The justification for moving around the logic could be
something like "these three patches do not do that themselves,
but it opens a door for further work such as ...", but without
something concrete in "..." part, your response makes the patch
look mostly needless code churn.

I was hoping to hear something like "now git-fetch has to do
much less than before, eventual C-rewrite of the command, which
can borrow some code already written for 'pu' branch, will
become much easier" ;-).
