From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 16:49:15 -0800
Message-ID: <7v4q4671tg.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	<43C537C9.4090206@hogyros.de>
	<Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
	<7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<43C951B6.5030607@gmail.com>
	<Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
	<43C95F69.7090200@gmail.com> <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net>
	<46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sun Jan 15 01:49:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exw5D-0003cp-CE
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 01:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWAOAtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 19:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWAOAtT
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 19:49:19 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5544 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751522AbWAOAtS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 19:49:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115004824.COZC15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 19:48:24 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 15 Jan 2006 13:28:58 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14690>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I am with gitzilla on this one. Let the projects have their own
> bootstraping mechanisms, using make, ant or whatever catches their
> fancy. One of the great things about git is that it doesn't assume
> that it's being used by all the projects in the world -- thanks to
> Linus' disregard for arbitrary metadata and to your git-cherry
> implementation, it's all about the content -- and so it interoperates
> great with Arch, SVN, CVS, etc.

I had the exactly the same reaction when I saw the project
bundling facility of Arch (tla 1.0 -- I do not know what the
newer versions use).  It probably was a great way to tie two or
more Arch projects together, but it would quickly become less
useful once the component project is outside Arch space and the
toplevel project would end up with doing some Makefile targets
like ALASCM described.

I hope this settles this issue and nobody would bring up "Wee
want subprojects" ever again ;-).
