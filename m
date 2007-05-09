From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Wed, 09 May 2007 08:15:15 -0700
Message-ID: <7vtzumuiyk.fsf@assigned-by-dhcp.cox.net>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
	<11786309073709-git-send-email-tytso@mit.edu>
	<11786309072612-git-send-email-tytso@mit.edu>
	<11786309071033-git-send-email-tytso@mit.edu>
	<Pine.LNX.4.64.0705090056231.18541@iabervon.org>
	<7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
	<46418E24.9020309@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed May 09 17:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlnsw-0007vA-6O
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbXEIPPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755981AbXEIPPS
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:15:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60321 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771AbXEIPPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:15:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509151517.HITX24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 11:15:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x3FF1W00i1kojtg0000000; Wed, 09 May 2007 11:15:16 -0400
In-Reply-To: <46418E24.9020309@midwinter.com> (Steven Grimm's message of "Wed,
	09 May 2007 02:02:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46725>

Steven Grimm <koreth@midwinter.com> writes:

> -Steve (who suspects this is a "yes, we talked this over early in
> git's history" question, but what the heck)

AFAICR, the answer is "heck, we have never bothered about such
low level implementation details as gzip has been good enough
for us.  If you feel so inclined, go wild."
