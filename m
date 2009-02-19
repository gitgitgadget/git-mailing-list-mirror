From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] branch: clean up repeated strlen
Date: Thu, 19 Feb 2009 12:31:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902191231050.6223@intel-tinevez-2-302>
References: <20090219033329.GA13666@coredump.intra.peff.net> <20090219033545.GB18970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:33:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La79T-0006YG-Li
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZBSLbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZBSLbn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:31:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:42735 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751526AbZBSLbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:31:42 -0500
Received: (qmail invoked by alias); 19 Feb 2009 11:31:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp017) with SMTP; 19 Feb 2009 12:31:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pzQ1hqyop9SCoyVf4OB44gDeth7rHhpECsGmkTm
	g8b3D0VAYnEzdG
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090219033545.GB18970@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110681>

Hi,

On Wed, 18 Feb 2009, Jeff King wrote:

> Commit 45e2b61 fixed the initialization of a "len" struct
> parameter via strlen. We can use that to clean up what is
> now 3 strlens in a 6-line sequence.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I guess a good compiler could optimize these out, but I think it
> actually reads a little bit nicer.

Definitely.  And thanks for the tests!

Ciao,
Dscho
