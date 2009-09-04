From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Allow programs to not depend on remotes having
 urls
Date: Fri, 4 Sep 2009 14:45:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041445230.4605@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0909032213290.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjYAx-0001rb-OW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795AbZIDMpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756740AbZIDMpu
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:45:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:33869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755737AbZIDMpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 08:45:50 -0400
Received: (qmail invoked by alias); 04 Sep 2009 12:45:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 04 Sep 2009 14:45:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2ct9KdSq2ikzz8rwTcsfxoD5we3DcSudfyVpRdR
	RJomqEOR+6GuCH
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.2.00.0909032213290.28290@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127729>

Hi,

On Thu, 3 Sep 2009, Daniel Barkalow wrote:

> For fetch and ls-remote, which use the first url of a remote, have
> transport_get() determine this by passing a remote and passing NULL
> for the url. For push, which uses every url of a remote, use each url
> in turn if there are any, and use NULL if there are none.
> 
> This will allow the transport code to do something different if the
> location is not specified with a url.

For the record: you did not convince me.  Not that you tried, to...

Ciao,
Dscho
