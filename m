From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 13:27:15 -0700
Message-ID: <7vd52vwy1o.fsf@assigned-by-dhcp.cox.net>
References: <20070326073502.GD44578@codelabs.ru>
	<7vwt14xvaw.fsf@assigned-by-dhcp.cox.net>
	<20070326083617.GG13247@spearce.org>
	<7v8xdkxukt.fsf@assigned-by-dhcp.cox.net>
	<17928.7076.871485.136142@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVvmj-00028b-0C
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 22:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbXCZU1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 16:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXCZU1S
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 16:27:18 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52607 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXCZU1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 16:27:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326202716.NTTK18070.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 16:27:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fYTF1W00e1kojtg0000000; Mon, 26 Mar 2007 16:27:16 -0400
In-Reply-To: <17928.7076.871485.136142@lisa.zopyra.com> (Bill Lear's message
	of "Mon, 26 Mar 2007 13:14:44 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43180>

Bill Lear <rael@zopyra.com> writes:

> On Monday, March 26, 2007 at 01:44:34 (-0700) Junio C Hamano writes:
>>"Shawn O. Pearce" <spearce@spearce.org> writes:
>>
>>> Junio C Hamano <junkio@cox.net> wrote:
>>>> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>>>> 
>>>> > Remove unnecessary '-S' option that enabled less to chop long lines.
>>>> > It used to provide some confusion at least for the 'git diff':
>>>> > "Where are my long lines? Are they missed from the patch?".
>>>> 
>>>> It is not "unnecessary", but only "what _you_ are not used to".
>>>> As this breaks expectentions of people already familiar with
>>>> what git does by default, I cannot take this patch.
>>>
>>> Hear hear.  I completely agree with Junio.  I (and a number of
>>> other users that I work with) expect this behevaior by default.
>>
>>Two tips.
>>
>> (1) Learn to use left/right arrow keys under "less -S" if you
>>     have occasional lines that are too long.
>
> Hmm, looking at the code: why, if the environment variable LESS is
> already set, should this all be worth talking about?  Shouldn't the
> user be able to set LESS to whatever they want, once, and be done with
> it?  The current setenv() call to set up the pager does this, correct?

Yes.  That would make the third tip ;-).
