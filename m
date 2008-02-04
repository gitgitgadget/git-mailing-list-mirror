From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 4 Feb 2008 00:24:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802040024030.7372@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
 <7vwsplporv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLp9p-0005H4-MR
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbYBDAZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYBDAZP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:25:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:45053 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754018AbYBDAZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:25:14 -0500
Received: (qmail invoked by alias); 04 Feb 2008 00:25:11 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 04 Feb 2008 01:25:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NBI0lsmsNnIoGcdHrsR7ABhU9KuaVXi4W7vjD02
	Wyc2wmdduBgbTs
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsplporv.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72433>

Hi,

On Sun, 3 Feb 2008, Junio C Hamano wrote:

> "Lars Hjemli" <hjemli@gmail.com> writes:
> 
> > Maybe this as a compromise?
> >
> > 	static char buf[PATH_MAX + 9];  /* "GITDIR: " + "\n"  */
> > ...
> > 	if (!len || buf[len - 1] != '\n')
> > 		return NULL;
> > 	buf[len - 1] = '\0';
> > 	if (prefixcmp(buf, "GITDIR: "))
> > 		return NULL;
> 
> Perhaps that is easier to read.
> 
> For now I haven't picked up any of the "how about this way"
> revisions.

Yeah, I think all my comments have been addressed...  Lars, care to send a 
new version?

Thanks,
Dscho
