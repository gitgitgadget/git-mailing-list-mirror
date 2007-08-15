From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge-recursive: do not rudely die on binary merge
Date: Tue, 14 Aug 2007 17:07:18 -0700
Message-ID: <7vps1paceh.fsf@assigned-by-dhcp.cox.net>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	<20070814231422.GA10662@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 02:07:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL6Q4-0007jT-Dk
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 02:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbXHOAHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 20:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755713AbXHOAHW
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 20:07:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37641 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbXHOAHV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 20:07:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070815000719.KJPI5405.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 20:07:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c07J1X00H1kojtg0000000; Tue, 14 Aug 2007 20:07:19 -0400
In-Reply-To: <20070814231422.GA10662@pe.Belkin> (Chris Shoemaker's message of
	"Tue, 14 Aug 2007 19:14:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55866>

Chris Shoemaker <c.shoemaker@cox.net> writes:

> Very nice. Thanks, Junio.  As an additional convenience, it would be
> nice to make the "theirs" version easily accessible.

People should learn this command.  Really.

	$ git cat-file -p :$n:path

where $n == 2 is ours, $n == 1 is common ancestor, and $n == 3
is theirs.
