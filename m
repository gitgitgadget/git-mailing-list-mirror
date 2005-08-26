From: Junio C Hamano <junkio@cox.net>
Subject: Re: cache status after git pull
Date: Thu, 25 Aug 2005 18:29:41 -0700
Message-ID: <7vll2pmqnu.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043B9B85@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 06:21:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8T2g-0005ah-DF
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 03:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVHZB3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 21:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVHZB3n
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 21:29:43 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24023 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965040AbVHZB3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 21:29:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826012941.WSWZ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 21:29:41 -0400
To: "Luck, Tony" <tony.luck@intel.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7783>

"Luck, Tony" <tony.luck@intel.com> writes:

> What I want is to get the latest from kernel.org...linus...master
> and update my .refs/heads/linus with the new SHA1.
>
> I'd like to be able to do that without touching what is in my
> index, and without changing the state of any checked out files.
>
> If that is what the above does,...

At least that is how "git fetch <repo> <src>:<dst>" is designed
to work, and "Pull: <src>:<dst>" in a remotes/ shorthand is
designed to reduce typing while doing so.  Please bug me if
things do not work as advertised.
