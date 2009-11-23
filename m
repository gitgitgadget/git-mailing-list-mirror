From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 19:23:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911231916510.4897@intel-tinevez-2-302>
References: <4B0ABA42.1060103@syntevo.com> <200911231845.04325.trast@student.ethz.ch> <4B0AD02E.1040408@syntevo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCdZA-0003f6-P5
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbZKWSXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 13:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbZKWSXA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:23:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:60621 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753062AbZKWSW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 13:22:59 -0500
Received: (qmail invoked by alias); 23 Nov 2009 18:23:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 23 Nov 2009 19:23:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Psypl0n8PM7nnNuHIGUR+4qgCTY4MBYB7UlFN7W
	RRk3tB8iKaehvu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B0AD02E.1040408@syntevo.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133519>

Hi,

On Mon, 23 Nov 2009, Thomas Singer wrote:

> Basically, getting it "somehow" to work on OS X is just one minor step. 
> IMHO Git should standardize on file names in the repository and do the 
> platform-specific conversion independent of any locale setting, if 
> needed.

That is contrary to the design of Git which honors content (byte-wise!) as 
much as possible, and treats file names very much as content.

There were beginnings of supporting OSX' brain-damaged filename mangling, 
but an obnoxious OSX fan worked very hard on trying to defend the OSX 
design and to decry Git's respect for the raw bytes on this list, so hard 
that even the nicest developers had no fun working on this issue anymore.

This little background may help you understand why there is no solution 
implemented in Git yet.  And maybe quite a few developers are reluctant to 
discuss the issue and possible solutions due to said sad story, too.

Ciao,
Dscho
