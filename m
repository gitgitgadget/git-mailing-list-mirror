From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fetch will leave a ref pointing to a tag
Date: Mon, 02 Jul 2007 16:11:29 -0700
Message-ID: <7v4pkmwgda.fsf@assigned-by-dhcp.cox.net>
References: <20070702194437.19202.qmail@science.horizon.com>
	<Pine.LNX.4.64.0707022207420.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:11:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5V3Q-00086c-Bn
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075AbXGBXLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757096AbXGBXLc
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:11:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36106 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062AbXGBXLa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:11:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702231131.PYTT3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 19:11:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnBV1X00C1kojtg0000000; Mon, 02 Jul 2007 19:11:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51424>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 2 Jul 2007, linux@horizon.com wrote:
>
>> $ git branch temp tags/v2.6.22-rc6
>> $ git fetch . tags/v2.6.22-rc7:temp
> ...
> No. It is perfectly sane to fetch a tag, and to store it.

Yes, but not to a branch.

Anything under refs/heads/ should point at a commit and if we
allowed a tag to be pointed at, you probably can argue that is a
bug.
