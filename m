From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] t5550: break submodule config test into multiple
 sub-tests
Date: Thu, 28 Apr 2016 11:25:03 -0400
Message-ID: <20160428152503.GA31063@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
 <20160428133704.GB25319@sigill.intra.peff.net>
 <CAGZ79kacgJ_=C-Y=QkSDmvEvCrmEbcvdMkg0x76zkj-Y86m4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:25:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnoZ-0003Ud-KP
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbcD1PZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:25:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58408 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752338AbcD1PZH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:25:07 -0400
Received: (qmail 30807 invoked by uid 102); 28 Apr 2016 15:25:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:25:05 -0400
Received: (qmail 10390 invoked by uid 107); 28 Apr 2016 15:25:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:25:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 11:25:03 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kacgJ_=C-Y=QkSDmvEvCrmEbcvdMkg0x76zkj-Y86m4=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292896>

On Thu, Apr 28, 2016 at 08:21:21AM -0700, Stefan Beller wrote:

> > -test_expect_success 'cmdline credential config passes into submodules' '
> > +test_expect_success 'set up repo with http submodules' '
> 
> set up or setup?
> 
> $ grep -r "set up" |wc -l
> 69
> $ grep -r "setup" |wc -l
> 1162
> 
> Apart from that nit, this patch looks good to me.

"set up" is a verb phrase. "setup" is a noun or an adjective.

I think we quite often use the latter as a verb. Whether that is
grammatically depends on your philosophy, I think.

-Peff
