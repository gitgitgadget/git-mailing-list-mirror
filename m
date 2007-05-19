From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git branching & pulling
Date: Fri, 18 May 2007 23:28:13 -0700
Message-ID: <7vveepxr7m.fsf@assigned-by-dhcp.cox.net>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
	<7v8xblz71o.fsf@assigned-by-dhcp.cox.net>
	<7vzm41xsa2.fsf@assigned-by-dhcp.cox.net>
	<464E97A4.4050702@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wink Saville <wink@saville.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat May 19 08:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpIQR-0004eG-Bv
	for gcvg-git@gmane.org; Sat, 19 May 2007 08:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXESG2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 02:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbXESG2P
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 02:28:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48197 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXESG2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 02:28:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519062814.GMAN15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 02:28:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0uUD1X00K1kojtg0000000; Sat, 19 May 2007 02:28:14 -0400
In-Reply-To: <464E97A4.4050702@midwinter.com> (Steven Grimm's message of "Fri,
	18 May 2007 23:22:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47725>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>> I personally never understood why people would just want to say
>> "git pull" without saying anything else, but what described in
>> the DEFAULT BEHAVIOUR section is how it works.
>>
>
> I do that all the time, e.g. when I'm syncing the satellite repo on my
> laptop with the mothership repo in my account on my company's
> server. The satellite only ever talks to the mothership and I am
> always interested in pulling down all the changes I've committed to
> the mothership during the day. So there's really no need to specify
> anything; I always want to keep the two fully in sync, and there's
> never any question about where I'm pulling from.
>
> I do a plain "git pull" in my clone of git.git too. I want all the
> latest updates and I'm only ever fetching them from the official git
> repo.

Ah, if you ever interact with only single remote repository,
then that is certainly a valid reason not to say anything else.

And if you ever interact with only single branch of a single
remote repository while on one branch, the current config scheme
would let you do that on any branch.
