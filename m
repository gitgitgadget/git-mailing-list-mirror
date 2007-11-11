From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 11:05:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111103240.4362@racer.site>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org>
 <7v4pftip42.fsf@gitster.siamese.dyndns.org> <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrAde-0002dU-RG
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 12:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbXKKLFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 06:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXKKLFs
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 06:05:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:53759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbXKKLFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 06:05:47 -0500
Received: (qmail invoked by alias); 11 Nov 2007 11:05:44 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp037) with SMTP; 11 Nov 2007 12:05:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3nMlWh9e3rA96yhqLn0ICHNUVbROmAtX3hpmNHw
	m3ntoMlTnLXf1T
X-X-Sender: gene099@racer.site
In-Reply-To: <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64445>

Hi,

On Sat, 10 Nov 2007, Ask Bj?rn Hansen wrote:

> For new users the superfluous programs are a burden making it harder to 
> learn how everything works.

This should be a non-issue.  We really should start deprecating 
"git-<command>" in favour of "git <command>" for real.

New users should not even be told that this is correct usage.

My reason?  We have plumbing, and we will always have plumbing, as 
commands.  A regular git user does not _want_ to see that.  Without said 
deprecation she _will_, however.

Ciao,
Dscho
