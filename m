From: Junio C Hamano <junkio@cox.net>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 16:39:37 -0700
Message-ID: <7vvf5dqxfq.fsf@assigned-by-dhcp.cox.net>
References: <428E5102.60003@pobox.com>
	<7vacmpsetb.fsf@assigned-by-dhcp.cox.net> <428E73B9.1080907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:39:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZH5H-00051A-Eo
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVETXjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVETXjz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:39:55 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:29105 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261603AbVETXjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 19:39:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520233939.JEZI8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 19:39:39 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <428E73B9.1080907@pobox.com> (Jeff Garzik's message of "Fri, 20
 May 2005 19:33:13 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> git-checkout-cache -f writes out every file, even if it exists, correct?

No, that's not correct.  To translate my prose, you would want
this:

    git-read-tree -m HEAD && git-checkout-cache -q -f -u -a

(notice that I do not have git-update-cache --refresh after
that).




