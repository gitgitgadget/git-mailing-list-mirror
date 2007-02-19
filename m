From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: removal of "percent done" messages from git pull
Date: Tue, 20 Feb 2007 00:53:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702200053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D5E06B.6020706@lightspeed.com> <tnxr6sm5m2u.fsf@arm.com>
 <Pine.LNX.4.63.0702191611410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsld169cf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:53:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIKP-0000ms-5d
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965561AbXBSXxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965565AbXBSXxu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:53:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:38206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965561AbXBSXxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:53:49 -0500
Received: (qmail invoked by alias); 19 Feb 2007 23:53:48 -0000
X-Provags-ID: V01U2FsdGVkX18w5MM22/Iw6HydJvrddT5cM5V269ZdX/oJ8MwS6s
	fy0g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vsld169cf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40165>

Hi,

On Mon, 19 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Or (as done in StGIT for some messages), only print those interactive
> >> messages when stdout is a tty, i.e. "if (isatty(1))".
> >
> > You mean something like this?
> >
> > --
> > [PATCH] fetch: make things quiet when not outputting to a tty
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Please grep for 'git.fetch-pack' again.  Its output is list of
> object names and the refnames where they live in the remote and
> consumed by the later stages of git-fetch script.

Ouch. Sorry. I'll try to come up with a better patch tomorrow, and I will 
test that, too.

Ciao,
Dscho
