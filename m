From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 13:51:43 -0800
Message-ID: <7v1wkbclqo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAEg-0005bz-CE
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXB0Vvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXB0Vvq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:51:46 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49105 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbXB0Vvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:51:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227215144.QWZX6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 16:51:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ulrk1W0031kojtg0000000; Tue, 27 Feb 2007 16:51:44 -0500
In-Reply-To: <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 27 Feb 2007 13:41:35 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40818>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 27 Feb 2007, Johannes Schindelin wrote:
>> 
>> Now, show_date() can print three different kinds of dates: normal,
>> relative and short (%Y-%m-%s) dates.
>> 
>> To achieve this, the "int relative" was changed to "enum date_mode
>> mode", which has three states: DATE_NORMAL, DATE_RELATIVE and
>> DATE_SHORT.
>
> Ack. I think this kind of thing is worth it regardless of any of the other 
> issues (ie the whole "changelog" thing). 

Ack-on-Ack.
