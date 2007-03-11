From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in bundle
Date: Sat, 10 Mar 2007 17:29:44 -0800
Message-ID: <7vy7m4y3cn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
	<45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F2D955.8050800@gmail.com>
	<Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F2F934.8060407@gmail.com>
	<Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 02:30:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQCsu-0004PC-FW
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 02:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbXCKB34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 20:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbXCKB3y
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 20:29:54 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45099 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134AbXCKB3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 20:29:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311012944.VPWA748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Mar 2007 20:29:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZDVk1W00C1kojtg0000000; Sat, 10 Mar 2007 20:29:44 -0500
In-Reply-To: <Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 11 Mar 2007 02:08:04 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41889>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Basically, I am saying that this whole bundle concept is not thought 
> through, that it is too loosely defined, and that it will result in unmet 
> expectations sooner or later. (Which usually means sooner.)

Earlier I thought you said that bundle had a clearly defined
semantics, which I did not quite understand, but now you are
agreeing with me...

> So, either we have to rethink how to handle prerequisites (so that only 
> those are checked which are strictly necessary for _the one_ ref you are 
> updating), or we have to make it _very_ obvious to (human) users of 
> git-bundle that you should _not_ bundle two unrelated -- or only remotely 
> related -- refs into one bundle.

I've been wondering if we can define prereqs per listed head.
