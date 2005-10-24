From: Junio C Hamano <junkio@cox.net>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 13:59:52 -0700
Message-ID: <7vek6amy0n.fsf@assigned-by-dhcp.cox.net>
References: <867jc336f4.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
	<86irvmzyq9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
	<Pine.LNX.4.64.0510241002180.10477@g5.osdl.org>
	<435D1963.8070205@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 23:01:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU9QN-0005CG-PX
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 23:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVJXU7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVJXU7y
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 16:59:54 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17324 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751286AbVJXU7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 16:59:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024205939.SWJG16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 16:59:39 -0400
To: "H. Peter Anvin" <hpa@zytor.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <435D1963.8070205@zytor.com> (H. Peter Anvin's message of "Mon,
	24 Oct 2005 10:26:59 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10560>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I think there is another good reason for doing the renaming bit: we're 
> creating new macros with different semantics; in particular, the git 
> macros handle signed char input and don't guarantee anything w.r.t. EOF.
>
> 	-hpa

Thanks.  I'll include the renaming bits to "master" branch when
I hear somebody on OpenBSD confirms that the patch fixes it.
