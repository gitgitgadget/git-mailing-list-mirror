From: Junio C Hamano <junkio@cox.net>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 01:38:42 -0800
Message-ID: <7virdy8p25.fsf@assigned-by-dhcp.cox.net>
References: <200702190916.35813.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 10:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ4zE-0004fA-3w
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 10:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbXBSJio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 04:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbXBSJio
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 04:38:44 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37525 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXBSJio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 04:38:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219093843.OPPA21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Feb 2007 04:38:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RMei1W00V1kojtg0000000; Mon, 19 Feb 2007 04:38:43 -0500
In-Reply-To: <200702190916.35813.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 19 Feb 2007 09:16:34 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40109>

Andy Parkins <andyparkins@gmail.com> writes:

> I'm working on bringing my hash width literals patch up to
> date now that 1.5.0 has passed.  It's all been trivial apart
> from one line:
>
> #define HASH_WIDTH_ASCII 40
> -               printf("%-40s %s%s (%d subtrees)\n",
> +               printf("%-" HASH_WIDTH_ASCII "s %s%s (%d subtrees)\n",
>
> This compiles, but I suspect that it's not going to do what I
> want it to do.

Doesn't writing "foo" "bar" (two string literals next to each other)
tell the compiler to concatenate them?
