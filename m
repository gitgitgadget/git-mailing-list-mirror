From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-files -m lists the same file multiple times
Date: Wed, 25 Apr 2007 12:20:32 -0700
Message-ID: <7v8xcgxnun.fsf@assigned-by-dhcp.cox.net>
References: <200704251035.33713.andyparkins@gmail.com>
	<7v8xcgz4ye.fsf@assigned-by-dhcp.cox.net>
	<200704251952.07644.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgn2b-0005Pa-G9
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992978AbXDYTUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992980AbXDYTUe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:20:34 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59665 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992978AbXDYTUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:20:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425192034.TKRV22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 15:20:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rXLY1W00f1kojtg0000000; Wed, 25 Apr 2007 15:20:33 -0400
In-Reply-To: <200704251952.07644.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 25 Apr 2007 19:52:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45548>

Andy Parkins <andyparkins@gmail.com> writes:

> Definitely.  You see I am in the strange position of being able to type 
> faster than I can think, so typing
>
>  git-ls-files -m | xargs git add
>
> Saves me the trouble of engaging my brain :-)

Well, I do not think being able to type faster is so unique.  I
know more than a handful people who share that ;-).

You can use "git add -u" in 1.5.2 ;-)
