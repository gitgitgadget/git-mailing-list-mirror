From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: mergetool fails on gitignore:d files
Date: Sun, 31 May 2009 19:04:01 -0700
Message-ID: <7vk53wogku.fsf@alter.siamese.dyndns.org>
References: <e87cdfda0905300830t6b332533g9a4298f6b8005b9e@mail.gmail.com>
	<20090530215418.GA19241@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Sandberg <mandolaerik@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 04:04:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAwss-0003aE-GO
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 04:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbZFACEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 22:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZFACEB
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 22:04:01 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52220 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbZFACEA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 22:04:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601020401.UUWQ18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 May 2009 22:04:01 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id yS411b00D4aMwMQ03S417Z; Sun, 31 May 2009 22:04:01 -0400
X-Authority-Analysis: v=1.0 c=1 a=dVn6bHWbdvAA:10 a=d6Ba7Pab9WwA:10
 a=PKzvZo6CAAAA:8 a=EahY2xKc4gF1h1vfiuoA:9 a=NIcfzTN_ECHEKqYQY8rsHBXsNE4A:4
 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120442>

Jeff King <peff@peff.net> writes:

> Actually, I think the problem is not in mergetool at all, but with the
> dir.c code underlying "git add". "git add" really should not be
> complaining, because you are not adding a new path at all, but are
> rather adding content to a tracked path.

Correct, and thanks.
