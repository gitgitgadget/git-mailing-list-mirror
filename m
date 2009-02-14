From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 10:21:55 -0500
Message-ID: <20090214152155.GD3887@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 16:23:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYMMa-0008Lz-3w
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 16:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZBNPV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 10:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbZBNPV7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 10:21:59 -0500
Received: from peff.net ([208.65.91.99]:54264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbZBNPV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 10:21:58 -0500
Received: (qmail 32529 invoked by uid 107); 14 Feb 2009 15:22:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 14 Feb 2009 10:22:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Feb 2009 10:21:55 -0500
Content-Disposition: inline
In-Reply-To: <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109874>

On Sat, Feb 14, 2009 at 02:03:09PM +0200, Felipe Contreras wrote:

> Reorganizing the code to use parseopt as suggested by Johannes
> Schindelin.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin-config.c |  370 ++++++++++++++++++++++++++---------------------------
>  1 files changed, 182 insertions(+), 188 deletions(-)

What is this built on top of? I get very large conflicts applying it on
top of Junio's "master".

-Peff
