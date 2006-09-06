From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Include local config before platform tweaks
Date: Wed, 06 Sep 2006 00:18:32 -0700
Message-ID: <7vwt8h8nuf.fsf@assigned-by-dhcp.cox.net>
References: <9434EEBD-57BE-46D7-A2FF-069BB960AA44@silverinsanity.com>
	<7vlkoyarnx.fsf@assigned-by-dhcp.cox.net>
	<20060906033151.GB30540@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 09:18:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKrgC-0007Da-4p
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 09:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWIFHSd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 03:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWIFHSd
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 03:18:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12464 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751597AbWIFHSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 03:18:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906071830.JXW26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 Sep 2006 03:18:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JvJN1V0121kojtg0000000
	Wed, 06 Sep 2006 03:18:23 -0400
To: Brian Gernhardt <benji@silverinsanity.com>
In-Reply-To: <20060906033151.GB30540@spearce.org> (Shawn Pearce's message of
	"Tue, 5 Sep 2006 23:31:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26506>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Brian Gernhardt <benji@silverinsanity.com> writes:
>> 
>> > Having config.mak included after the platform tweaks ignores NO_FINK
>> > or NO_DARWIN_PORTS in that file.  Simply including the config earlier
>> > fixes that.
>> 
>> I vaguely recall that this was brought up before, and the
>> conclusion was that the include location is correct but the way
>> darwin bits were done was wrong.  I do not recall the details
>> but does anybody on the list know?
>
> I think we just need to move the NO_FINK stuff below the include;
> like this:

Thanks Shawn.  Brian does Shawn's patch work for you?
