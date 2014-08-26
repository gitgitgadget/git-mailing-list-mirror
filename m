From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] log-tree: make add_name_decoration a public function
Date: Tue, 26 Aug 2014 08:17:11 -0400
Message-ID: <20140826121710.GB29180@peff.net>
References: <20140826102051.GA4885@peff.net>
 <20140826102335.GA25687@peff.net>
 <53FC7408.1030708@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMFgb-0005y8-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 14:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934496AbaHZMRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 08:17:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:59144 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934492AbaHZMRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:17:13 -0400
Received: (qmail 15605 invoked by uid 102); 26 Aug 2014 12:17:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 07:17:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 08:17:11 -0400
Content-Disposition: inline
In-Reply-To: <53FC7408.1030708@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255893>

On Tue, Aug 26, 2014 at 12:48:24PM +0100, Ramsay Jones wrote:

> > We can fix this by making name_decoration's adding function
> > public. If all callers use it, then any changes to structi
> 
> s/structi/struct/

I blame vi finger-cruft.

> > initialization only need to happen in one place (and because
> > the members come in as parameters, the compiler can notice a
> > caller who does not supply enough information).
> > 
> > As a bonus, this also means that the decoration hashes
> > created by the bisect code will use less memory (previously
> > we over-allocated space for the distance integer, but not we
> 
> s/not/now/

Er, I blame vi again. Yeah, that's my story and I'm sticking to it.

Thanks for proofreading. :)

-Peff
