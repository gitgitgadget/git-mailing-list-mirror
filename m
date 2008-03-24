From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 14:59:03 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241458430.4353@racer.site>
References: <200803232150.29971.barra_cuda@katamail.com> <200803241331.17986.barra_cuda@katamail.com> <alpine.LSU.1.00.0803241409400.4353@racer.site> <200803241502.21465.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:59:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdnDF-0004lA-9W
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604AbYCXN7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758367AbYCXN7D
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:59:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:47269 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757131AbYCXN7A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:59:00 -0400
Received: (qmail invoked by alias); 24 Mar 2008 13:58:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 24 Mar 2008 14:58:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YaFwXHt5Y3EUSEU1SJuFx15II7fudIlL5lrjKOE
	Zal+1yyqJ1gpeG
X-X-Sender: gene099@racer.site
In-Reply-To: <200803241502.21465.barra_cuda@katamail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78037>

Hi,

On Mon, 24 Mar 2008, Michele Ballabio wrote:

> There are quite a few places that will need to call approxidate(), when 
> they'll adopt the parse-options system, so this patch adds the function 
> parse_opt_approxidate_cb(), used by OPT_DATE, and converts the only user 
> so far.

Thanks!

Ciao,
Dscho
