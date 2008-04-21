From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on Windows, CRLF issues
Date: Mon, 21 Apr 2008 21:07:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Apr 21 22:09:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo2Ji-0003U6-RR
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 22:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757834AbYDUUHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759664AbYDUUHW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 16:07:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:48093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762313AbYDUUHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 16:07:20 -0400
Received: (qmail invoked by alias); 21 Apr 2008 20:07:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp022) with SMTP; 21 Apr 2008 22:07:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zatZhzUxzOt/yHmK2/XET5/sM5j2da7Bs/ViEbw
	0KomWErlTBE3Wy
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80038>

Hi,

On Mon, 21 Apr 2008, Peter Karlsson wrote:

> Now the latests msysgit comes along and (finally!) sets core.autocrlf to 
> true by default.

It is actually nice to hear at least _somebody_ not insulting us for this 
decision.  Thank you!

> How do I handle this without having everyone breaking check-ins? I can't 
> require everyone to do unset core.autocrlf globally. Can I do that with 
> gitattributes?

I think that the only solution to this is (sorry!) to have one single big 
checkin which converts all CR/LF to LF line endings...

Desole,
Dscho
