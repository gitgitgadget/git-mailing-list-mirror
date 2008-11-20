From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 15:07:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811201506390.30769@pacific.mpi-cbg.de>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <20081120132107.GA27571@piper.oerlikon.madduck.net> <20081120133546.GA6023@codelibre.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3A5v-00022m-JR
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbYKTN7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbYKTN7t
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:59:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:39645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754746AbYKTN7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:59:48 -0500
Received: (qmail invoked by alias); 20 Nov 2008 13:59:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 20 Nov 2008 14:59:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19K/BFXjmdKvFvxyo+Be8c7Qi7SzDidrwYTJk6OEj
	nB4De3XeJRJHTu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081120133546.GA6023@codelibre.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101435>

Hi,

On Thu, 20 Nov 2008, Roger Leigh wrote:

> They are optional build depdendencies.  They are provided pre-built, and 
> won't be rebuilt unless they get outdated.  In the release tarball, the 
> timestamps are correct, ensuring this never happens. When checking out 
> with git, the timestamps are incorrect, and it attempts to rebuild 
> something that's *already built*.

I'll try just one more time.  Why don't you teach your build process to 
check if the generated files can be generated, and if not, fall back to 
the committed ones?

Ciao,
Dscho
