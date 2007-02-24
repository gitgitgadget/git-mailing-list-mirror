From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 17:46:58 -0800
Message-ID: <7vk5y81g4t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm741hfx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702240229540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKm07-0000Vp-MO
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbXBXBrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbXBXBrA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:47:00 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46103 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbXBXBq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:46:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224014659.NOBI3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 20:46:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TDmy1W00s1kojtg0000000; Fri, 23 Feb 2007 20:46:59 -0500
In-Reply-To: <Pine.LNX.4.63.0702240229540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 24 Feb 2007 02:35:25 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40485>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> By the way, where do you start digging from?  From all refs?
>
> Yes, all refs. In order of the date.

Then, another possibly useful extension is "start from this ref"
(you can give multiple and if no such refs are given keep the
current "from all refs" behaviour).
