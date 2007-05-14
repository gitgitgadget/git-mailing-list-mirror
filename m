From: Jim Meyering <jim@meyering.net>
Subject: Re: committing selected 'changed' or 'added' files works, but not 'removed'
Date: Mon, 14 May 2007 14:48:53 +0200
Message-ID: <87646vh8p6.fsf@rho.meyering.net>
References: <87y7jsgcag.fsf@rho.meyering.net>
	<7viravonmj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 14:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnZz2-00040n-OS
	for gcvg-git@gmane.org; Mon, 14 May 2007 14:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbXENMsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbXENMsz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 08:48:55 -0400
Received: from mx.meyering.net ([82.230.74.64]:57812 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbXENMsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 08:48:55 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id DB3B32CA9F; Mon, 14 May 2007 14:48:53 +0200 (CEST)
In-Reply-To: <7viravonmj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 14 May 2007 00\:44\:36 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47235>

Junio C Hamano <junkio@cox.net> wrote:
> You could do something like this...
...
> -- >8 --
> git-commit: Allow removal to be partially committed as well
>
> We allow partial commit of modified and added files but never
> handled removed files.  This hacks it around.

Nice!  Thanks for the quick patch.
I liked the test cases :-)
