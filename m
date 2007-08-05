From: Junio C Hamano <gitster@pobox.com>
Subject: Re: way to automatically add untracked files?
Date: Sat, 04 Aug 2007 21:23:56 -0700
Message-ID: <7v8x8qip7n.fsf@assigned-by-dhcp.cox.net>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org> <87lkcqlif2.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 06:24:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXet-0008Sq-JR
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXHEEYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXHEEYA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:24:00 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46236 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbXHEEYA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:24:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805042357.YBBL7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 00:23:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y4Px1X0021kojtg0000000; Sun, 05 Aug 2007 00:23:57 -0400
In-Reply-To: <87lkcqlif2.fsf@catnip.gol.com> (Miles Bader's message of "Sun,
	05 Aug 2007 13:22:25 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54938>

Miles Bader <miles@gnu.org> writes:

> Really I want a single command that just tells git "please add to the
> index _all changes that you can find_".

"git add -u"
