From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 12:59:53 +0200
Message-ID: <20060805105953.GA5410@moooo.ath.cx>
References: <20060805031418.GA11102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 13:00:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Jsu-0000B4-Nd
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161595AbWHEK75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 06:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWHEK75
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 06:59:57 -0400
Received: from moooo.ath.cx ([85.116.203.178]:45542 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161481AbWHEK74 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 06:59:56 -0400
To: Jeff King <peff@peff.net>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060805031418.GA11102@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24900>

Jeff King <peff@peff.net> wrote:
> The git-status output can sometimes be very verbose, making it difficult to
> quickly see whether your files are updated in the index. This adds 4 levels
> of colorizing to the status output:
>   - general header (defaults to normal white)
>   - updated but not committed (defaults to green)
>   - changed but not updated (defaults to red)
>   - untracked files (defaults to red)
> The idea is that red things indicate a potential mistake on the part of the
> user (e.g., forgetting to update a file, forgetting to git-add a file).
Perhaps the default values should not use the same color twice? I'd
suggest yellow for changed but not updated.  But well, it's no problem
to change this in my config, I just find it a bit confusing to have
the same color for different things.

> Color support is controlled by status.color and status.color.*. There is no
> command line option, and the status.color variable is a simple boolean (no
> checking for tty output).
Is there any way to do isatty() from shell scripts?
