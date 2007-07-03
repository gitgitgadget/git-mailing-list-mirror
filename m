From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fsck: add --lost-found option
Date: Mon, 02 Jul 2007 17:08:25 -0700
Message-ID: <7vps3auz5y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707021751380.4071@racer.site>
	<7vabuewgdb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707030018120.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 02:08:40 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Vwd-000842-L2
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 02:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbXGCAI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 20:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbXGCAI2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 20:08:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:39663 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbXGCAI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 20:08:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703000826.VIYK1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 20:08:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jo8R1X00l1kojtg0000000; Mon, 02 Jul 2007 20:08:26 -0400
In-Reply-To: <Pine.LNX.4.64.0707030018120.4071@racer.site> (Johannes
	Schindelin's message of "Tue, 3 Jul 2007 00:26:37 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51432>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	WARNING: 'git lost-found' is deprecated.
> 	WARNING: Use 'git fsck --lost-found' instead
>
> whenever lost-found is called?

I agree that would be a sensible second step after the result of
the first step matures.

>>  3. git-lost-found is removed.
>
> Yes, that can wait.
>
> What is more important before doing 1&2 for real is this: lost-found ATM 
> calls 'git-fsck --full --no-reflogs'. The patch does not force these two 
> options when called with '--lost-found'. I would really appreciate 
> opinions on this issue, and will gladly re-prepare a patch accordingly.

I think I am not following you; do you mean --lost-found does
not imply these two?  I am not sure if there is any benefit of
being able to do --lost-found without --full nor --no-reflogs.
