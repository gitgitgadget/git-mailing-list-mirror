From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log -S problem
Date: Mon, 21 May 2007 00:34:42 -0700
Message-ID: <7vmyzyfx4d.fsf@assigned-by-dhcp.cox.net>
References: <200705202115.39325.johannes.sixt@telecom.at>
	<7vy7jjjjdm.fsf@assigned-by-dhcp.cox.net>
	<200705210727.23898.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@eudaptics.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon May 21 09:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2Pp-0000GW-6n
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbXEUHeo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbXEUHeo
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:34:44 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52969 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbXEUHen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:34:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521073444.ZAPU19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 21 May 2007 03:34:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1jai1X0091kojtg0000000; Mon, 21 May 2007 03:34:43 -0400
In-Reply-To: <200705210727.23898.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Mon, 21 May 2007 07:27:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47982>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Sunday 20 May 2007 23:05, Junio C Hamano wrote:
>> Johannes Sixt <johannes.sixt@telecom.at> writes:
>> > I had expected that the set of commits found by the second search string
>> > are a proper superset of those found by the first one. What's wrong here?
>> > Why does a search for 'merge-base' not find occurences of
>> > 'builtin-merge-base'?
>>
>> 71dfbf224 removes one line that has "git-merge-base$X" and adds
>> one line that has "builtin-merge-base.o".  If you count the
>> number of occurences of substring "builtin-merge-base" in the
>> preimage and the postimage, you see one addition.  If you count
>> the same for substring "merge-base", the net difference is 0.
>
> But is this how -S is *designed* to work? 

http://thread.gmane.org/gmane.comp.version-control.git/14869/focus=14871

For the design background, 

http://thread.gmane.org/gmane.comp.version-control.git/6214
