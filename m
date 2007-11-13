From: David Brown <git@davidb.org>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 13:49:34 -0800
Message-ID: <20071113214934.GA30950@old.davidb.org>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org> <20071113210354.GD22590@fieldses.org> <alpine.LFD.0.9999.0711131326310.2786@woody.linux-foundation.org> <9e4733910711131344t381b939dg47b5e078c52be3b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3e8-0007G2-06
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760758AbXKMVtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758519AbXKMVtx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:49:53 -0500
Received: from mail.davidb.org ([66.93.32.219]:52323 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756631AbXKMVtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:49:52 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1Is3dW-0008Fy-PN; Tue, 13 Nov 2007 13:49:34 -0800
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <9e4733910711131344t381b939dg47b5e078c52be3b2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64884>

On Tue, Nov 13, 2007 at 04:44:33PM -0500, Jon Smirl wrote:

>A better solution would be for the kernel to log inotify events to
>disk in a manner that survives reboots. When Beagle starts it would
>locate its last checkpoint and then process the logged inotify events
>from that time forward. This inotify logging needs to be bullet proof
>or it will mess up your Beagle index.

Perhaps something similar to FsEvents on OSX which is a daemon that
interfaces with the OS to record this very information.

It only works across clean reboots, but it does work there.  Do a bad
shutdown, and your next backup or index take a long time to go scan
everything.

It would also be wonderful to have this for backups as well.

Dave
