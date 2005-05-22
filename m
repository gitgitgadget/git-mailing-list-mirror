From: Junio C Hamano <junkio@cox.net>
Subject: Re: How stop tracking a file?
Date: Sun, 22 May 2005 10:10:20 -0700
Message-ID: <7vacmnfapv.fsf@assigned-by-dhcp.cox.net>
References: <4290B7FB.5070708@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 19:09:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZtx0-0000bi-NW
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVEVRK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVEVRK1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:10:27 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42158 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261836AbVEVRKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 13:10:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522171019.URGU7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 13:10:19 -0400
To: jeff millar <wa1hco@adelphia.net>
In-Reply-To: <4290B7FB.5070708@adelphia.net> (jeff millar's message of "Sun,
 22 May 2005 12:48:59 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "jm" == jeff millar <wa1hco@adelphia.net> writes:

    jm> cg-rm does two things
    jm>    rm -f "$@"
    jm>    git-update-cache --remove -- "$@"

I do not do Porcelain, but something along the following lines
should work:

    for path
    do
        git-update-cache --force-remove "$path"
    done


