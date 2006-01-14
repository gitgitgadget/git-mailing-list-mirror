From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 12:38:25 -0800
Message-ID: <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	<43C537C9.4090206@hogyros.de>
	<Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
	<7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<43C951B6.5030607@gmail.com>
	<Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
	<43C95F69.7090200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:38:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExsAS-0007Qh-9q
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWANUi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWANUi3
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:38:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21471 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751093AbWANUi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 15:38:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114203833.NWYB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 15:38:33 -0500
To: gitzilla@gmail.com
In-Reply-To: <43C95F69.7090200@gmail.com> (A. Large Angry's message of "Sat,
	14 Jan 2006 12:30:33 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14683>

A Large Angry SCM <gitzilla@gmail.com> writes:

>> If I could have just done a "git clone <top-level>" to get it all,
>> I'd have been a much more productive user.
>
> $ make get_sub_components
>
> This can work with most any SCM (depending on your environment), is
> amazingly flexible, and does not require special support in the SCM.

I am with you two on this one, in principle, as a developer.

> The "get" rule for each sub-project could be something like:
>
> 	git_sub-project:
> 		mkdir sub-project
> 		cd sub-project
> 		git-init-db
> 		git-fetch <fetch-options> <repository> <refspec>
> 		git-checkout <branch>
> 		$(MAKE) get_sub_components

There lies a drake here --- <repository> is not the same for
everybody.  It is not a big showstopper dragon, though.
