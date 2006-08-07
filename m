From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] handle https:// protocol in git-clone
Date: Mon, 07 Aug 2006 11:35:45 -0700
Message-ID: <7v1wrs4cn2.fsf@assigned-by-dhcp.cox.net>
References: <20060807151021.GF21051@argo.zzZZzz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 20:36:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA9x9-0000rw-BN
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 20:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWHGSfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 14:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHGSfs
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 14:35:48 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:2039 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932295AbWHGSfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 14:35:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807183546.VYGN10979.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 14:35:46 -0400
To: Michael Krelin <hacker@klever.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25026>

Michael Krelin <hacker@klever.net> writes:

> ---
>  git-clone.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks.  git-fetch and git-ls-remote already do so and it was a
stupid omission not to do this in git-clone.
