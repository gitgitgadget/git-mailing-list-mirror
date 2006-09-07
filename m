From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cygwin playbook?
Date: Thu, 07 Sep 2006 01:07:28 -0700
Message-ID: <7vwt8g2j7j.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90609062159v3858a771t38355ed60867ccfc@mail.gmail.com>
	<7v7j0g40xh.fsf@assigned-by-dhcp.cox.net>
	<46a038f90609070018k319b748cmae7a9b30da45b3b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 10:07:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLEux-0004rD-QD
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 10:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWIGIHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 04:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWIGIHT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 04:07:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38311 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750937AbWIGIHR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 04:07:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907080716.FHEP21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 04:07:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KL781V00L1kojtg0000000
	Thu, 07 Sep 2006 04:07:09 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609070018k319b748cmae7a9b30da45b3b6@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 7 Sep 2006 19:18:10 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26612>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Sorry to ask this... Are you sure? Vanilla base setup with no extra
> packages getting gcc and various -dev packages? Perhaps there is a
> 'developer' profile during install that gets you a reasonable kit?

What I meant was "readily available", not "installed by default". 

> About 5 minutes ago I managed to get limited access (non-root, cannot
> install packages) to a cygwin env using rdesktop. It did have gcc and
> make, but make bombed out with a missing libcurl and openssl header
> files. IIRC, diff3/merge isn't in the base install either.

It is in rcs as usual ;-).

> In debian I can look at apt-cache show git-core to get a quick
> overview of dependencies but here I'm lost :(

The packaging was pretty much similar and I could guess from
apt-cache show git-core output indeed ;-).
