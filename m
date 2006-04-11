From: Junio C Hamano <junkio@cox.net>
Subject: Re: t5501-old-fetch-and-upload.sh fails with NO_PYTHON=1
Date: Tue, 11 Apr 2006 11:06:54 -0700
Message-ID: <7vlkuc56m9.fsf@assigned-by-dhcp.cox.net>
References: <20060411170508.G14ba7e47@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 11 20:07:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTNGW-00062r-QI
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 20:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWDKSG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWDKSG5
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 14:06:57 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31711 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750931AbWDKSG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 14:06:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411180655.MNYR20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Apr 2006 14:06:55 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060411170508.G14ba7e47@leonov.stosberg.net> (Dennis Stosberg's
	message of "Tue, 11 Apr 2006 19:05:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18616>

Dennis Stosberg <dennis@stosberg.net> writes:

> I have attached a simple fix, but is this test still useful at all?

Thanks.  I am inclined to say that when we need the "make sure
this updated send-pack works with older receive-pack and vice
versa" tests the next time, the framework to call the
counterpart program from different vintage might be reusable but
what the test tries to test would be different, so keeping this
particular test would be somewhat useful as reference and
perhaps a starting point for such new test, but otherwise not
very much.  And for that kind of usage, "the Net never forgets".

I'd vote for its removal.  Thoughts?
