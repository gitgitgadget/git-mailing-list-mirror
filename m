From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Tue, 3 Jan 2012 14:18:55 -0500
Message-ID: <20120103191855.GD20926@sigill.intra.peff.net>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <20120102092508.GA10977@elie.hsd1.il.comcast.net>
 <20120102194711.GA25296@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:19:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri9t2-0007sF-3d
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab2ACTS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:18:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab2ACTS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:18:58 -0500
Received: (qmail 8785 invoked by uid 107); 3 Jan 2012 19:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 14:25:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 14:18:55 -0500
Content-Disposition: inline
In-Reply-To: <20120102194711.GA25296@ecki.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187876>

On Mon, Jan 02, 2012 at 08:47:11PM +0100, Clemens Buchacher wrote:

> On Mon, Jan 02, 2012 at 03:25:08AM -0600, Jonathan Nieder wrote:
> > 
> > > [Subject: daemon: add tests]
> > 
> > Can't believe I missed this.  That seems like a worthy cause ---
> > can someone remind me why this is dropped, or if there are any
> > tweaks I can help with to get it picked up again?
> 
> We were discussing some open issues with patch 2/2, which was based
> on the tests. I later abandoned the idea for that patch. But the
> tests should be ok by themselves.

Yes, I'd like to see them included, even without the second patch. We
currently have zero tests for git-daemon, so even just verifying that
it starts and can let people fetch is an improvement.

-Peff
