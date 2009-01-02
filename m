From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 13:51:38 -0500
Message-ID: <20090102185137.GA9129@coredump.intra.peff.net>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <alpine.LFD.2.00.0901011151440.5086@localhost.localdomain> <alpine.DEB.1.00.0901021914420.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:53:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIp8o-0008MQ-TI
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215AbZABSvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758194AbZABSvl
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:51:41 -0500
Received: from peff.net ([208.65.91.99]:3302 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758133AbZABSvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:51:41 -0500
Received: (qmail 18998 invoked by uid 111); 2 Jan 2009 18:51:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 02 Jan 2009 13:51:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jan 2009 13:51:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901021914420.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104403>

On Fri, Jan 02, 2009 at 07:17:34PM +0100, Johannes Schindelin wrote:

> BTW the "-p" is not necessary with "show", indeed, you cannot even switch 
> it off.

Half true:

  $ git grep -A1 '"-s"' diff.c
  diff.c: else if (!strcmp(arg, "-s"))
  diff.c-         options->output_format |= DIFF_FORMAT_NO_OUTPUT;

-Peff
