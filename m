From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Teach git-remote to list pushed branches.
Date: Mon, 19 Mar 2007 20:16:46 +0100
Message-ID: <200703192016.46894.johannes.sixt@telecom.at>
References: <200703182134.46450.johannes.sixt@telecom.at> <7vzm6ajnj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 20:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTNLl-0005Xh-76
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 20:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbXCSTQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 15:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbXCSTQ4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 15:16:56 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:36748 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbXCSTQz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 15:16:55 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id F0E2D13A2D5;
	Mon, 19 Mar 2007 20:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8FD1A4B624;
	Mon, 19 Mar 2007 20:16:47 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzm6ajnj1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42655>

On Sunday 18 March 2007 21:37, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> >  The hunk that reads the 'Push'es from the .git/remotes file is taken
> >  almost verbatim from the corresponding 'Pull' clause and is untested.
>
> Maybe while waiting for application nor comments you could have
> tested and removed that comment?

Fair enough ;)

While waiting for application or comments again, I did test now, and the patch 
does what I expect even for .git/remotes files, that is, it prints the refs 
to be pushed just like it does for remotes noted in the config file.

-- Hannes
