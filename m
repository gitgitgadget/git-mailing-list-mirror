From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Fri, 2 Mar 2007 20:21:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
 <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070302162136.GA9593@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-737627751-1172863277=:22628"
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNDJl-0006Yr-DD
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbXCBTVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbXCBTVW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:21:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:53329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965145AbXCBTVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:21:22 -0500
Received: (qmail invoked by alias); 02 Mar 2007 19:21:20 -0000
X-Provags-ID: V01U2FsdGVkX1/R8YVAzxbR+V3YsdYJ9M4OaeNSRQxl+4m7bJ1/gq
	L69Y3BdYIt650G
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070302162136.GA9593@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41237>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-737627751-1172863277=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 2 Mar 2007, Karl Hasselström wrote:

> However, given that your file timestamps have been bumped (without file 
> content changes),

There were changes. Only that they have been taken back, but that is 
_another_ change.

> it's a performance bug in your make tool if this causes it to needlessly 
> rebuild half the known universe. (Fixing the bug by using content hashes 
> to detect changes may or may not be a good trade-off, depending on your 
> workflow.)

Getting dependencies right is sometimes not very easy. I participate in 
projects which have _seriously_ broken dependencies. In these cases, I do 
a quick "touch source.c" to force a recompilation.

You'd break this workaround.

Ciao,
Dscho

P.S.: yes, I know I could possibly find the object file and remove that, 
too. But finding the source is often easier.

---1148973799-737627751-1172863277=:22628--
