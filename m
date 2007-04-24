From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitattributes
Date: Tue, 24 Apr 2007 10:15:32 -0700
Message-ID: <7vy7kh66dn.fsf@assigned-by-dhcp.cox.net>
References: <1f6632e50704240436l4a81d8c9s1bbf95a7892db68c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Matthias Kestenholz" <lists@spinlock.ch>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOdP-0004r9-UU
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbXDXRP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbXDXRP4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:15:56 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61676 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbXDXRPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:15:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424171532.JPEY1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 13:15:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id r5FY1W0081kojtg0000000; Tue, 24 Apr 2007 13:15:33 -0400
In-Reply-To: <1f6632e50704240436l4a81d8c9s1bbf95a7892db68c@mail.gmail.com>
	(Matthias Kestenholz's message of "Tue, 24 Apr 2007 13:36:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45472>

"Matthias Kestenholz" <lists@spinlock.ch> writes:

> The .gitattributes system together with input/output filters has already
> proven exceptionally useful for me. I've got some co-workers which
> do not seem to care about CRLF line endings or whitespace damage.
>
> core.autocrlf = input
>
> and
>
> [filter "whitespace"]
>  clean = stripspace
>  smudge = cat

You shouldn't need to say "smudge = cat"; if it does not work
without that line you found a bug, so please report.
