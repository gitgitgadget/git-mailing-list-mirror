From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 7/25] git-count-objects: Die with usage message if we are invoked incorrectly.
Date: Sat, 10 Dec 2005 20:22:12 -0800
Message-ID: <7v1x0kuutn.fsf@assigned-by-dhcp.cox.net>
References: <1134243476675-git-send-email-freku045@student.liu.se>
	<11342434772549-git-send-email-freku045@student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 05:23:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElIjg-00039j-BD
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 05:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbVLKEWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 23:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVLKEWO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 23:22:14 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47258 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751325AbVLKEWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 23:22:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211042023.GNYH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Dec 2005 23:20:23 -0500
To: freku045@student.liu.se
In-Reply-To: <11342434772549-git-send-email-freku045@student.liu.se>
	(freku045@student.liu.se's message of "Sat, 10 Dec 2005 20:37:57
	+0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13482>

freku045@student.liu.se writes:

> 5db708396a841860c4d5e41c2acd60476d2207c4
> diff --git a/git-count-objects.sh b/git-count-objects.sh
> index 40c58ef..0d544ad 100755
> --- a/git-count-objects.sh
> +++ b/git-count-objects.sh
> @@ -3,7 +3,16 @@
>  # Copyright (c) 2005 Junio C Hamano
>  #
>  
> -GIT_DIR=`git-rev-parse --git-dir` || exit $?
> +. git-sh-setup

Not that it matters too much, but this makes count-object not
work from subdirectory.
