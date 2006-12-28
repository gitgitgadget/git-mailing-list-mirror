From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] t9200-git-cvsexportcommit.sh: quiet down commit
Date: Thu, 28 Dec 2006 01:24:51 -0800
Message-ID: <7vfyb0wexo.fsf@assigned-by-dhcp.cox.net>
References: <11672970521665-git-send-email-normalperson@yhbt.net>
	<11672970542015-git-send-email-normalperson@yhbt.net>
	<11672970561224-git-send-email-normalperson@yhbt.net>
	<11672970581666-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 10:24:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrVQ-0003iX-Sr
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWL1JYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWL1JYx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:24:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48883 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964995AbWL1JYw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:24:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228092452.BRZE16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 04:24:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 49R51W0071kojtg0000000; Thu, 28 Dec 2006 04:25:06 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11672970581666-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Thu, 28 Dec 2006 01:10:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35551>

Eric Wong <normalperson@yhbt.net> writes:

> Also, fixed an unportable use of 'export'.

As a traditionalist, I tend to prefer "var=val; export var" over
"export var=val" myself, but I wonder how unportable this is
these days.

Just wondering, no objection.

Do you have a specific shell in mind that groks other constructs
used in our tests but not "export var=val" form?
