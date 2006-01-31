From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvs-migration documentation update
Date: Mon, 30 Jan 2006 19:18:17 -0800
Message-ID: <7virs13x1i.fsf@assigned-by-dhcp.cox.net>
References: <20060129043147.GA9581@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 04:18:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3m2E-00053j-CJ
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 04:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWAaDSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 22:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWAaDSX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 22:18:23 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44792 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030283AbWAaDSW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 22:18:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131031606.KHGA17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 Jan 2006 22:16:06 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060129043147.GA9581@fieldses.org> (J. Bruce Fields's message
	of "Sat, 28 Jan 2006 23:31:47 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15298>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Here's some changes to the cvs-migration.txt.  As usual, in my attempt
> to make things clearer someone may have found I've made them less so, or
> I may have just gotten something wrong; so any review is welcomed.

Again, thanks for doing this.

> I moved the material describing shared repository management from
> core-tutorial.txt to cvs-migration.txt, where it seems more appropriate,
> and combined two sections to eliminate some redundancy.

Seems sensible.

> diff --git a/Documentation/cvs-migration.txt...
> index 8fd1a33..2bd58d3 100644
> --- a/Documentation/cvs-migration.txt
> +++ b/Documentation/cvs-migration.txt
> @@ -1,126 +1,182 @@
>  git for CVS users
>  =================
>  
> -..., and the
> -first step to recovery is admitting you have a problem. The fact that
> -you are reading this file means that you may be well on that path
> -already.
> -
> -The thing about CVS is that it absolutely sucks...
> -
> -One particular suckage of CVS is very hard to work around: CVS is...

Somehow I miss the above two paragraphs and a half ;-).
But listing the differences as bullet points as you did makes
things much clearer.  I like it.

> +------------------------------------------------
> +$ git push origin master
> +------------------------------------------------
> +
> +If some else has updated the repository more recently, `git push`, like

some else?
