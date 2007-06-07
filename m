From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Accept dates before 2000/01/01 when specified as seconds since the epoch
Date: Wed, 06 Jun 2007 22:29:17 -0700
Message-ID: <7vbqfsqqmq.fsf@assigned-by-dhcp.cox.net>
References: <11811175153355-git-send-email-johannes.sixt@telecom.at>
	<7vtztl5vvb.fsf@assigned-by-dhcp.cox.net>
	<46679320.6000309@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwAYp-0003Np-Mc
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 07:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbXFGF3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 01:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbXFGF3U
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 01:29:20 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40367 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbXFGF3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 01:29:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607052919.WCJP7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 Jun 2007 01:29:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8VVH1X00C1kojtg0000000; Thu, 07 Jun 2007 01:29:18 -0400
In-Reply-To: <46679320.6000309@vilain.net> (Sam Vilain's message of "Thu, 07
	Jun 2007 17:09:52 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49355>

Sam Vilain <sam@vilain.net> writes:

>> Perhaps
>> 
>> 	"epoch" [-+] [0-9]+ " " [-+][0-9][0-9][0-9][0-9]
>
> Probably a good idea, though it would break cg-admin-rewritehist.

I was saying "additionally allow that to express timestamp even
before the epoch", and existing cg-admin-rewritehist does not
feed such a string, so I do not know how the additionally
allowed format could break it.  Maybe I am missing something?

In any case, "timestamps after March 1973" patch from j6t is
a good change independent from the above one.
