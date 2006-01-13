From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 19:58:20 -0800
Message-ID: <7vek3chj8j.fsf@assigned-by-dhcp.cox.net>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112201646.GA3179@steel.home>
	<BAYC1-PASMTP1298D73139F4BE57D59B97AE260@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 04:58:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExG54-00016j-PG
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 04:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWAMD6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 22:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAMD6Y
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 22:58:24 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:32988 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751092AbWAMD6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 22:58:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113035719.SYYE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 22:57:19 -0500
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP1298D73139F4BE57D59B97AE260@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 12 Jan 2006 21:46:42 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14606>

sean <seanlkml@sympatico.ca> writes:

> ...   In fact, it would seem more
> consistent to tell someone that a From: line will be handled properly
> whether they use git-am or git-commit. 

Yuck.

Somebody using am/applymbox is not writing that "From: " line
himself.  The person who writes that "From: " line writes that
into his MUA when sending a patch --- that is "editing an
email", so there is a consistency between that activity and use
of word "From: ".

The editor for commit message does not have anything to do with
e-mail.  What you are talking about is not consistency, but
confusion.
