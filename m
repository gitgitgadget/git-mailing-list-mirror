From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 14:39:58 -0400
Message-ID: <20090828183958.GA11488@coredump.intra.peff.net>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828180158.GA6940@coredump.intra.peff.net>
 <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6Ms-00027L-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 20:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbZH1Sj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZH1Sj7
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:39:59 -0400
Received: from peff.net ([208.65.91.99]:36346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbZH1Sj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:39:59 -0400
Received: (qmail 6941 invoked by uid 107); 28 Aug 2009 18:40:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 14:40:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 14:39:59 -0400
Content-Disposition: inline
In-Reply-To: <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127324>

On Fri, Aug 28, 2009 at 08:27:06PM +0200, Alex Riesen wrote:

> > Thanks, that is a much better solution. And I don't know offhand of any
> > portability problems in overriding the library at link time.
> 
> Microsoft's compiler and libraries? MacOSX?

Are you saying you know those to be platforms with problems, or are you
asking whether those platforms will have problems?

-Peff
