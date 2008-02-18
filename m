From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Mon, 18 Feb 2008 19:42:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181942230.30505@racer.site>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802181627340.30505@racer.site> <7v1w7ap0vo.fsf@gitster.siamese.dyndns.org> <47B9D484.1020304@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRBu2-00036T-7m
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 20:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYBRTnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 14:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbYBRTnK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 14:43:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:48544 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752734AbYBRTnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 14:43:08 -0500
Received: (qmail invoked by alias); 18 Feb 2008 19:43:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 18 Feb 2008 20:43:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pMwZJsblpI9nmankETK175rSf7PGXFK+dpEgVnb
	MZMnjB/KjcJZIb
X-X-Sender: gene099@racer.site
In-Reply-To: <47B9D484.1020304@catalyst.net.nz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74337>

Hi,

On Tue, 19 Feb 2008, Martin Langhoff wrote:

> ?! basename() never touches the disk. I just read it to confirm - 
> $VERSION is 2.74 and I'm somewhat disappointed to find it's not as 
> portable as I'd expect (perhaps it gets hardcoded during install?).

Well, please try for yourself.  If it works for you, then I probably had 
another error in my patch.

Ciao,
Dscho
