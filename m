From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix display overlap between remote and local progress
Date: Sun, 4 Nov 2007 13:33:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041331520.4362@racer.site>
References: <alpine.LFD.0.9999.0711032328490.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:34:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iofcd-0001lS-Fh
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 14:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbXKDNeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 08:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbXKDNeZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 08:34:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:48570 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753323AbXKDNeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 08:34:24 -0500
Received: (qmail invoked by alias); 04 Nov 2007 13:34:22 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp037) with SMTP; 04 Nov 2007 14:34:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ncrNNVUTnatz3u+JLmcQXUgicUHTqUUMJ0nn9qp
	2mXrqBFFJar8q+
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0711032328490.21255@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63400>

Hi,

On Sun, 4 Nov 2007, Nicolas Pitre wrote:

> +#define SUFFIX "\e[K"  /* change to "        " if ANSI sequences don't work */ 

I am almost certain (without even testing) that cmd.exe has problems with 
that.  It does not even understand colorisation.

My vote is to let it be for the moment, and us msysGit people will 
probably add something like NO_ANSI_TERM=YesPlease later.

Ciao,
Dscho
