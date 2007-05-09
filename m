From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: config_boolean() -> config_bool()
Date: Wed, 09 May 2007 08:24:40 -0700
Message-ID: <7vfy66uiiv.fsf@assigned-by-dhcp.cox.net>
References: <20070427020601.22991.13792.stgit@rover>
	<7v7irxko81.fsf@assigned-by-dhcp.cox.net>
	<20070509104941.GK4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 09 17:24:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlo22-00025G-NE
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbXEIPYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbXEIPYm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:24:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58361 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXEIPYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:24:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509152441.OOIY22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 11:24:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x3Qg1W00M1kojtg0000000; Wed, 09 May 2007 11:24:40 -0400
In-Reply-To: <20070509104941.GK4489@pasky.or.cz> (Petr Baudis's message of
	"Wed, 9 May 2007 12:49:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46727>

Petr Baudis <pasky@suse.cz> writes:

> So, I realized that I'm not sure again how to stick a mail reply and new
> patch version in the same mail - originally I wanted to reply to this
> mail and send the patch as another reply, but that seemed wasteful. Now
> it seems that the only option is to stuff the mail reply in the diffstat
> area, but I refuse to do that since that's just plainly stupid.

That's your opinion to go against a convention, which is fine,
as long as you use something other than what begins with three
dashes here as a separator.

> ---
>
> This patch renames config_boolean() to config_bool() for consistency with
> the commandline interface and because it is shorter but still obvious. ;-)
> It also changes the return value from some obscure string to real Perl
> boolean, allowing for clean user code.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>
>  git-remote.perl     |    4 ++--
>  git-send-email.perl |    4 ++--
>  perl/Git.pm         |   14 +++++++++-----
>  3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/git-remote.perl b/git-remote.perl
> index 52013fe..5763799 100755
> --- a/git-remote.perl
> +++ b/git-remote.perl
> @@ -297,9 +297,9 @@ sub update_remote {
