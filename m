From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 00:09:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002160008210.20986@pacific.mpi-cbg.de>
References: <20100215225001.GA944@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:03:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh9yA-0008Ls-RD
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 00:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab0BOXDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 18:03:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:48965 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756404Ab0BOXDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 18:03:01 -0500
Received: (qmail invoked by alias); 15 Feb 2010 23:02:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 16 Feb 2010 00:02:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19svOphHsls1DnW4lOYFJdTj1p+1P/qyPEKqgsUik
	Gekk0Q8vCaRqrW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100215225001.GA944@book.hvoigt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.69999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140042>

Hi,

On Mon, 15 Feb 2010, Heiko Voigt wrote:

> In case the machine has only one cpu the initialization was
> skipped.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---

Thank you, Heiko, for fixing that nasty bug! It is already in 4msysgit's 
'devel' branch.

Ciao,
Dscho
