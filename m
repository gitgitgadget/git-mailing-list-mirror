From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 07 Feb 2007 16:50:44 -0800
Message-ID: <7vmz3p321n.fsf@assigned-by-dhcp.cox.net>
References: <17866.20355.744025.133326@lisa.zopyra.com>
	<Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
	<7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
	<7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
	<7v8xf94hq1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702080140230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HExUv-000211-JZ
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161498AbXBHAuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161503AbXBHAuq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:50:46 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:46329 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161498AbXBHAup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:50:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208005045.TWDM1306.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 19:50:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Loql1W0031kojtg0000000; Wed, 07 Feb 2007 19:50:45 -0500
In-Reply-To: <Pine.LNX.4.63.0702080140230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 8 Feb 2007 01:41:39 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39024>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Well, you would not know if the user gave you '-g' before you
>> ask setup_revisions() to parse the options, and once you let it
>> do its thing, you would not know if it also found an explicit
>> output format given by the end user, so your cannot sanely make
>> default depend on '-g'.
>> 
>> I suspect that it would have to be either somewhat involved or
>> outright hacky.  
>
> Well, we could always make CMIT_FMT_DEFAULT _not_be the same as _MEDIUM, 
> and if it still is the same _after_ parsing the options, set it to MEDIUM 
> explicitely. Same goes for the abbrev thing.

I think we are in agreement.  I showed an outright hacky one
because I am not ready to do somewhat involved one at the end of
the rc period.
