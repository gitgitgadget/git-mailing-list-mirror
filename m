From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix some doubled word typos
Date: Sun, 09 Jul 2006 19:04:43 -0700
Message-ID: <7vk66mdxl0.fsf@assigned-by-dhcp.cox.net>
References: <11524377844177-git-send-email-alp@atoker.com>
	<44B1A01F.5090408@atoker.com>
	<7vodvye10h.fsf@assigned-by-dhcp.cox.net>
	<44B1B093.9000201@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 04:04:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzl8m-0006Oq-Tk
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 04:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161295AbWGJCEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 22:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161296AbWGJCEu
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 22:04:50 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12773 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161295AbWGJCEt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 22:04:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710020449.DXTX554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 22:04:49 -0400
To: Alp Toker <alp@atoker.com>
In-Reply-To: <44B1B093.9000201@atoker.com> (Alp Toker's message of "Mon, 10
	Jul 2006 02:42:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23582>

Alp Toker <alp@atoker.com> writes:

> I hadn't realised that git-svn work was happening on a topic
> branch. In light of that, it makes perfect sense to split out the
> commit as you did. It's good to hear that git isn't just truncating
> patches.

No, what would happen (if I were not careful) if I try to apply
it to "master" would be that "git am" would refuse to touch any
file.  IOW, it tries to apply the patches atomically.  Not
truncating or omitting patches is one of the most important
things git needs to do correctly so it had better work right
;-).
