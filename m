From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge noise in git-shortlog output
Date: Tue, 06 Sep 2005 15:02:21 -0700
Message-ID: <7vfyshg8ia.fsf@assigned-by-dhcp.cox.net>
References: <200509062144.j86Li04N010540@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 00:04:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EClWM-00058l-1R
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 00:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVIFWCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 18:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVIFWCX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 18:02:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:21965 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751001AbVIFWCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 18:02:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906220222.LAIE3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 18:02:22 -0400
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200509062144.j86Li04N010540@agluck-lia64.sc.intel.com> (Tony
	Luck's message of "Tue, 6 Sep 2005 14:44:00 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8152>

"Luck, Tony" <tony.luck@intel.com> writes:

> This is valid (I really did make all those commits, they happen every
> time I merge the "linus" branch into my release branch, which I like to
> do quite often so I'm working near the bleeding edge), but it doesn't
> seem all that useful in the "short" log output[1]

Are there interesting merges and uninteresting automerges?  Are
all merges more or less uninteresting?  If merges are not
interesting:

    $ git log --no-merges --pretty=short $rev $argu $ments | git shortlog
