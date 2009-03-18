From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/10] test-lib: Replace uses of $(expr ...) by POSIX
 shell features.
Date: Wed, 18 Mar 2009 23:28:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903182319180.10279@pacific.mpi-cbg.de>
References: <cover.1237410682.git.j6t@kdbg.org> <680eb7fed78dc2ae0268f9b3adcd5978aed3ebcf.1237410682.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4FK-0001ms-VT
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbZCRW0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbZCRW0s
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:26:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:49080 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753496AbZCRW0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:26:46 -0400
Received: (qmail invoked by alias); 18 Mar 2009 22:26:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 18 Mar 2009 23:26:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oSBtSnq3okMK57ze93QKa8TB9HiqXov6yrWODmu
	i+g+90huiuiYjL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <680eb7fed78dc2ae0268f9b3adcd5978aed3ebcf.1237410682.git.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113690>

Hi,

On Wed, 18 Mar 2009, Johannes Sixt wrote:

> In particular:
> 
> - Test case counting can be achieved by arithmetic expansion.
> 
> - The name of the test, e.g. t1234, can be computed with ${0%%} and ${0##}.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

I guess this makes the tests less slow on Windows?  Do you have numbers?

FWIW I run the tests on Windows with -j10 these days, and they take about 
15 minutes on a quad core 3GHz machine (which I may use from time to time; 
the machine is not mine, otherwise it would run Linux).

Ciao,
Dscho
