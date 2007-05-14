From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Sun, 13 May 2007 18:26:11 -0700
Message-ID: <7vmz08p558.fsf@assigned-by-dhcp.cox.net>
References: <20070512064159.GA7471@coredump.intra.peff.net>
	<200705131235.25281.jnareb@gmail.com>
	<20070514003910.GA6689@coredump.intra.peff.net>
	<200705140250.22478.jnareb@gmail.com>
	<20070514004903.GC6689@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 14 03:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnPKO-0007yj-2X
	for gcvg-git@gmane.org; Mon, 14 May 2007 03:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205AbXENB0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 21:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758435AbXENB0N
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 21:26:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38653 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205AbXENB0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 21:26:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514012613.FKPG6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 21:26:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ypSB1W00g1kojtg0000000; Sun, 13 May 2007 21:26:12 -0400
In-Reply-To: <20070514004903.GC6689@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 13 May 2007 20:49:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47213>

Jeff King <peff@peff.net> writes:

> On Mon, May 14, 2007 at 02:50:22AM +0200, Jakub Narebski wrote:
>
>> -'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
>> +'git-add' [-n] [-v] [-f] [--] <file>...
>> +'git-add' [-n] [-v] [-f] -u [[--] <file>...]
>> +'git-add' (--interactive | -i)
>
> I don't see the point in splitting -u out as its own separate "mode" of
> operation. To me it's conceptually a flag that says "don't add untracked
> files, and remove deleted files". But I don't have a strong opinion (and
> certainly splitting out -i makes sense).

Concurred, and I agree with Jakub that your update to the
description of -u makes it much better.

Thanks, both.
