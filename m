From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Tue, 26 Dec 2006 23:46:52 -0800
Message-ID: <7vr6ul93wz.fsf@assigned-by-dhcp.cox.net>
References: <20061227071759.GA23057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 08:46:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzTV3-0000LR-8z
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 08:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979AbWL0Hqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 02:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932980AbWL0Hqy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 02:46:54 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47105 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932979AbWL0Hqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 02:46:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227074653.ZNLF16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 02:46:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3jn61W00G1kojtg0000000; Wed, 27 Dec 2006 02:47:07 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061227071759.GA23057@spearce.org> (Shawn O. Pearce's message
	of "Wed, 27 Dec 2006 02:17:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35452>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +The optional configuration variable 'gc.reflogExpireUnreachable'
> +can be set to indicate how long historical reflog entries which
> +are not part of the current branch should remain available in
> +this repository.  These types of entries are generally created as
> +a result of using `git commit \--amend` or `git rebase` and are the
> +commits prior to the amend or rebase occuring.  Since these changes
> +are not part of the current project most users will want to expire
> +them sooner.  This option defaults to '60 days'.

Should I update the default expire-unreachable in builtin-reflog
to match 60 days?
