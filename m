From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 22:23:48 -0800
Message-ID: <7vpsa0inwr.fsf@assigned-by-dhcp.cox.net>
References: <20061231031305.GA5620@spearce.org>
	<7vy7ooip6y.fsf@assigned-by-dhcp.cox.net>
	<20061231061232.GC6106@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 07:24:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0u73-0004hl-4E
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 07:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029AbWLaGXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 01:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933031AbWLaGXv
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 01:23:51 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50982 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933029AbWLaGXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 01:23:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231062350.JZWR15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 01:23:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5JP31W0041kojtg0000000; Sun, 31 Dec 2006 01:23:04 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061231061232.GC6106@spearce.org> (Shawn O. Pearce's message of
	"Sun, 31 Dec 2006 01:12:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35680>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> Why?  Are you allowing "1024 k"?  Do we want to?
>
> Yes.  Why not?

Stricter input checking.  Allowing extra things later is far
easier than later finding problems with a looser way we started
from and having to tighten it.
