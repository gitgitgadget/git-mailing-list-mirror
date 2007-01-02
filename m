From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix infinite loop when deleting multiple packed refs.
Date: Tue, 02 Jan 2007 00:44:43 -0800
Message-ID: <7vtzz9x1fo.fsf@assigned-by-dhcp.cox.net>
References: <b566b20c0701012244l21f85472k83970c0c573ce105@mail.gmail.com>
	<20070102081709.GA28779@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 09:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1fGL-0005p4-48
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 09:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991AbXABIop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932993AbXABIop
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 03:44:45 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49051 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbXABIop (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 03:44:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102084445.BYXG15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 03:44:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 68jx1W00N1kojtg0000000; Tue, 02 Jan 2007 03:43:58 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35781>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  Fixed.  ;-)
>
>  Junio, this applies to master, but hopefully could also apply to
>  maint, as the bug also shows up there.

I see a few instances of single static lock_file variable in our
code, but all of them seem to be locking the index and only
once, so they should be safe.

Thanks.
