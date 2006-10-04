From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] gitweb: gitweb.perl: mode change 0755->0644
Date: Wed, 04 Oct 2006 01:14:21 -0700
Message-ID: <7vodssjy5e.fsf@assigned-by-dhcp.cox.net>
References: <20061004071414.88341.qmail@web31812.mail.mud.yahoo.com>
	<20061004074658.GA29964@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 04 10:14:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV1ta-0004ZB-OE
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 10:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030665AbWJDIOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 04:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030653AbWJDIOX
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 04:14:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35063 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030665AbWJDIOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 04:14:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061004081422.CERD2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Oct 2006 04:14:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W8EQ1V00A1kojtg0000000
	Wed, 04 Oct 2006 04:14:24 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20061004074658.GA29964@moooo.ath.cx> (Matthias Lederhofer's
	message of "Wed, 4 Oct 2006 09:46:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28323>

Matthias Lederhofer <matled@gmx.net> writes:

> Luben Tuikov <ltuikov@yahoo.com> wrote:
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> old mode 100755
> What is the reason to do this?  gitweb.perl is a valid perl script and
> can be executed without modification (setting environment variables
> makes this useful).

I made an mistake to make it non-executable in "next", and Luben
is just mimicking my previous typo.  Will fix to make it
executable again.

Sorry about the confusion.
