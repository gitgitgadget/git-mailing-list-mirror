From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not use GUID on dir in git init --shared=all on
 FreeBSD 4.11p2
Date: Tue, 4 Mar 2008 20:50:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803042048330.22527@racer.site>
References: <20080303234406.GA28158@steel.home> <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org> <20080304072519.GA3070@steel.home> <7vir02ap3b.fsf@gitster.siamese.dyndns.org> <20080304202047.GC3295@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWe7K-0004Rx-L9
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 21:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762AbYCDUvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 15:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758676AbYCDUvY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 15:51:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:45990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758294AbYCDUvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 15:51:22 -0500
Received: (qmail invoked by alias); 04 Mar 2008 20:51:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 04 Mar 2008 21:51:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196zgE9x+h6fvVrgp+HcCOUcXkK45/nu65yW8ZjzW
	IROBDawrKVosYv
X-X-Sender: gene099@racer.site
In-Reply-To: <20080304202047.GC3295@steel.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76137>

Hi,

On Tue, 4 Mar 2008, Alex Riesen wrote:

> +#if !defined(__FreeBSD__) || (__FreeBSD__ > 4)

We are not avoiding to clutter the source code with ugly __MINGW32__ 
conditionals with a huge effort, so that you can clutter it with 
__FreeBSD__ conditionals.


>  	if (S_ISDIR(mode))
>  		mode |= S_ISGID;

What problem does FreeBSD < 4 have with that?

Ciao,
Dscho

