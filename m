From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Wed, 27 Jul 2005 14:50:55 -0700
Message-ID: <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
References: <20050727083910.GG19290@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 23:56:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxtsX-0001FY-Cp
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 23:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVG0VzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVG0VxG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 17:53:06 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37593 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261173AbVG0Vu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 17:50:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050727215048.LDC8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Jul 2005 17:50:48 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050727083910.GG19290@mythryan2.michonline.com> (Ryan Anderson's message of "Wed, 27 Jul 2005 04:39:10 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> 003afd3ed1f83b4533b628182fa16c9ab0dc0467
> diff --git a/Documentation/Makefile.inc b/Documentation/Makefile.inc
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/Makefile.inc
> @@ -0,0 +1,50 @@
> +MAN1_TXT=$(wildcard Documentation/git-*.txt)
> +MAN7_TXT=Documentation/git.txt
> +
>...

While I do not have strong objections to make the build process
go faster, it is somewhat disturbing that the Makefile pieces
maintained in subdirectories need to name things they touch
using paths that include the subdirectory names.  I do not have
a better alternative to suggest, though...

I'd keep it in the proposed updates branch for now and wait for
a bit until discussions on the list die out.
