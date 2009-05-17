From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] RESEND: git notes
Date: Sun, 17 May 2009 18:31:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905171826200.26154@pacific.mpi-cbg.de>
References: <cover.1242437696.git.johan@herland.net> <4A0ED68F.6060200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	git@vger.kernel.org, trast@student.ethz.ch, tavestbo@trolltech.com,
	chriscool@tuxfamily.org
To: git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Sun May 17 18:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5jGZ-00077U-03
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 18:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbZEQQbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 12:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbZEQQbA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 12:31:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:33216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751924AbZEQQa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 12:30:59 -0400
Received: (qmail invoked by alias); 17 May 2009 16:30:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 17 May 2009 18:30:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ydh9vvpyYnjcyhJxbkB0nHaPru9F6ZKeTiXq+7q
	pKD6bTFrzHQSMU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A0ED68F.6060200@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119400>

Hi,

On Sat, 16 May 2009, git@drmicha.warpmail.net wrote:

> Johan Herland venit, vidit, dixit 16.05.2009 03:45:
> 
> > Dscho has asked me to take over the responsibility for the js/notes 
> > patch series.
> > 
> > The following is a re-roll and resend of the patch series currently in 
> > pu, plus my own 2 patches for adding support for "-m" and "-F" to "git 
> > notes edit".
> > 
> > On advice from Dscho, I have squashed the current bugfix and cleanup 
> > patches in js/notes into the first 4 "main" patches. As a result the 
> > original 15 + 2 patch series is now down to 5 (4 + 1) patches.
> > 
> > In sum, these 5 patches produce the exact same result as the original
> > js/notes series (plus my 2 patches).

Actually, I would like this series not to go in as-is, as the most 
important obstacle for inclusion into 1.6.2 (IIRC) was that performance 
was pretty lousy.

In the least, it should allow reading fan-out directories, but preferably 
it would even _write_ fan-out directories.

The only tricky part was how to decide which notes to take if there are 
ambiguities, but I think a concatenation (or that shallower paths take 
precedence) are both viable strategies.

> Well, effectively you removed me (and others) from the author list :|

FWIW whenever I squashed other people's patches into mine (and that is not 
limited to the 'notes' branch), I tried to add proper attribution to the 
commit message.  In Open Source, the currency is merit, so attribution is 
important.

Ciao,
Dscho
