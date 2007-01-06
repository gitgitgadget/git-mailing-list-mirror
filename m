From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is nothing to commit.
Date: Sat, 06 Jan 2007 10:17:52 -0800
Message-ID: <7vfyao58a7.fsf@assigned-by-dhcp.cox.net>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
	<7virfldryw.fsf@assigned-by-dhcp.cox.net>
	<7vodpcae9s.fsf@assigned-by-dhcp.cox.net>
	<17823.42284.620000.476920@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 19:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3G7A-0007nl-RL
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 19:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXAFSRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 13:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXAFSRy
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 13:17:54 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:45144 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbXAFSRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 13:17:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106181752.OKNI18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 13:17:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7uJ71W01y1kojtg0000000; Sat, 06 Jan 2007 13:18:08 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17823.42284.620000.476920@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Sat, 6 Jan 2007 14:33:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36092>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

>  > How about doing this?
>  > 
>  > -- >8 --
>  > git-status: squelch "use 'git add file...'" message when unneeded
>  > 
>  > Add a field in wt_status to record if there are any uncached
>  > changes, and use it to decide when there is no point to add the
>  > "use 'git add'" message.
>
> Commit 6e458bf63f48fb7d15cb70ad7c7b7b71915d94a2 in next is already
> doing exactly that. Or am I missing something?

If there is something you are missing, it is that I am
overloaded these days ;-).

Thanks for the reminder.
