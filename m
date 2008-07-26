From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Sat, 26 Jul 2008 05:04:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260503400.26810@eeepc-johanness>
References: <20080725171315.GA27285@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-1692852411-1217041449=:26810"
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	spearce@spearce.org, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 05:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMa4n-00074g-PF
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 05:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbYGZDDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 23:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYGZDDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 23:03:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:48143 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752626AbYGZDDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 23:03:08 -0400
Received: (qmail invoked by alias); 26 Jul 2008 03:03:05 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp010) with SMTP; 26 Jul 2008 05:03:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ieoQ0nNdibl56hCO5Du60iGAhJDKZW8tLcP2UEh
	PP+QkLOgU4fzrU
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080725171315.GA27285@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90161>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-1692852411-1217041449=:26810
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 25 Jul 2008, Björn Steinbrink wrote:

> +	// This object comes from outside the thin pack, so we need to
> +	// initialize the size and type fields

Do not use C++ comments in Git.  Ever.

Ciao,
Dscho
--658432-1692852411-1217041449=:26810--
