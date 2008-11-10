From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH 2/2] Document "git log --simplify-by-decoration"
Date: Mon, 10 Nov 2008 11:47:44 +0100
Message-ID: <adf1fd3d0811100247n18d54644h9a0238832d22be7c@mail.gmail.com>
References: <20081110185817.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Nanako Shiraishi" <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzUKM-0007oG-J0
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbYKJKrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 05:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbYKJKrq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 05:47:46 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:9078 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYKJKrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 05:47:46 -0500
Received: by ey-out-2122.google.com with SMTP id 6so889279eyi.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 02:47:44 -0800 (PST)
Received: by 10.103.244.4 with SMTP id w4mr3594600mur.11.1226314064063;
        Mon, 10 Nov 2008 02:47:44 -0800 (PST)
Received: by 10.103.165.1 with HTTP; Mon, 10 Nov 2008 02:47:44 -0800 (PST)
In-Reply-To: <20081110185817.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100513>

On Mon, Nov 10, 2008 at 10:58 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>  Documentation/rev-list-options.txt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 966276b..977290c 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -456,6 +456,13 @@ Note the major differences in `N` and `P` over '\--full-history':
>   removed completely, because it had one parent and is TREESAME.
>  --
>
> +The '\--simplify-by-decoration' option can be used to treat commits that
> +are not referenced by tags as TREESAME, and treat commits that are tagged
> +as !TREESAME (even when they have exactly the same tree as their parents).
> +This can be used when you are only interested in the big picture of the
> +topology of the history.
> +
> +

I prefer the other way around, first what it does, and then how it
does it (but it is a general comment about the help in "History
Simplification", at least when viewing the help for "git log"). And
you should rewrite the line 416:

Finally, there is a fourth simplification mode available

as it is no longer "Finally".

Santi
