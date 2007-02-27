From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 15:35:15 -0800
Message-ID: <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
	<Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227154241.GA8228@thunk.org>
	<Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Wed Feb 28 00:35:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBqr-0002OZ-Oy
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbXB0XfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbXB0XfS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:35:18 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:32900 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbXB0XfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:35:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227233516.TGEA6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 18:35:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UnbF1W00R1kojtg0000000; Tue, 27 Feb 2007 18:35:16 -0500
In-Reply-To: <86vehnnpy2.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Tue, 27 Feb 2007 15:25:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40846>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Theodore" == Theodore Tso <tytso@mit.edu> writes:
>
> Theodore> And I'm still not sure why
>
> Theodore> 	git show v1.5.0..v1.5.0.1 
>
> Theodore> doesn't throw an error, and why it prints what it does...
>
> Wait, that doesn't throw an error?
>
> (tries it)
>
> OK, how is that different from git-diff ?

I do not think there is any difference.  "show" is about
multiple points, not ranges.  "diff" is about multiple
(typically two) points, and not ranges.
