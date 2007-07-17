From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document "git stash message..."
Date: Tue, 17 Jul 2007 01:50:49 -0700
Message-ID: <7vps2r9zx2.fsf@assigned-by-dhcp.cox.net>
References: <20070624192215.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 10:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAim4-0008AI-Qx
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 10:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760519AbXGQIux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbXGQIuv
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 04:50:51 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53937 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763641AbXGQIuu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 04:50:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070717085050.ZMDT1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 04:50:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QYqp1X00G1kojtg0000000; Tue, 17 Jul 2007 04:50:50 -0400
In-Reply-To: <20070624192215.6117@nanako3.bluebottle.com>
	(nanako3@bluebottle.com's message of "Tue, 17 Jul 2007 17:15:42
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52750>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> The command was recently updated to take message on the command line,=
 but
> this feature has not been documented.
>
> Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>

Thanks -- that was my fault.

>  Documentation/git-stash.txt |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.tx=
t
> index ad95ed9..4404361 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -22,7 +23,9 @@ The modifications stashed away by this command can =
be listed with
>  `git-stash list`, inspected with `git-stash show`, and restored
>  (potentially on top of a different commit) with `git-stash apply`.
>  Calling git-stash without any arguments is equivalent to `git-stash
> -save`.
> +save`.  A stash is by default listed as "WIP on 'branchname' ...", b=
ut
> +you can give more descriptive message on the command line when
> +you create one.

Perhaps "give a more descriptive message"?
