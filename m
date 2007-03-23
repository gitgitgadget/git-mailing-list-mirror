From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors pushing tags in "next"
Date: Thu, 22 Mar 2007 21:18:10 -0700
Message-ID: <7vmz24sid9.fsf@assigned-by-dhcp.cox.net>
References: <7vr6rgsmj2.fsf@assigned-by-dhcp.cox.net>
	<483641.20752.qm@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Fri Mar 23 05:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUbEQ-0006gc-Lb
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 05:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbXCWESP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 00:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbXCWESO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 00:18:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48391 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422673AbXCWESM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 00:18:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323041811.EVKI28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Mar 2007 00:18:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e4JA1W00d1kojtg0000000; Fri, 23 Mar 2007 00:18:10 -0400
In-Reply-To: <483641.20752.qm@web31801.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Thu, 22 Mar 2007 20:35:55 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42902>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>
>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>> > Is this of any concern?
>> 
>> Sorry, I cannot tell without a command line.
>
> Sorry, I didn't include that.  It is:
>
> git-push --tags web
>
>    Luben
>> 
>> > ### Pushing version 'v2.6.21-rc4' to the masses
>> > fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown
>> > revision or path not in the working tree.
>> > Use '--' to separate paths from revisions
>> > fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown

Well, *I* don't say '### Pushing version blah to the masses', so
it's hard to diagnose from this output.  Is it coming from some
of your own script (perhaps update hook on the receiving end)?
