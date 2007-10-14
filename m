From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 17:23:27 +0200
Message-ID: <20071014152327.GA24003@atjola.homenet>
References: <20071014143628.GA22568@atjola.homenet> <47122D02.9060204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 14 17:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih5Jc-0000ce-UV
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 17:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbXJNPXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 11:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756547AbXJNPXb
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 11:23:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:51147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756293AbXJNPXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 11:23:31 -0400
Received: (qmail invoked by alias); 14 Oct 2007 15:23:29 -0000
Received: from i577BAEEF.versanet.de (EHLO localhost) [87.123.174.239]
  by mail.gmx.net (mp043) with SMTP; 14 Oct 2007 17:23:29 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+ThA1yxDeTYCjpZKeUudE2VmSNvzUEiqZfO47wfl
	rpdaX9m4cqQ6rK
Content-Disposition: inline
In-Reply-To: <47122D02.9060204@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60857>

On 2007.10.14 16:51:46 +0200, Andreas Ericsson wrote:
> Bj=F6rn Steinbrink wrote:
>> I tried all git releases from 1.5.3 to 1.5.3.4 as well as the curren=
t
>> master and all of them crashed. A small shell script to reproduce th=
e
>> problem is attached.
>
> Manual bisect? Ugh. This *is* the century of the competent developer
> tools, you know... ;-)

Then, how do I search for a good version with git bisect if I only have
the one data-point "master is bad"?

All I tried when testing those 5 versions was trying to find a good
version so that I can actually do an automatic bisect. And I stopped at
1.5.3 because I figured that my test-case is probably just pretty
uncommon and was basically always broken.

Another manual "bisect" shows that 1.5.0 also crashes and as 1.4.0
doesn't even want to read my git git repository, I don't intend to go
even further backwards in the history to find a good commit, unless
someone tells me that it is a really good idea or how to automate
finding a good commit in a sane way.

Bj=F6rn
