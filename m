From: Jon Loeliger <jdl@freescale.com>
Subject: Re: New release?
Date: Tue, 06 Jun 2006 11:08:20 -0500
Message-ID: <1149610100.23938.75.camel@cashmere.sps.mot.com>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 18:12:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FneAf-0004aZ-HJ
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 18:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFFQMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 12:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFFQMm
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 12:12:42 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:33929 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751142AbWFFQMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 12:12:42 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k56GSqc9004550;
	Tue, 6 Jun 2006 09:28:52 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k56GC8p0012653;
	Tue, 6 Jun 2006 11:12:09 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21385>

On Tue, 2006-06-06 at 01:02, Junio C Hamano wrote:
> The "next" queue has been shrinking, and nothing is going to
> "maint" branch, which can mean only one thing ;-).

Junio,

If possible, I'd like to consider my (Linus') notion
of the extension to the git protocol supplying the client
hostname as part of a "standard" release like 1.4.0.

We don't necessarily have to agree on how it is used yet,
but if we can get the protocol enhancement into this
release, I think it would make for a good "flag day"
sort of change.

Specifically, I'd like to consider the portion my patch
that passes "\0HOST=%s\0" along with the git: protocol
connection.

Any chance for that?  If you'd like, I work on resubmitting
just those bits with the connect function refactoring
that you outlined.

Thanks,
jdl
