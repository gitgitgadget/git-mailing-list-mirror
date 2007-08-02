From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit.sh: Permit the --amend message to be given with -m/-c/-C/-F.
Date: Wed, 01 Aug 2007 18:03:16 -0700
Message-ID: <7vd4y63fzf.fsf@assigned-by-dhcp.cox.net>
References: <86643znxgz.fsf@lola.quinscape.zz>
	<7v8x8v5g2z.fsf@assigned-by-dhcp.cox.net>
	<85myxbrrdl.fsf@lola.goethe.zz>
	<7vk5sf3uct.fsf@assigned-by-dhcp.cox.net>
	<857iofrnkj.fsf@lola.goethe.zz> <85zm1bq8um.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 03:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGP61-0003Gg-FX
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 03:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbXHBBDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 21:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbXHBBDT
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 21:03:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58946 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbXHBBDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 21:03:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802010318.CKCZ1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 21:03:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wp3H1X00M1kojtg0000000; Wed, 01 Aug 2007 21:03:17 -0400
In-Reply-To: <85zm1bq8um.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	1 Aug 2007 22:33:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54509>

David Kastrup <dak@gnu.org> writes:

> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>  git-commit.sh |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/git-commit.sh b/git-commit.sh
> index 4290ae2..d7e7028 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -190,7 +190,6 @@ $1"
>  		;;
>  	--a|--am|--ame|--amen|--amend)
>  		amend=t
> -		log_given=t$log_given
>  		use_commit=HEAD
>  		shift
>  		;;
> @@ -298,9 +297,9 @@ esac
>  
>  case "$log_given" in
>  tt*)
> -	die "Only one of -c/-C/-F/--amend can be used." ;;
> +	die "Only one of -c/-C/-F can be used." ;;
>  *tm*|*mt*)
> -	die "Option -m cannot be combined with -c/-C/-F/--amend." ;;
> +	die "Option -m cannot be combined with -c/-C/-F." ;;
>  esac
>  
>  case "$#,$also,$only,$amend" in

Ok, looks obviously correct.  Wasn't too painful, was it?

Thanks, will apply.
