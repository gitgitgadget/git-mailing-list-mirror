From: Junio C Hamano <junkio@cox.net>
Subject: Re: The merge from hell...
Date: Sat, 04 Feb 2006 04:22:25 -0800
Message-ID: <7v1wyj1fge.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<17380.34301.584514.520465@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:22:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5MQv-0003Sx-EE
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 13:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWBDMW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 07:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBDMW1
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 07:22:27 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34505 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932451AbWBDMW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 07:22:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204121927.NTBK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 07:19:27 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17380.34301.584514.520465@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sat, 4 Feb 2006 21:46:21 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15591>

Paul Mackerras <paulus@samba.org> writes:

> Why is that interesting?  It seems to me that two independent changes
> were made that just happened to be within a couple of lines of each
> other, but didn't interact.

I agree th hunk in that particular case is not that interesting.

Things are not black and white but you have to draw a line
somewhere.  "Happend to be within a couple of lines" is where we
currently draw that line (it is called "context").
