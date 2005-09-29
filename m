From: Junio C Hamano <junkio@cox.net>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 28 Sep 2005 21:30:32 -0700
Message-ID: <7v64skpkbb.fsf@assigned-by-dhcp.cox.net>
References: <433B3B10.5050407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 06:31:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKq47-0002BM-SS
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVI2Eag (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVI2Eag
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:30:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9116 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751172AbVI2Eaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 00:30:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929043033.HUWJ19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 00:30:33 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433B3B10.5050407@zytor.com> (H. Peter Anvin's message of "Wed,
	28 Sep 2005 17:53:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9457>

"H. Peter Anvin" <hpa@zytor.com> writes:

> There are still funnies.  In particular, Cygwin and Samba handle 
> symlinks differently, so you can't trivially share a repository via 
> Samba.  Linus' "symbolic refs" changes should eventually take care of that.

I just sent out "The other side of Linus' symbolic refs" patch,
saying that Cygwin capable of doing symlink would probably made
it irrelevant.  But it may not be a waste after all, considering
what you said above.
