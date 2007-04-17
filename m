From: Junio C Hamano <junkio@cox.net>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Tue, 17 Apr 2007 14:24:53 -0700
Message-ID: <7v8xcqofru.fsf@assigned-by-dhcp.cox.net>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
	<200704161003.07679.andyparkins@gmail.com>
	<7vwt0crts2.fsf@assigned-by-dhcp.cox.net>
	<200704162155.25114.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdvAZ-0000Qk-BO
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXDQVYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbXDQVYz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:24:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37535 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXDQVYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:24:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417212455.HLOE1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 17:24:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oMQt1W00G1kojtg0000000; Tue, 17 Apr 2007 17:24:54 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44831>

Andy Parkins <andyparkins@gmail.com> writes:

> However, it's missing the point to take my example as an unsolved 
> problem - there are plenty of ways I can get what I want; I brought it 
> up merely as a counter to the statement that there were no valid 
> situations for wanting keyword expansion.

That's actually quite different from what you said.

Andy Parkins <andyparkins@gmail.com> writes:

> Of course there is a reason - the file I edit is the SVG
> itself, in inkscape while editing that file I press "print" to
> get a print out.  Why on earth would I want to jump through
> hoops by closing the file I'm editing, running some export
> script to a temporary file that I don't want, then open up
> Inkscape again, check the export looks okay and then print -
> on what planet is /that/ simpler?

You were claiming that with built-in keyword expansion what you
want becomes /simpler/.  I questioned that.

Maybe it's just me, who is not a GUI person [*1*], but to me,
having to start inkscape, mouse around to find the "Print"
button and print feels much more cumbersome than simply typing
"make print".

[Footnote]

*1* Not in the sense I do not program GUIy applications, but in
the sense that I do not usually _use_ GUI applications.
