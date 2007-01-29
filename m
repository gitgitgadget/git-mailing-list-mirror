From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git blame --progress
Date: Mon, 29 Jan 2007 11:06:41 -0800
Message-ID: <7vr6td7iv2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<45BCB273.7010601@lsrfire.ath.cx>
	<7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>
	<7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
	<45BD40AE.9020603@lsrfire.ath.cx>
	<7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
	<20070129181207.GA29451@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Alex Riesen" <raa.lkml@gmail.com>
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 20:07:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBbqY-0004Wj-1L
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 20:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbXA2TGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 14:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbXA2TGn
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 14:06:43 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57645 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbXA2TGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 14:06:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070129190641.VIKS29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Mon, 29 Jan 2007 14:06:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id H7701W00w1kojtg0000000; Mon, 29 Jan 2007 14:07:01 -0500
In-Reply-To: <20070129181207.GA29451@moooo.ath.cx> (Matthias Lederhofer's
	message of "Mon, 29 Jan 2007 19:12:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38090>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> With  --progress option, the command shows a fairly useless but
>> amusing eye-candy while making the user wait.
>
> Looks nice :)  It makes it much more comfortable to wait for the real
> output.  Perhaps there should be a config option to enable the
> eye-candy when git-blame is run on a terminal (e.g. (configoption &&
> stdout is a tty && stderr is a tty) || --progress)?  Typing --progress
> is annoying.
>
> I also noticed that git-blame with --progress is slowed down a bit by
> the terminal here; the output on stderr was ~400kb.

Easy, that was not a serious patch meant for inclusion.

If somebody wants to polish it up and re-submit that is fine by
me.  It might be interesting to add colors, make it less
dependent on ANSI terminal control, and handle half-dots more
intelligently.
