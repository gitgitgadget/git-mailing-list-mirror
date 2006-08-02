From: Junio C Hamano <junkio@cox.net>
Subject: Re: kompare won't parse git diffs
Date: Wed, 02 Aug 2006 12:17:18 -0700
Message-ID: <7vy7u7t0ap.fsf@assigned-by-dhcp.cox.net>
References: <200608021107.43485.andyparkins@gmail.com>
	<Pine.LNX.4.64.0608021006150.4168@g5.osdl.org>
	<eaqpt2$ots$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Wed Aug 02 21:17:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8MDb-0008Hf-R9
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 21:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWHBTRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWHBTRU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 15:17:20 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:14809 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932174AbWHBTRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 15:17:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802191719.SVCV6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 15:17:19 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eaqpt2$ots$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	02 Aug 2006 20:12:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24668>

Jakub Narebski <jnareb@gmail.com> writes:

>> Not only is the git patch format perfectly standard and accepted by other 
>> tools, it's much better designed than the brain-damaged syntax that GNU 
>> patch uses (which adds a tab and a timestamp after the filenames). In 
>> particular, with git patches it is easy to get filenames that have spaces 
>> and tabs in them right. 
>
> What about filenames with end-of-line character in them? Is it quoted?

You could have done a bit of homework yourself to find that out
easily ;-).  Anyway, the answer is yes.

	http://marc.theaimsgroup.com/?l=git&m=112927316408690

I wonder what happened to the plan to update GNU diff/patch to
also emit/understand the c-style quoted paths.  Paul?
