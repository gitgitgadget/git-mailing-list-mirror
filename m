From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a --prefix option to git-daemon
Date: Tue, 25 Oct 2005 00:42:27 -0700
Message-ID: <7virvmjb4s.fsf@assigned-by-dhcp.cox.net>
References: <200510250708.j9P78pG3024087@gameboy2.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 09:45:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUJSP-0004Yx-RT
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 09:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVJYHm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 03:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVJYHm3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 03:42:29 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:41633 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932067AbVJYHm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 03:42:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025074154.OVMA776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 03:41:54 -0400
To: Brad Roberts <braddr@gameboy2.puremagic.com>
In-Reply-To: <200510250708.j9P78pG3024087@gameboy2.puremagic.com> (Brad
	Roberts's message of "Tue, 25 Oct 2005 00:08:51 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10569>

Brad Roberts <braddr@gameboy2.puremagic.com> writes:

> Add a --prefix option to git-daemon.

What is your thought about my RFC last night [*1*], and how does
this patch address the concern raised in it, specifically what
is the plan for this --prefix option to work together with
upload-pack?

[Reference]

*1* http://marc.theaimsgroup.com/?l=git&m=113014402715697&w=2
