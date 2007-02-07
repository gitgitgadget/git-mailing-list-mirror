From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log filtering
Date: Wed, 07 Feb 2007 13:09:22 -0800
Message-ID: <7vps8l65fh.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
	<Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64ad7l12.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:09:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEu2i-0006uF-K7
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbXBGVJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbXBGVJY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:09:24 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61869 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422753AbXBGVJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:09:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207210922.TXTR1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 16:09:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ll9N1W00g1kojtg0000000; Wed, 07 Feb 2007 16:09:23 -0500
In-Reply-To: <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 7 Feb 2007 13:03:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38968>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 7 Feb 2007, Junio C Hamano wrote:
>> 
>> This is very tempting but, ... hmmmm...
>
> I would actually prefer to have it be some marker on the expression 
> itself.
>
> We already do that '^' handling by hand for "author"/"committer" things. 
> We could do other things like that.
>
> Although I guess the downside of not doing standard regexps would be too 
> big.
>
> 		Linus

We could go pcre and let you say "(?i)".  That would all be post
1.5.0, though.
