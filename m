From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 22:44:32 -0700
Message-ID: <7vd4zn9qdb.fsf@assigned-by-dhcp.pobox.com>
References: <20070621030622.GD8477@spearce.org>
	<alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
	<Pine.LNX.4.64.0706211248420.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 07:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1yQL-0008FG-NZ
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 07:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbXFWFoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 01:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXFWFoh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 01:44:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57679 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbXFWFog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 01:44:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623054433.IAFZ6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Jun 2007 01:44:33 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EtkY1X00E1kojtg0000000; Sat, 23 Jun 2007 01:44:33 -0400
In-Reply-To: <Pine.LNX.4.64.0706211248420.4059@racer.site> (Johannes
	Schindelin's message of "Thu, 21 Jun 2007 12:52:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50718>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When there are several candidates for a rename source, and one of them
> has an identical basename to the rename target, take that one.
>
> Noticed by Govind Salinas, posted by Shawn O. Pearce, partial patch
> by Linus Torvalds.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Wed, 20 Jun 2007, Linus Torvalds wrote:
>
> 	> I think we should just consider the basename as an "added 
> 	> similarity  bonus".

Thanks, I obviously agree with both of you.
