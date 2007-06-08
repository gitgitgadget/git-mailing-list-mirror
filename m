From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] filter-branch: support skipping of commits more easily
Date: Thu, 07 Jun 2007 23:40:53 -0700
Message-ID: <7vzm3bkky2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706080058160.4046@racer.site>
	<7v7iqfnuo3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0706080455440.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 08:41:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwY9b-0001Mj-RK
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 08:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298AbXFHGkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 02:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756698AbXFHGky
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 02:40:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33623 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbXFHGky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 02:40:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608064054.RYIC29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 02:40:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8ugt1X0061kojtg0000000; Fri, 08 Jun 2007 02:40:53 -0400
In-Reply-To: <Pine.LNX.4.64.0706080455440.4046@racer.site> (Johannes
	Schindelin's message of "Fri, 8 Jun 2007 05:17:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49440>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > IOW, given A-B-C, if commit-filter says "skip" upon B, the rewritten 
>> > branch will look like this: A'-C'.
>> >
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> >
>> > 	Of course, if you think of "patchsets", this behaviour might
>> > 	be unexpected, since the children will still contain everything
>> > 	which was changed in the skipped revisions, and not changed in
>> > 	_them_.
>> 
>> I think that is fine; in effect, by saying "skip" B, you are
>> squashing B-C into C'.
>> ... 
>> I am not objecting; just trying to get a mental picture.
>
> Yeah, but you called it "squash" instead of "skip". So, maybe it should 
> accept "squash" to do that operation instead?

Skip is logically correct, but this does sound like squashing to
me.
