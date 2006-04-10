From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull origin doesn't update the master
Date: Sun, 09 Apr 2006 23:29:44 -0700
Message-ID: <7vr7469c4n.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 08:29:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSpuN-0000Lg-OY
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 08:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWDJG3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 02:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWDJG3q
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 02:29:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22249 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750988AbWDJG3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 02:29:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060410062945.ISNC15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 02:29:45 -0400
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
	(Aneesh Kumar's message of "Mon, 10 Apr 2006 10:11:05 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18580>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> While updating the git code base the master branch is not getting
> updated. First look tell me that the below commit is the issue
> a9698bb22fb7b66e5882c3a5e7b2b8b53ea03f90
>
> git-pull.sh does
> git-fetch --update-head-ok "$@" || exit 1

Yes, this was done as an response to an explicit request from
Andrew Morten.

What Sean said about "pu" branch is correct.
