From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Test "git remote show" and "git remote prune"
Date: Wed, 5 Dec 2007 22:38:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712052237110.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
 <Pine.LNX.4.64.0712051901550.27959@racer.site> <47571F3E.1060903@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J02tz-0007EZ-7S
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 23:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbXLEWjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 17:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXLEWjL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 17:39:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:49860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752356AbXLEWjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 17:39:10 -0500
Received: (qmail invoked by alias); 05 Dec 2007 22:39:08 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp006) with SMTP; 05 Dec 2007 23:39:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GXfZr26LG5Vk9MUhH52xpbPHJWdzI8cxrs8hxGW
	ceYuwkh+0DkUg7
X-X-Sender: gene099@racer.site
In-Reply-To: <47571F3E.1060903@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67208>

Hi,

On Wed, 5 Dec 2007, Ren? Scharfe wrote:

> Johannes Schindelin schrieb:
> > While at it, also fix a few instances where a cd was done outside of a 
> > subshell.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t5505-remote.sh |   34 ++++++++++++++++++++++++++++++++++
> >  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> It seems to me the patch only adds tests, but doesn't fix existing ones. 
> And looking at t5505-remote.sh, every call of cd is already done inside 
> of a subshell, so there doesn't seem to be anything to fix either. :-?

Right.  This comment is from a long time ago, back when I had my own 
(incomplete) t5505-remote.sh.  It was funny to me that Junio chose exactly 
the same name... but his implementation was different ;-)

I agree that this comment is obsolete.

Thanks,
Dscho
