From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make j/k move down/up in gitk (like vi)
Date: Sun, 29 Apr 2007 11:13:16 -0700
Message-ID: <7vejm3dp6r.fsf@assigned-by-dhcp.cox.net>
References: <20070428030215.GZ26786@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 20:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiDth-0003r1-JF
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXD2SNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbXD2SNS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:13:18 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62059 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbXD2SNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 14:13:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429181317.DTYP1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Apr 2007 14:13:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id t6DG1W00C1kojtg0000000; Sun, 29 Apr 2007 14:13:17 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45825>

Bart Trojanowski <bart@jukie.net> writes:

> Currently gitk has i/k bound to move up and down in the commit list.  I
> would like to make that more consistent with vi's j/k.

I kind of second this.  Any program that implements keyboard
navigation and binds directions differently from vi greatly
irritates me.

But it may be just me, who never used wordstar.

> If this is not acceptable, I will investigate a git-config option for vi
> compatibility mode.

I think a sensible way to go would be to allow gitk to read a
custom tcl script from $HOME/.gitk, and make sure when the file
is written back, the custom bindings are stored there as well.
