From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-verify-tag: fix -v option parsing
Date: Mon, 28 Jul 2008 13:06:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281306090.2725@eeepc-johanness>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com> <4888B4E3.9000504@free.fr> <alpine.DEB.1.00.0807241807550.8986@racer> <4889EF22.6020604@free.fr> <488DA40C.8020400@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQYp-0006ZG-9i
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbYG1LFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbYG1LFi
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:05:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:47461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753472AbYG1LFi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:05:38 -0400
Received: (qmail invoked by alias); 28 Jul 2008 11:05:36 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp057) with SMTP; 28 Jul 2008 13:05:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LFgRY3++LAhqiEILjHmaIP5ZbDJplLtk9ExMA0Q
	9auti3p+LzSR54
X-X-Sender: user@eeepc-johanness
In-Reply-To: <488DA40C.8020400@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90439>

Hi,

On Mon, 28 Jul 2008, Olivier Marin wrote:

> From: Olivier Marin <dkr@freesurf.fr>
> 
> Since the C rewrite, "git verify-tag -v" just does nothing instead of 
> printing the usage message with an error. This patch fix the regression.

Maybe a better solution would be to convert (trivially) to 
parse-options...

Ciao,
Dscho
