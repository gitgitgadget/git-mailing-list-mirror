From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do I get git-format-patch to ignore changes that remove spaces from the end of the line?
Date: Tue, 13 Feb 2007 14:24:17 -0800
Message-ID: <7vhctpwvam.fsf@assigned-by-dhcp.cox.net>
References: <45D234C5.5090005@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 23:24:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH64U-0006SF-TN
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 23:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbXBMWYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbXBMWYT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 17:24:19 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56434 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbXBMWYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 17:24:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213222416.XVIT4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 17:24:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PAQH1W00N1kojtg0000000; Tue, 13 Feb 2007 17:24:17 -0500
In-Reply-To: <45D234C5.5090005@freescale.com> (Timur Tabi's message of "Tue,
	13 Feb 2007 15:59:33 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39591>

Timur Tabi <timur@freescale.com> writes:

> After I commit my changes, I use git-format-patch to make a patch.  I
> then get deltas like this:
>
>   * Copyright (C) 1996-2005 Paul Mackerras.
> - *
> + *
>   *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
> - *    {engebret|bergner}@us.ibm.com
> + *    {engebret|bergner}@us.ibm.com
>   *
>
> I don't want these deltas in my patch.

You could revert the change to the editor configuration and rely
on "git diff" before committing to point out the whitespace
breakage that you newly introduced to the file.  Then you would
be sending out exactly what you changed.
