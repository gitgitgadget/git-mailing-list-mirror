From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 11/16] git-fetch: skip empty arguments
Date: Fri, 18 May 2007 15:33:12 -0700
Message-ID: <7vmz014v9z.fsf@assigned-by-dhcp.cox.net>
References: <11795163053812-git-send-email-skimo@liacs.nl>
	<117951630747-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpB0i-00059X-LV
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524AbXERWdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbXERWdQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:33:16 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65484 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbXERWdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:33:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518223313.NMVX19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 18:33:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0mZC1X00N1kojtg0000000; Fri, 18 May 2007 18:33:13 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47670>

skimo@liacs.nl writes:

> From: Sven Verdoolaege <skimo@kotnet.org>
>
> This makes it easier for scripts to call git-fetch with options
> that may or may not be set.

For git-fetch it does not matter as I do not think there is any
valid case to pass an empty string as a parameter to it (even
"fetch from our own repository" requires a single dot).  But
from discipline point of view, I am not happy about this.

If you are talking about shell scripts, the standard way to do
that is to say ${1+"$1"}.
