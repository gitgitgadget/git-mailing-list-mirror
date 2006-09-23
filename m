From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Fetch: get the remote branches to merge from the branch properties
Date: Sat, 23 Sep 2006 03:43:35 -0700
Message-ID: <7vfyeiualk.fsf@assigned-by-dhcp.cox.net>
References: <87venex5je.fsf@gmail.com> <877izux5d2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 12:43:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR4yy-0002HY-ML
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 12:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWIWKng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 06:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWIWKng
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 06:43:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16787 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750733AbWIWKng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 06:43:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923104335.ROBQ6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 06:43:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rmjd1V00A1kojtg0000000
	Sat, 23 Sep 2006 06:43:37 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27580>

Santi B=E9jar <sbejar@gmail.com> writes:

> If in branch "foo" and this in config:
>
> [branch "foo"]
>       merge=3Dbar
>
> "git fetch": fetch from the default repository and program the "bar"
>              branch to be merged with pull.
>
> Signed-off-by: Santi B=E9jar <sbejar@gmail.com>

This still breaks t5700 test the same way as the earlier one.
