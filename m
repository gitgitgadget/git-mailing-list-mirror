From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect-helper: fix grammatical typo in exit_if_skipped_commits()
Date: Wed, 22 Apr 2009 07:01:13 +0200
Message-ID: <200904220701.13852.chriscool@tuxfamily.org>
References: <1240295512-22651-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 07:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwUcz-00069o-WC
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 07:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbZDVFCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 01:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZDVFCe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 01:02:34 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34134 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbZDVFCe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 01:02:34 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1ED1F818040;
	Wed, 22 Apr 2009 07:02:26 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 39243818050;
	Wed, 22 Apr 2009 07:02:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1240295512-22651-1-git-send-email-bebarino@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117172>

Le mardi 21 avril 2009, Stephen Boyd a =E9crit :
> This is against pu.
>
>  bisect.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index f6e1378..5902e83 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -575,7 +575,7 @@ static void exit_if_skipped_commits(struct
> commit_list *tried, if (!tried)
>  		return;
>
> -	printf("There are only 'skip'ped commit left to test.\n"
> +	printf("There are only 'skip'ped commits left to test.\n"
>  	       "The first bad commit could be any of:\n");
>  	print_commit_list(tried, "%s\n", "%s\n");
>  	if (bad)

Acked-by: Christian Couder <chriscool@tuxfamily.org>

Thanks,
Christian.
