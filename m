From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 16:33:03 -0400
Message-ID: <20100326203303.GB22900@coredump.intra.peff.net>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
 <20100326124650.GA12215@coredump.intra.peff.net>
 <alpine.DEB.1.00.1003261712100.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvGDU-0001s7-Dx
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab0CZUdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 16:33:11 -0400
Received: from peff.net ([208.65.91.99]:49480 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab0CZUdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:33:10 -0400
Received: (qmail 5337 invoked by uid 107); 26 Mar 2010 20:33:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Mar 2010 16:33:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Mar 2010 16:33:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1003261712100.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143283>

On Fri, Mar 26, 2010 at 05:14:46PM +0100, Johannes Schindelin wrote:

> In addition to the disadvantages you are listing, it does not jump 
> directly to the word I am looking for. As you know, I am working 
> with LaTeX files heavily, where convention dictates that a paragraph is 
> represented by a single line in the source code.

Sure, that is a reasonable feature to want that my solution did not have
(though I have never seen LaTeX code with that requirement; I wrap my
lines at a reasonable width and separate paragraphs with a blank line).

> So yes, I really need -O, and if a colleague would not have asked me why 
> this useful feature is not in upstream Git, I would not even have 
> submitted the patch pair.

Yep. That is why I started my mail with "this is not an argument against
your patch". I was just trying to be helpful and offer a possible
alternative.

-Peff
