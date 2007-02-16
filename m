From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-bundle - pack objects and references for disconnected transfer
Date: Thu, 15 Feb 2007 23:28:32 -0800
Message-ID: <7vd54aa7dr.fsf@assigned-by-dhcp.cox.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
	<11715851972838-git-send-email-mdl123@verizon.net>
	<7vodnuc0me.fsf@assigned-by-dhcp.cox.net>
	<20070216044158.GB28894@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 08:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHxWH-0008Pd-3a
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 08:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbXBPH2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 02:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966165AbXBPH2e
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 02:28:34 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49967 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966163AbXBPH2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 02:28:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216072833.LUFZ1300.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 02:28:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q7UY1W00D1kojtg0000000; Fri, 16 Feb 2007 02:28:33 -0500
In-Reply-To: <20070216044158.GB28894@spearce.org> (Shawn O. Pearce's message
	of "Thu, 15 Feb 2007 23:41:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39895>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Using "test" is a style thing, but using "=" rather than "==" is
> a portability issue.  "==" is accepted by bash as a synonym for
> "=", but its not valid elsewhere.

True, I should have stressed that.  Thanks.  Also in the same
sense (but to a lessor degree), "test" vs "[" is also
portability issue.

> What about:
>
> 	parents="$parents $(git-rev-list --max-count=1 --parents $c | cut -b42-)"
>
> I just used that trick recently.  Oh yea it was in git-gui's
> GIT-VERSION-GEN script.  Though I did not know about using cut
> like that...

I used to stay away from 'cut' myself, although it is not too
bad for portability these days.  I would probably have done the
above with a single sed process, though.
