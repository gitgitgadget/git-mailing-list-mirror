From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] allow mangling short options which take integer
 arguments
Date: Thu, 1 Oct 2009 23:55:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910012354080.4985@pacific.mpi-cbg.de>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091001202301.GB12175@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Oct 01 23:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtTa4-0002iM-42
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 23:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbZJAVwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 17:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbZJAVwp
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 17:52:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:52520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751568AbZJAVwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 17:52:45 -0400
Received: (qmail invoked by alias); 01 Oct 2009 21:52:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 01 Oct 2009 23:52:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KHI5XmpvKtC5UnzooL4kvwd6xa05gcXWHKETTom
	ZV6odFf4HWC7HI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091001202301.GB12175@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129414>

Hi,

On Thu, 1 Oct 2009, Clemens Buchacher wrote:

> This patch allows you to do things like for example
> 
>   $ git <cmd> -bn100
> 
> where -b is a boolean and -n is an integer option.
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

And this patch looks even more straight-forward than 1/2, _but_... what 
about cases where there are short options that are digits?

Ciao,
Dscho
