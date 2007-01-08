From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is nothing to commit.
Date: Sun, 07 Jan 2007 21:48:13 -0800
Message-ID: <7vslemxe5e.fsf@assigned-by-dhcp.cox.net>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
	<7virfldryw.fsf@assigned-by-dhcp.cox.net>
	<7vodpcae9s.fsf@assigned-by-dhcp.cox.net>
	<17823.42284.620000.476920@lapjr.intranet.kiel.bmiag.de>
	<7vfyao58a7.fsf@assigned-by-dhcp.cox.net>
	<17824.10780.295000.771566@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 06:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3nMw-0008Qf-V8
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 06:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbXAHFsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 00:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbXAHFsQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 00:48:16 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61594 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161165AbXAHFsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 00:48:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108054814.EEPA97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 00:48:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8VnQ1W00F1kojtg0000000; Mon, 08 Jan 2007 00:47:25 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17824.10780.295000.771566@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Sun, 7 Jan 2007 00:00:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36237>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> Junio C Hamano writes:
>  > If there is something you are missing, it is that I am
>  > overloaded these days ;-).
>
> I'm sorry. As a rather unsuccessful former maintainer of
> http://www.openarchitectureware.org/ I can fully appreciate git's luck
> to have such a dedicated maintainer.

Actually there is one difference that I found practically
important.  It usually is a norm for me to have a handful
untracked files that I do not even bother adding to .gitignore
in the repository.  My patch does not suggest "add" when there
are untracked files but no locally modified files.
