From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try 2: Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 03 May 2007 16:02:26 -0700
Message-ID: <7vfy6dzf25.fsf@assigned-by-dhcp.cox.net>
References: <463A6930.8090603@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Bryan Larsen <bryan@larsen.st>
X-From: git-owner@vger.kernel.org Fri May 04 01:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjkJj-0000xZ-Gh
	for gcvg-git@gmane.org; Fri, 04 May 2007 01:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbXECXC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 19:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbXECXC2
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 19:02:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64627 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbXECXC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 19:02:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503230226.QCFB1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 19:02:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id un2S1W00Y1kojtg0000000; Thu, 03 May 2007 19:02:27 -0400
In-Reply-To: <463A6930.8090603@larsen.st> (Bryan Larsen's message of "Thu, 03
	May 2007 18:58:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46116>

Bryan Larsen <bryan@larsen.st> writes:

> The perl scripts start with "#!/usr/bin/perl".  There is a mechanism
> PERL_PATH in the Makefile to change this, but it currently doesn't work
> with PERL_PATH="/usr/bin/env perl".

I do not get this whole business.  Why would you even want to
support that to begin with?

The purpose of PERL_PATH is for you to tell git the path you
have your Perl at.  It is not about supplying a small shell
script that lets "env" to figure it out.
