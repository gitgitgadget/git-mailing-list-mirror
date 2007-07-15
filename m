From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Move git-p4import into contrib directory.
Date: Sun, 15 Jul 2007 15:37:09 -0700
Message-ID: <7vr6n9cmzu.fsf@assigned-by-dhcp.cox.net>
References: <20070715154804.2877361d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Jul 16 00:37:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IACiJ-0000uj-NP
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 00:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbXGOWhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbXGOWhM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 18:37:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64097 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbXGOWhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 18:37:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070715223710.THJW1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 18:37:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Pyd91X00B1kojtg0000000; Sun, 15 Jul 2007 18:37:10 -0400
In-Reply-To: <20070715154804.2877361d.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sun, 15 Jul 2007 15:48:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52595>

Sean <seanlkml@sympatico.ca> writes:

> Having caught up on some list emails, it appears that Git now has a
> much better option for importing from Perforce in the git-p4 front
> end to fast-import.
>
> Is there anyone out there actually even using git-p4import?  It was
> written for a very specific case, by a git wannabe hacker who had
> never used Perforce before, and not intended for inclusion in Git
> proper...
>
> My guess is that it could be removed outright without pain to anyone,
> but as a first step, it could be moved into contrib for 1.5.3.

Well, I am all for reducing the code base all the time ;-).
