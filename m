From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 2/2] MSVC: Fix an "incompatible pointer types" compiler
 warning
Date: Fri, 4 Dec 2009 11:47:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912041144470.4985@pacific.mpi-cbg.de>
References: <4B1806FB.2050401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 04 11:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGVd0-0005dr-LF
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 11:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZLDKmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 05:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbZLDKmy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 05:42:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:34450 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751681AbZLDKmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 05:42:53 -0500
Received: (qmail invoked by alias); 04 Dec 2009 10:42:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 04 Dec 2009 11:42:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wY/xdubCwKxp77vKaDRFC/UGnKe0skVGe8DUjNK
	SMAltGwEVV37hh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B1806FB.2050401@ramsay1.demon.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134506>

Hi,

On Thu, 3 Dec 2009, Ramsay Jones wrote:

>  compat/mingw.h |   27 ++++++++++++++++++++++++++-
>  compat/msvc.h  |   25 +------------------------
>  2 files changed, 27 insertions(+), 25 deletions(-)

I'd prefer to have the MSVC-specific definitions in msvc.h, along with a 
definition of, say, ALREADY_DEFINED_STATI64 or some such (which tells 
mingw.h not to do anything about those types).  There is no need to 
clutter mingw.h with stuff for MSVC.

Ciao,
Dscho
