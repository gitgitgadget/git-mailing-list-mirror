From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove hash in git-describe in favor of util slot.
Date: Sun, 14 Jan 2007 21:08:58 -0800
Message-ID: <7vvej8ev11.fsf@assigned-by-dhcp.cox.net>
References: <20070115031655.GA11809@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhq-0006Ud-PB
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:14 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8y-0003eK-GF
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbXAOFJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 00:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbXAOFJA
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 00:09:00 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39937 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbXAOFJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 00:09:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070115050859.KRFZ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Mon, 15 Jan 2007 00:08:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id BH9F1W0161kojtg0000000; Mon, 15 Jan 2007 00:09:16 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070115031655.GA11809@spearce.org> (Shawn O. Pearce's message
	of "Sun, 14 Jan 2007 22:16:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36812>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Currently we don't use the util field of struct commit but we want
> fast access to the highest priority name that references any given
> commit object during our matching loop.  A really simple approach
> is to just store the name directly in the util field.

That's the right thing to do, I would agree.
