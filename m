From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 05 Jan 2007 11:05:41 -0800
Message-ID: <7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	<Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	<7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	<7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 20:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2uNu-0004Yu-2v
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 20:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbXAETFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 14:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbXAETFm
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 14:05:42 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35068 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422682AbXAETFm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 14:05:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105190541.ELME20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 14:05:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7X4s1W01F1kojtg0000000; Fri, 05 Jan 2007 14:04:53 -0500
To: "Chris Lee" <chris133@gmail.com>
In-Reply-To: <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
	(Chris Lee's message of "Fri, 5 Jan 2007 09:19:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36012>

"Chris Lee" <chris133@gmail.com> writes:

> Using git-verify-pack from master does not fail. It actually does
> verify the pack (after a pretty decent wait.) I should have tried
> master first before sending out the first mail. :)

Depends on which "master" -- I pushed out the "chuncked hashing"
fix on "master" as commit 8977c110 as part of the update last
night.

> Junio: Did you still want me to try those steps with that patch
> anyway, even though it works on master?

It would give us a confirmation that the above actually fixes
the problem, if your 1.4.1 fails to verify that same new pack
you just generated, on which you saw that the "master" (assuming
you mean the one with the above patch) works correctly.

If your "master" before 8977c110 already passes, then there is
something else going on, which would be worrysome.
