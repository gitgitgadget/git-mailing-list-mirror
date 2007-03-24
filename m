From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] Uncomment test case: git branch c/d should barf if branch c exists.
Date: Sat, 24 Mar 2007 06:34:52 +0100
Message-ID: <200703240634.52771.chriscool@tuxfamily.org>
References: <20070324063021.2520da21.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUym0-0000dx-6v
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbXCXF0h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Mar 2007 01:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbXCXF0h
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:26:37 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60834 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448AbXCXF0g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2007 01:26:36 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3B476B55E1;
	Sat, 24 Mar 2007 06:26:36 +0100 (CET)
User-Agent: KMail/1.9.5
In-Reply-To: <20070324063021.2520da21.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42983>

Oops, sorry this one is also an old mail that was in my Draft folder an=
d=20
should not have been sent...

Christian.

Le samedi 24 mars 2007 06:30, Christian Couder a =E9crit :
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t3210-pack-refs.sh |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index 2cc03e6..193fe1f 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -37,12 +37,12 @@ test_expect_success \
>       git-show-ref b >result &&
>       diff expect result'
>
> -# test_expect_failure \
> -#     'git branch c/d should barf if branch c exists' \
> -#     'git-branch c &&
> -#      git-pack-refs &&
> -#      rm .git/refs/heads/c &&
> -#      git-branch c/d'
> +test_expect_failure \
> +    'git branch c/d should barf if branch c exists' \
> +    'git-branch c &&
> +     git-pack-refs &&
> +     rm .git/refs/heads/c &&
> +     git-branch c/d'
>
>  test_expect_success \
>      'see if a branch still exists after git pack-refs --prune' \
