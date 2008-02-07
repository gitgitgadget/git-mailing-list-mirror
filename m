From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Thu, 7 Feb 2008 00:04:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802070002160.8543@racer.site>
References: <alpine.LNX.1.00.0802061141410.13593@iabervon.org> <200802061921.58282.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMuHV-0006G2-8N
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 01:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765332AbYBGAFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 19:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765327AbYBGAFS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 19:05:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:53678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765317AbYBGAFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 19:05:14 -0500
Received: (qmail invoked by alias); 07 Feb 2008 00:05:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp003) with SMTP; 07 Feb 2008 01:05:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AkN07d3YAHIJYsv18hz8OrauLzWQnna7T1UcZon
	Ah15zC7Km9PCF/
X-X-Sender: gene099@racer.site
In-Reply-To: <200802061921.58282.kumbayo84@arcor.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72880>

Hi,

I don't know about you, but with lines...

On Wed, 6 Feb 2008, Peter Oberndorfer wrote:

> On Mittwoch 06 Februar 2008, Daniel Barkalow wrote:
>

like this:

> > -		strlcpy(filename, output_directory, sizeof(filename) -
suffix_len);

... (when the mailer wraps the original line), comments like this...

> > +		len += sprintf(filename + len, "%d", nr);
> maybe this should be !oneline instead?
> > +	else {

... are extremely hard to spot.  You could help people who are too dumb to 
do that easily (such as yours truly), by putting an empty line between 
every text you quote and your comments.

Thanks,
Dscho
