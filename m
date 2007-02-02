From: Junio C Hamano <junkio@cox.net>
Subject: Re: Instructions concerning detached head lead to lost local changes
Date: Thu, 01 Feb 2007 17:41:11 -0800
Message-ID: <7v1wl9mj48.fsf@assigned-by-dhcp.cox.net>
References: <87mz3xa3vr.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 02:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCnQR-000320-Pd
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 02:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423065AbXBBBlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 20:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423067AbXBBBlN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 20:41:13 -0500
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:65441 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423065AbXBBBlM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 20:41:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202014112.QXWG1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Feb 2007 20:41:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JRhB1W00U1kojtg0000000; Thu, 01 Feb 2007 20:41:11 -0500
In-Reply-To: <87mz3xa3vr.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	01 Feb 2007 14:51:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38447>

Carl Worth <cworth@cworth.org> writes:

> At this point, I _knew_ that I didn't care about the state I was
> leaving, (it was something random that I had done for testing). So I
> definitely didn't want to name it with option (2).
>
> I also knew I hadn't done any commits while detached, which is what I
> thought the warning was all about. So I wasn't worried about losing
> nothing with option (1).

Well, the wording could probably be improved because you _did_
care about the state you were leaving (the "state" is not just
what commit HEAD points at), but the suggestions did make it
sound as if your had to choose between only these two, and
neither would have worked for you.

> Can we fix this please?

The question is how.

We can admit that suggestions are just suggestions and listing
only two is more confusing than not saying anything concrete.

Alternatively we could add yet another suggestion that let's you
discard the detached HEAD but still keep your local changes.
Either --drop by Linus renamed to some sensible name, or "the
obscure but useful trick".

I dunno.
