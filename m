From: Junio C Hamano <junkio@cox.net>
Subject: Re: seperate commits for objects already updated in index?
Date: Tue, 14 Mar 2006 15:51:54 -0800
Message-ID: <7vwtewk2jp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
	<Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
	<Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Jakma <paul@clubi.ie>
X-From: git-owner@vger.kernel.org Wed Mar 15 00:52:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJJJ1-00055q-M7
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 00:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWCNXv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 18:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWCNXv4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 18:51:56 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35825 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751312AbWCNXv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 18:51:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060314234957.OHCI20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Mar 2006 18:49:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603140915290.3618@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 14 Mar 2006 09:20:22 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17603>

Linus Torvalds <torvalds@osdl.org> writes:

> I also think that test is historical, from before Junio cleaned up how 
> "git commit" worked - it _used_ to be that "git commit" would work in the 
> current index, but these days it generates a new index to commit when you 
> do "-o", so there's really no _technical_ reason to refuse the partial 
> commit any more as far as I can see.
>
> So I don't know. I don't think you were being dumb, I think git could have 
> been friendlier to you.

I have to go back to the list archive, but if I recall correctly
the refusal was added to be friendlier -- by being safer -- and
was not there in the earlier round of -o/-i proposal.
