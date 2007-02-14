From: Junio C Hamano <junkio@cox.net>
Subject: Re: Scripts to use "bundles" for moving data between repositories
Date: Wed, 14 Feb 2007 10:00:15 -0800
Message-ID: <7vhctopqkw.fsf@assigned-by-dhcp.cox.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
	<7vlkj0r7f0.fsf@assigned-by-dhcp.cox.net>
	<45D34D58.8050701@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHORm-0001G4-61
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbXBNSAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbXBNSAS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:00:18 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57004 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411AbXBNSAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:00:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214180016.GVJW22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 13:00:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PW0F1W00N1kojtg0000000; Wed, 14 Feb 2007 13:00:15 -0500
In-Reply-To: <45D34D58.8050701@verizon.net> (Mark Levedahl's message of "Wed,
	14 Feb 2007 12:56:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39710>

Mark Levedahl <mdl123@verizon.net> writes:

> That is any easy change. As the dominant content is an already
> compressed pack file, is tar sufficient or should it be a gzip or bzip
> tar?

Plain vanilla would do.  Have you noticed how well they deflate
with your implementation that uses zip?

Also we _might_ want to uuencode (or base85) so that you can
even e-mail a bundle easily.

I am 75% kidding ;-).
