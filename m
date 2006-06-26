From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some adhocery
Date: Mon, 26 Jun 2006 16:04:23 -0700
Message-ID: <7vk673h62w.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
	<Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
	<Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 01:05:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv097-00012y-KB
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWFZXEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933312AbWFZXE3
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:04:29 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47785 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S933280AbWFZXE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 19:04:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626230424.WXIG6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 19:04:24 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Jun 2006 01:00:57 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22690>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Could you test with "origin..master" instead of "origin master"?
>> 
>> Funny you mention that! Now it works ;-) and it even produces the
>> patches I would expect.
>
> The funny thing is: I did something to account for the old syntax, but 
> only if you specified _one_ ref, not _two_. It would be easy, but is it 
> needed? (I.e. are your fingers so trained on it?)

If possible I'd rather correct the two syntaxes once and for all now.
Maybe accept two with a warning for deprecation?
