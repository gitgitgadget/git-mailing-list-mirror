From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv2] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Sun, 04 Mar 2007 15:30:28 -0800
Message-ID: <7v8xec4mej.fsf@assigned-by-dhcp.cox.net>
References: <87ps7oslwk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO09x-0001kX-Gg
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 00:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXCDXaa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Mar 2007 18:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXCDXaa
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 18:30:30 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63309 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbXCDXaa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2007 18:30:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304233029.DIFA2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Mar 2007 18:30:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WnWU1W00U1kojtg0000000; Sun, 04 Mar 2007 18:30:29 -0500
In-Reply-To: <87ps7oslwk.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Sun, 04
	Mar 2007 23:07:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41388>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
> ---
>  Hi *,
>
>    it is a much reduced version (63 instead of 400 tests) but contain=
s
>  also tests for the fetched tags (missing anything else?).
>  I think it is suitable to be included.

Thanks.

One thing I found lacking from the last round was that the test
stripped the origin information later used by git-fmt-merge-msg
(which made the test not very helpful when I tried to use it
while working on the partial rewrite of git-fetch you see in the
'next' branch).  I haven't checked your patch this round yet,
but it would be nice to check for that to catch regressions.
