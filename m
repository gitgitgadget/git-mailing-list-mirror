From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/13] Allow helpers to request marks for fast-import
Date: Wed, 5 Aug 2009 23:05:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052304490.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050056050.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:05:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnfz-0003Wn-LQ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbZHEVF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbZHEVF2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:05:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:51330 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbZHEVF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:05:28 -0400
Received: (qmail invoked by alias); 05 Aug 2009 21:05:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 05 Aug 2009 23:05:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5FWVxIqC5jebOomGF2FK5IacjIY6IAvirP1G5kr
	73LcloJXcxHrGy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908050056050.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124984>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> From: Johan Herland <johan@herland.net>
> 
> The 'marks' capability is reported by the remote helper if it requires
> the fast-import marks database to loaded/saved by any git-fast-import
> process that is provided by the transport machinery. The feature is
> advertised along with exactly one argument: the location of the file
> containing the marks database.

Should the name not rather be specified when _asking_ for the marks, 
rather than at the time when we do not even know if the caller _needs_ 
marks?

Ciao,
Dscho
