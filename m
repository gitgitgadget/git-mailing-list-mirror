From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow commit (and tag) messages to be edited when $EDITOR
 has arguments
Date: Sun, 16 Dec 2007 01:41:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712160139580.27959@racer.site>
References: <20071216011201.GA10867@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 02:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3iVy-00059W-4k
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 02:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbXLPBle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 20:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbXLPBle
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 20:41:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:53774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753782AbXLPBld (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 20:41:33 -0500
Received: (qmail invoked by alias); 16 Dec 2007 01:41:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp007) with SMTP; 16 Dec 2007 02:41:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19isw9o5lpiDwZutxXl/BPYzUGYL3dxY3leE+/U5C
	j8iBu8at5o32aj
X-X-Sender: gene099@racer.site
In-Reply-To: <20071216011201.GA10867@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68424>

Hi,

On Sat, 15 Dec 2007, Steven Grimm wrote:

> 	Looked around but didn't see an existing "build a char* array
> 	out of a delimited string" function in the git source; if one
> 	exists, of course it should be used instead of my pair of loops
> 	here.

Did you look for split_cmdline() in git.c?  IMHO it should move to 
run-command.c and be made public.

Thanks,
Dscho
