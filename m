From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 14:01:58 -0400
Message-ID: <20090828180158.GA6940@coredump.intra.peff.net>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh5m5-0007CY-T5
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 20:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbZH1SCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbZH1SB7
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:01:59 -0400
Received: from peff.net ([208.65.91.99]:39583 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbZH1SB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:01:59 -0400
Received: (qmail 6716 invoked by uid 107); 28 Aug 2009 18:02:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 14:02:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 14:01:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127320>

On Fri, Aug 28, 2009 at 01:28:34PM -0400, Nicolas Pitre wrote:

> However I was hoping for a current time trickery solution that could 
> live in test-date.c instead of interfering with the main code in such a 
> way.
> 
> Did a quick test to override the library version:

Thanks, that is a much better solution. And I don't know offhand of any
portability problems in overriding the library at link time.

-Peff
