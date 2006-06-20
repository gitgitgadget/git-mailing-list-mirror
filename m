From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (fixed)] git-svn: fix --rmdir when using SVN:: libraries
Date: Mon, 19 Jun 2006 18:17:05 -0700
Message-ID: <7vbqso7him.fsf@assigned-by-dhcp.cox.net>
References: <11507645052855-git-send-email-normalperson@yhbt.net>
	<11507651751452-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 03:17:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsUrj-0000Dw-8t
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 03:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWFTBRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 21:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWFTBRH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 21:17:07 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24739 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965039AbWFTBRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 21:17:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620011706.ZQRC15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 21:17:06 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11507651751452-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Mon, 19 Jun 2006 17:59:35 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22157>

Eric Wong <normalperson@yhbt.net> writes:

> Makefile: automatically run new tests as they appear in t/
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>
> Oops, I left out the Makefile change in the other patch,...

Yeah, I was wondering about that.

> ... had the new
> test file as +x

Shouldn't they be executable?  It is not a big deal, because you
run them via $(SHELL), though...
