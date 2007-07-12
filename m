From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-log --follow?
Date: Thu, 12 Jul 2007 11:45:40 -0700
Message-ID: <7vsl7ttq97.fsf@assigned-by-dhcp.cox.net>
References: <20070704203541.GA13286@artemis.corp>
	<7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
	<7vsl7uvx8v.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707121026080.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93fs-0004dJ-I8
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbXGLSpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758117AbXGLSpn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:45:43 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58869 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540AbXGLSpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:45:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712184541.WKOV1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 14:45:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nilg1X00h1kojtg0000000; Thu, 12 Jul 2007 14:45:41 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52319>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 12 Jul 2007, Junio C Hamano wrote:
>> 
>> I think this is just a testament that "following renames" is not
>> as useful in a real project as people seem to believe, not a
>> real complaint.
>
> Yeah. That said, what you wanted would have actually worked with my 
> original strange patch to "git blame", and in particular that also would 
> allow you to get a "log" for certain lines in the file.

Yeah, I just tried the blame from 'pu' (I have been carrying
that original patch from you there).  The output is not very
intuitive in that it talks about each commit but it is not
apparent _why_ the command talks about that commit.  Maybe
adding "there are the lines in the final image of the blob you
are blaming that came from this commit" to the output would make
the output easier to read.
