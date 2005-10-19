From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clone: don't unpack objects
Date: Wed, 19 Oct 2005 13:58:36 -0700
Message-ID: <7virvt441v.fsf@assigned-by-dhcp.cox.net>
References: <20051019154341.2aed6998.tihirvon@gmail.com>
	<7v4q7d5kwo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510191327560.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:01:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESL1H-0004Jq-B8
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVJSU6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVJSU6i
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:58:38 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:37790 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751330AbVJSU6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 16:58:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019205810.GEPM776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 16:58:10 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510191327560.3369@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 19 Oct 2005 13:31:53 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10308>

Linus Torvalds <torvalds@osdl.org> writes:

> No, I think the unconditional --keep is fine for clone.
>
> What to do about incremental pulls is not as clear, but I think the clone 
> case is pretty much obvious these days.
>
> The main reason for unpacking was that packs used to be "strange". These 
> days, packs are arguably the _common_ thing.

OK, that makes sense. 

I'd move this 'unconditional keep' to clone-pack.  The --keep
flag becomes a no-op.
