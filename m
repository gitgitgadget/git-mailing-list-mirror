From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile to 1.0?
Date: Sun, 17 Jul 2005 22:35:46 -0700
Message-ID: <7vfyucfzgt.fsf@assigned-by-dhcp.cox.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
	<200507180853.41633.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 07:36:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuOIU-0001vT-MY
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 07:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVGRFfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 01:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVGRFfv
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 01:35:51 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53947 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261516AbVGRFft (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 01:35:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718053547.KBKR7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 01:35:47 -0400
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200507180853.41633.snake@penza-gsm.ru> (Alexey Nezhdanov's message of "Mon, 18 Jul 2005 08:53:41 +0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alexey Nezhdanov <snake@penza-gsm.ru> writes:

> I'd add the UTF-8 native support. Currently neither commit nor gitk doesn't 
> support that. Probably this should be done at as low as possible level.

I do not understand your proposal.  Care to clarify?  You can
write your commit messages in UTF-8 today and "git-cat-file
commit $commit_ID", which is as low level as you can go, gives
you that commit message in UTF-8.
