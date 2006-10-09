From: Junio C Hamano <junkio@cox.net>
Subject: Re: "fatal: Untracked working tree file 'so-and-so' would be overwritten by merge"
Date: Mon, 09 Oct 2006 09:55:39 -0700
Message-ID: <7vr6xhcttg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org>
	<7v7izaf62c.fsf@assigned-by-dhcp.cox.net>
	<7vodsmdq0m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610090858120.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 18:58:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWyPo-0006bQ-Cg
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 18:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979AbWJIQzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 12:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932981AbWJIQzl
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 12:55:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:24721 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932979AbWJIQzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 12:55:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009165540.ZTBI12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 12:55:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YGvi1V0191kojtg0000000
	Mon, 09 Oct 2006 12:55:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610090858120.3952@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 9 Oct 2006 09:03:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28573>

Linus Torvalds <torvalds@osdl.org> writes:

> If the local index doesn't change, we should not print out the "Removing 
> 'so-and-so'" message, but we should also not even _touch_ that file, 
> because it was already "gone" as far as the local tree was concerned.
>
> Agreed?

Yes.
