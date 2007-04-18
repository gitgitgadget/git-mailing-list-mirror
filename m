From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:42:38 -0700
Message-ID: <7vy7kqjw4x.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
	<46250175.4020300@dawes.za.net>
	<Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
	<20070417235649.GE31488@curie-int.orbis-terrarum.net>
	<7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
	<20070418010637.GF31488@curie-int.orbis-terrarum.net>
	<7vejmilbyt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 03:42:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdzBz-0001Yg-Ho
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 03:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161417AbXDRBmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 21:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbXDRBmk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 21:42:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56376 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161417AbXDRBmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 21:42:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418014240.NJZZ1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 21:42:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oRid1W00v1kojtg0000000; Tue, 17 Apr 2007 21:42:38 -0400
In-Reply-To: <7vejmilbyt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 17 Apr 2007 18:15:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44852>

Junio C Hamano <junkio@cox.net> writes:

> I do not have much against an optional "only blob id" expansion
> myself, as I do not see any more downside than CRLF expansion in
> it...

Actually, there is one.  Somebody makes a patch against a file
with $id$ expanded.  Gives it to somebody else who is git
challenged and does not have git-apply.  The patch is useless.

So it is not without more downsides than CRLF.
