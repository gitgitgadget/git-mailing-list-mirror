From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] t4014: Replace sed's non-standard 'Q' by standard 'q'
Date: Sat, 23 Feb 2008 14:28:57 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802231426560.19024@iabervon.org>
References: <12037561161987-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Feb 23 20:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT044-0002Ka-5L
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 20:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYBWT3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 14:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbYBWT3B
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 14:29:01 -0500
Received: from iabervon.org ([66.92.72.58]:40963 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbYBWT3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 14:29:00 -0500
Received: (qmail 3143 invoked by uid 1000); 23 Feb 2008 19:28:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Feb 2008 19:28:58 -0000
In-Reply-To: <12037561161987-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74840>

On Sat, 23 Feb 2008, Steffen Prohaska wrote:

> This commit should be applied on top of db/cover-letter.
> 
> -- >8 --
> 
> This commit avoids sed's 'Q' operator.  The Open Group's sed
> man page [1] does not mention 'Q'.  sed on Mac OS X 10.4
> does not accept Q.  'q' is sufficient for our purpose.
> 
> [1] http://opengroup.org/onlinepubs/007908799/xcu/sed.html

Looks good to me; GNU man pages annoyingly don't tell you what's not more 
standard.

	-Daniel
*This .sig left intentionally blank*
