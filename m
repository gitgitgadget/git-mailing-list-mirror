From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Missing pieces for 1.6.0 on MinGW?
Date: Sun, 3 Aug 2008 12:45:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808031239110.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org> <1217754985.4895776973fda@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 12:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPb2k-0007xo-39
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 12:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYHCKl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 06:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbYHCKl2
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 06:41:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:51884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751118AbYHCKl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 06:41:27 -0400
Received: (qmail invoked by alias); 03 Aug 2008 10:41:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 03 Aug 2008 12:41:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QvE0qrdMQ1GxO7+82dtmUowAvnMKjaN1cc7emtv
	cPrA44oDOIPXOl
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1217754985.4895776973fda@webmail.nextra.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91225>

Hi,

On Sun, 3 Aug 2008, Johannes Sixt wrote:

> (2) the non-builtins in $(bindir) don't set argv0_path, and consequently 
> don't find ETC_GITCONFIG.
> 
> (3) the 'mingw_main undefined' error is still a mystery. I'm about to 
> send a preprocessed file to Steffen (it's a bit large, even compressed, 
> so I'll do that in a private mail).

For both issues, IMHO Steve's patches should be superior, as they (with my 
proposed lookup_program_in_path()) would not only make relative 
ETC_GITCONFIG work on MinGW, but everywhere else, too.  Obsoleting 
mingw_main, of course.

Ciao,
Dscho
