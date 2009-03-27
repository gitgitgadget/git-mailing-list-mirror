From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
	right after init
Date: Fri, 27 Mar 2009 01:08:28 -0400
Message-ID: <20090327050828.GA23568@coredump.intra.peff.net>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <20090325124219.GA5307@coredump.intra.peff.net> <adf1fd3d0903250549l60e4a2d1j8bd57ba66d24a678@mail.gmail.com> <200903262223.28546.markus.heidelberg@web.de> <alpine.DEB.1.00.0903270259470.10279@pacific.mpi-cbg.de> <20090327050626.GA23512@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 06:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln4LT-0006ly-Kv
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 06:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761149AbZC0FIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 01:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760889AbZC0FIs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 01:08:48 -0400
Received: from peff.net ([208.65.91.99]:58229 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761359AbZC0FIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 01:08:47 -0400
Received: (qmail 18326 invoked by uid 107); 27 Mar 2009 05:08:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Mar 2009 01:08:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Mar 2009 01:08:28 -0400
Content-Disposition: inline
In-Reply-To: <20090327050626.GA23512@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114850>

On Fri, Mar 27, 2009 at 01:06:26AM -0400, Jeff King wrote:

> Another option would be a patch on top of the original to allow
> 
>   git config --global init.importmessage 'Commit inicial'
> 
> or
> 
>   git config --global init.importeditor true
> 
> I have no interest in writing such a patch, but I don't see a reason to
> reject it.

Actually, there is one possible reason to reject it: scripts could not
rely on the behavior of "--import" without it. But I think it is OK to
make a conscious decision that this is a feature for _humans_, and that
scripts can use "init && add && commit" (or they can be happy with
dealing with the human's choice of editor or not).

-Peff
