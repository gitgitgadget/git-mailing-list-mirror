From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible bug in 'git status' exit code is 1 instead of 0
Date: Tue, 09 Jan 2007 10:50:16 -0800
Message-ID: <7vslekkpav.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550701090945u5a240fe9xf46cc40b030e1ba7@mail.gmail.com>
	<7vhcv0m5md.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550701091033x51496b38x6c6f798e8a7ae795@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 19:50:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4M3H-0002JY-Ds
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 19:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbXAISuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 13:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbXAISuT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 13:50:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51973 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932371AbXAISuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 13:50:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109185017.GBEX18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 13:50:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 96pS1W00f1kojtg0000000; Tue, 09 Jan 2007 13:49:27 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550701091033x51496b38x6c6f798e8a7ae795@mail.gmail.com>
	(Marco Costalba's message of "Tue, 9 Jan 2007 19:33:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36385>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Ok, I was changing the error detection to check exit status, but it's
> definitely better to still check for something written to stdErr
> instead.

Non-zero status to indicate there is nothing to commit has
always been the way for git-status to report since the very
first edition of the command (a3e870f2, May 30 2005), so you
should be able to depend on it.
