From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push sends more objects than it needs to
Date: Mon, 31 Oct 2005 10:49:39 -0800
Message-ID: <7vbr15iksc.fsf@assigned-by-dhcp.cox.net>
References: <20051031182355.GA7368@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 19:52:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWej3-0008CL-H9
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 19:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVJaStl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVJaStl
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 13:49:41 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28800 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932481AbVJaStk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 13:49:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031184904.EXCB29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 13:49:04 -0500
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <20051031182355.GA7368@agluck-lia64.sc.intel.com> (Tony Luck's
	message of "Mon, 31 Oct 2005 10:23:55 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10873>

"Luck, Tony" <tony.luck@intel.com> writes:

> Now the "unpack" on kernel.org did the right thing and noticed
> that over 9000 of the objects were already in the packfile.  But
> I wonder if it couldn't have been smarter and not sent them?
>
> Or am I just subverting the whole paradigm by hand-copying
> packfiles around?

The fix for this problem is in 0.99.9 (credits to Johannes).
Unfortunately, 0.99.8f is still in /usr/bin/ on kernel.org.
