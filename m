From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] core.legacyheaders: Use the description used in RelNotes-1.5.0
Date: Fri, 23 Feb 2007 10:44:22 -0800
Message-ID: <7vwt283e9l.fsf@assigned-by-dhcp.cox.net>
References: <87d540oo80.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 23 19:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKfPG-0002xP-2U
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 19:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbXBWSoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Feb 2007 13:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbXBWSoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 13:44:25 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49716 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481AbXBWSoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Feb 2007 13:44:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223184424.FNWI2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 13:44:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id T6kQ1W0031kojtg0000000; Fri, 23 Feb 2007 13:44:24 -0500
In-Reply-To: <87d540oo80.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 23
	Feb 2007 17:03:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40463>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> +	A boolean which
> +	changes the format of loose objects so that they are more
> +	efficient to pack and to send out of the repository over git
> +	native protocol, since v1.4.2.  However, loose objects
> +	written in the new format cannot be read by git older than
> +	that version; people fetching from your repository using
> +	older clients over dumb transports (e.g. http) using older
> +	versions of git will also be affected.

Much better than the original but "using older clients" and
"using older versions of git" sounds duplicated.

> ++
> +To let git use the new loose object format, you have to
> +set core.legacyheaders to false.
> =20
>  core.packedGitWindowSize::
>  	Number of bytes of a pack file to map into memory in a
> --=20
> 1.5.0.1.576.g78541
