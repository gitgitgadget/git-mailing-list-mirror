From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Tue, 24 Jul 2007 14:43:27 -0700
Message-ID: <7v3azdh400.fsf@assigned-by-dhcp.cox.net>
References: <20070723041741.GA22461@midwinter.com>
	<Pine.LNX.4.64.0707231059490.14781@racer.site>
	<46A481B4.7000502@midwinter.com>
	<Pine.LNX.4.64.0707231136530.14781@racer.site>
	<46A48949.1020501@midwinter.com>
	<7vfy3fkpr8.fsf@assigned-by-dhcp.cox.net>
	<46A5EA2D.1030707@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDSAG-0000SA-Vi
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbXGXVn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbXGXVn3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:43:29 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:60446 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbXGXVn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 17:43:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724214326.UHSF1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 17:43:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TZjT1X00M1kojtg0000000; Tue, 24 Jul 2007 17:43:28 -0400
In-Reply-To: <46A5EA2D.1030707@midwinter.com> (Steven Grimm's message of "Tue,
	24 Jul 2007 20:01:49 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53651>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
> ...
>> I am more worried about how this should interact with cases
>> where you usually do not start the log message from scratch.
>> For example, are there cases / policies where being able to use
>> templates to leave comments on merge commits are needed?
>> Squash-commits?  Perhaps "apply this template but only when you
>> have hand resolved a conflicting merges"?
>>
>
> Those are all valid cases. They also happen to be ones that are not
> personally useful to me; none of the stuff in my company's commit
> template would really apply to merges. I'm happy to do it if you think
> those cases need to be handled before this can go in, but given
> there's at least one user out there who doesn't need those things, I
> wonder if this makes more sense to hold off on until someone actually
> asks for it.
> ...
> Is your hunch about the common case different than mine? Again, I can
> go address this if it'll actually be useful.

No, I am way more cunning and lazy than that.  I did not have
hunch about the common case, so I just had you (and anybody else
who would join the thread) do necessary thinking and guessing
for me ;-)
