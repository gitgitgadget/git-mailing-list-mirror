From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix bad usage of mkpath in builtin-branch.sh
Date: Mon, 23 Oct 2006 23:46:49 -0700
Message-ID: <7vlkn6qkh2.fsf@assigned-by-dhcp.cox.net>
References: <1161655176461-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcG3u-0003iA-2A
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWJXGqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWJXGqv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:46:51 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:4070 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1752100AbWJXGqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 02:46:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024064649.TKNN6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Oct 2006 02:46:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id e6mt1V00U1kojtg0000000
	Tue, 24 Oct 2006 02:46:54 -0400
To: Lars Hjemli <hjemli@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29937>

Lars Hjemli <hjemli@gmail.com> writes:

> When checking if a branch start point referred to a commit-object,
> the result of mkpath() was used as argument to get_sha1(), which
> didn't work out as planned.
>
> Now it's xstrdup'd first.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>  builtin-branch.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-branch.c b/builtin-branch.c
> index ffc2db0..f86bf68 100755

I've already fixed up this perm-mode breakage (and other
breakages, possibly) so when I am done with these patches
tonight please resync with me.
