From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rename_ref(): only print a warning when config-file update fails
Date: Fri, 06 Apr 2007 17:14:57 -0700
Message-ID: <7v6489hwfy.fsf@assigned-by-dhcp.cox.net>
References: <11758483861506-git-send-email-hjemli@gmail.com>
	<7v1wixkzpz.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580704061653x7e5fd149ud31a8289a4508b54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, "Geert Bosch" <bosch@gnat.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 03:24:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZyal-0007vz-UT
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 02:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933583AbXDGAPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 20:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933575AbXDGAPB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 20:15:01 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48543 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933536AbXDGAO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 20:14:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407001458.SSUN28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 20:14:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k0Ex1W00L1kojtg0000000; Fri, 06 Apr 2007 20:14:58 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43950>

"Lars Hjemli" <hjemli@gmail.com> writes:

>> I wonder if rolling back the rename that was asked is an
>> option.  We would want to keep these low-level things atomic
>> whenever possible.
>
> I was wondering the same thing, i.e. "goto rollback" as an option for
> "error()". But I ended up thinking that rename_ref() shouldn't bother
> with the config file at all (thus my other patch).

I agree that "other patch" is sensible regardless.
