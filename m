From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] tutorial: Use "git remote add"
Date: Fri, 12 Jan 2007 10:29:58 -0800
Message-ID: <7vmz4ot7x5.fsf@assigned-by-dhcp.cox.net>
References: <87sleg31av.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 19:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5RAL-0000vQ-NP
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 19:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbXALSaB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 13:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbXALSaB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 13:30:01 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64686 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964843AbXALSaA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jan 2007 13:30:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112182959.UIKC18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 13:29:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AJV71W00h1kojtg0000000; Fri, 12 Jan 2007 13:29:08 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87sleg31av.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Fri, 12
	Jan 2007 12:57:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36689>

Santi B=E9jar <sbejar@gmail.com> writes:

> @@ -285,10 +285,12 @@ at /home/bob/myrepo.  She does this with:
> =20
>  ------------------------------------------------
>  $ cd /home/alice/project
> -$ git pull /home/bob/myrepo master
> +$ git remote add bob /home/bob/myrepo
> +$ git pull bob master
>  ------------------------------------------------

I'd prefer to leave this as is, because I think ad-hoc
promiscous pull shows the distributed nature of git better, and
add a new step after that to teach "remote add", telling the
user that "having to use longhand every time is tiresome, so
there is a nifty way to define a shorthand for a remote
repository you interact with often".

Other than that, I agree with the direction of your change to
use separate remote layout instead of mixed "incoming" branches.
