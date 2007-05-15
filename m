From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-am: Clean up the asciidoc documentation
Date: Tue, 15 May 2007 12:00:56 -0700
Message-ID: <7vtzudj4if.fsf@assigned-by-dhcp.cox.net>
References: <1179153893715-git-send-email-frank@lichtenheld.de>
	<11791538941022-git-send-email-frank@lichtenheld.de>
	<7vd513lztp.fsf@assigned-by-dhcp.cox.net>
	<20070515122357.GF5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue May 15 21:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho2H4-0006G7-LE
	for gcvg-git@gmane.org; Tue, 15 May 2007 21:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595AbXEOTA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 15:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757478AbXEOTA7
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 15:00:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62244 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbXEOTA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 15:00:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515190058.IVPB2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 15:00:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zX0x1W00J1kojtg0000000; Tue, 15 May 2007 15:00:57 -0400
In-Reply-To: <20070515122357.GF5272@planck.djpig.de> (Frank Lichtenheld's
	message of "Tue, 15 May 2007 14:23:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47367>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Mon, May 14, 2007 at 05:01:38PM -0700, Junio C Hamano wrote:
>> Frank Lichtenheld <frank@lichtenheld.de> writes:
>> 
>> >  -i, --interactive::
>> > -	Run interactively, just like git-applymbox.
>> > +	Run interactively, just like `git-applymbox` (see gitlink:git-applymbox[1]).
>> 
>> This is an unclear description from the original, but I think we
>> should say just like `git-applybox -i`, or drop this altogether.
>
> Hmm, your comment doesn't make any sense to me, because applymbox has
> no -i option.

Ah, my braino.  Thanks.

We are not encouraging applymbox to new users anyway, so I'd
just drop the whole ", just like" business.
