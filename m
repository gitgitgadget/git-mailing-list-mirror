From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Fix a typo
Date: Wed, 04 Jul 2007 09:59:35 -0700
Message-ID: <7vwsxggl54.fsf@assigned-by-dhcp.cox.net>
References: <20070704162214.GA28542@prefect.vdbonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: CJ van den Berg <cj@vdbonline.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 18:59:47 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I68Cd-0005AM-6e
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 18:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbXGDQ7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 12:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbXGDQ7h
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 12:59:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61465 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbXGDQ7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 12:59:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704165936.NZML1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 12:59:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KUzb1X00A1kojtg0000000; Wed, 04 Jul 2007 12:59:35 -0400
In-Reply-To: <20070704162214.GA28542@prefect.vdbonline.net> (CJ van den Berg's
	message of "Wed, 4 Jul 2007 18:22:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51626>

CJ van den Berg <cj@vdbonline.com> writes:

> This typo breaks the output of git submodule status.
>
> ---
>  git-submodule.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 0ba0161..277fadc 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -234,7 +234,7 @@ modules_list()
>  			continue;
>  		fi
>  		revname=$(unset GIT_DIR && cd "$path" && git describe --tags $sha1)
> -		set_name_rev "$path" $"sha1"
> +		set_name_rev "$path" "$sha1"
>  		if git diff-files --quiet -- "$path"
>  		then
>  			say " $sha1 $path$revname"

Thanks.  There is another, probably from a cut-n-paste.
