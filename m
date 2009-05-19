From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Mon, 18 May 2009 18:33:56 -0700
Message-ID: <7vpre5anaz.fsf@alter.siamese.dyndns.org>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
	<200905181536.39508.johan@herland.net>
	<200905182140.29953.markus.heidelberg@web.de>
	<200905182355.21645.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, git@vger.kernel.org,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 19 03:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6EDU-0001dQ-Ij
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 03:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZESBd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 21:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZESBd4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 21:33:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63897 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbZESBdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 21:33:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090519013357.LEXK17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 May 2009 21:33:57 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id tDZw1b00H4aMwMQ03DZwlZ; Mon, 18 May 2009 21:33:56 -0400
X-Authority-Analysis: v=1.0 c=1 a=jpUCGHAuqP8A:10 a=AqR8L7kc4dQA:10
 a=CeZos8cfAAAA:8 a=iLsdlJpzVFg5mSPap8MA:9 a=hpALcvd270dXNUpTpJwjDxHzwxsA:4
 a=8lZzlOcxvREA:10
X-CM-Score: 0.00
In-Reply-To: <200905182355.21645.johan@herland.net> (Johan Herland's message of "Mon\, 18 May 2009 23\:55\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119484>

Johan Herland <johan@herland.net> writes:

> After some thinking, I don't like my original name submodule.<name>.resolve, 
> since ".resolve" sounds more like a merge strategy or conflict resolution 
> method, than a "how to deal with submodule update" choice. I propose 
> submodule.<name>.update instead.

Sounds like a plan, even though I do not necessarily agree with the idea
of automatically rebinding what is at the submodule path every time you
update the toplevel project tree.  And from my point of view, "rebind" (or
"autorebind") would be more appropriate name than "update" (and I would
probably set it to "never").
