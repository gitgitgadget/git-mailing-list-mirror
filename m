From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sat, 28 May 2005 09:25:02 -0700
Message-ID: <7vk6ljuxlt.fsf@assigned-by-dhcp.cox.net>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
	<20050528111238.GA1036@pasky.ji.cz>
	<20050528111959.GA28780@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 18:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc45S-0001Kt-Ov
	for gcvg-git@gmane.org; Sat, 28 May 2005 18:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVE1QZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 12:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVE1QZI
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 12:25:08 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23775 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261161AbVE1QZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 12:25:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528162503.ZIYM19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 12:25:03 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050528111959.GA28780@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sat, 28 May 2005 13:19:59 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> I think it is. For example on git development it is nice to see the
TG> Documentation first. So you know what it is supposed to do and later you
TG> see the actual implementation. I think Junio requested this exactly
TG> before.

Well, yes and no.  I do want to see the patches in the suggested
order because that would make things easier to understand if
they are related.

The request you are referring to was not about the order of
patches in one e-mail message.  It was more like "please show us
documentation first so that we can pick nits in the design (goal
of implementation) before you start to code".  That way, if
there were a change (like -A flag in checkout-cache) that people
would find objectionable, the effort to code the change and
the effort to review the code can both be saved.

