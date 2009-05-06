From: Jeff King <peff@peff.net>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 6 May 2009 09:07:50 -0400
Message-ID: <20090506130750.GB11081@sigill.intra.peff.net>
References: <20090506055913.GA9701@dektop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 15:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1gqv-00074Q-BR
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 15:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbZEFNHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbZEFNHw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 09:07:52 -0400
Received: from peff.net ([208.65.91.99]:42083 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbZEFNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 09:07:51 -0400
Received: (qmail 30359 invoked by uid 107); 6 May 2009 13:08:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 06 May 2009 09:08:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 May 2009 09:07:50 -0400
Content-Disposition: inline
In-Reply-To: <20090506055913.GA9701@dektop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118338>

On Wed, May 06, 2009 at 03:59:13PM +1000, Nguyen Thai Ngoc Duy wrote:

> I did "make test" on a SunOS 5.10 and it failed. With the below patch,
> only t7400 and t8005 kept failing. For the first case, t7400.5 failed
> because extensive use of sed to normalize path in git-submodule.sh

You may consider putting /usr/xpg4/bin in your PATH. It has much more
sane versions of shell utilities (including a tail which supports "-n").

-Peff
