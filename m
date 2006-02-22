From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-ls-files: Fix, document, and add test for --error-unmatch option.
Date: Tue, 21 Feb 2006 17:59:31 -0800
Message-ID: <7vr75wtapo.fsf@assigned-by-dhcp.cox.net>
References: <87vev8sajl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:59:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBjIJ-0003cx-6k
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbWBVB7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161288AbWBVB7f
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:59:35 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:6576 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161306AbWBVB7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:59:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222015824.KAUM3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 20:58:24 -0500
To: Carl Worth <cworth@cworth.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16585>

Carl Worth <cworth@cworth.org> writes:

>  I'm still not sure what the easiest way is for me to provide changes
>  to you. I've been doing it here on the list, like with the current
>  message. But would it be easier for me to send pull requests?

You can decide what is easier for _you_ ;-).

But for me, emailed patches are easier to work on than pull
requests.  I will need to read and understand most of the
changes anyway, unless the change is to an isolated corner of
the system that would affect only one class of users and
breakage will be noticed either immediately or can be left
broken if nobody uses that (e.g. things like contrib/ and some
foreign SCM interfaces).  I would like others on the list to be
able to review the same changes that might hit my tree and
provide extra sets of eyeballs to spot things I might miss
myself alone.

>  For example, with the git-clone failure cleanup I recently did, it
>  seems the new test case I wrote didn't land in your tree.

Sorry, I think I just forgot to apply that one.  I still have
the message so no need to resend.  Thanks for reminding.
