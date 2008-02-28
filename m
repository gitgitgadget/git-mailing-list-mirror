From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 19/40] Windows: Change the name of hook scripts to make
 them not executable.
Date: Thu, 28 Feb 2008 15:20:23 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281519300.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-20-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkZf-0005gA-AW
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYB1PUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbYB1PUz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:20:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:58941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752914AbYB1PUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:20:54 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:20:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 28 Feb 2008 16:20:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19T8mVmQ9hTniP5T2yCIJnEVwM4unLc+U/KlnpVGh
	wvixBtyHQmYHWa
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-20-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75406>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> -		*) cp $$boilerplate blt/$$dst ;; \
> +		*) if test -n "$$(sed -ne '/^#!\//p' -e '1q' < "$$boilerplate")"; then \
> +			cp "$$boilerplate" "blt/$${dst}$(NOEXECTEMPL)"; \
> +		   else \
> +			cp "$$boilerplate" "blt/$$dst"; \
> +		   fi ;; \

Why not just append .noexec to all of the hooks?

Ciao,
Dscho

