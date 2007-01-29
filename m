From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git blame --progress
Date: Mon, 29 Jan 2007 19:12:07 +0100
Message-ID: <20070129181207.GA29451@moooo.ath.cx>
References: <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <45BCB273.7010601@lsrfire.ath.cx> <7v4pqbezo9.fsf@assigned-by-dhcp.cox.net> <7vzm83dkw4.fsf@assigned-by-dhcp.cox.net> <45BD40AE.9020603@lsrfire.ath.cx> <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 19:12:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBazH-0004Yj-2K
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 19:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbXA2SMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 13:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbXA2SMM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 13:12:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:39230 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752042AbXA2SML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 13:12:11 -0500
Received: (qmail invoked by alias); 29 Jan 2007 18:12:09 -0000
Received: from pD9EB9B70.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.155.112]
  by mail.gmx.net (mp019) with SMTP; 29 Jan 2007 19:12:09 +0100
X-Authenticated: #5358227
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38089>

Junio C Hamano <junkio@cox.net> wrote:
> With  --progress option, the command shows a fairly useless but
> amusing eye-candy while making the user wait.
Looks nice :)  It makes it much more comfortable to wait for the real
output.  Perhaps there should be a config option to enable the
eye-candy when git-blame is run on a terminal (e.g. (configoption &&
stdout is a tty && stderr is a tty) || --progress)?  Typing --progress
is annoying.

I also noticed that git-blame with --progress is slowed down a bit by
the terminal here; the output on stderr was ~400kb.
