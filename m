From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Mon, 29 Oct 2012 18:27:59 -0400
Message-ID: <20121029222759.GI20513@sigill.intra.peff.net>
References: <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
 <20121028223431.GF26675@odin.tremily.us>
 <20121029053401.GB30186@sigill.intra.peff.net>
 <20121029104544.GA2424@odin.tremily.us>
 <20121029105855.GA15075@sigill.intra.peff.net>
 <20121029112945.GD2424@odin.tremily.us>
 <20121029114310.GA16046@sigill.intra.peff.net>
 <CABURp0pFLi+2A+9wi-ZamiRze2u6z+6oyoCsNpWOLq_cq2L1rQ@mail.gmail.com>
 <20121029213652.GC20513@sigill.intra.peff.net>
 <CABURp0otR2S1aOAWwnaFYFGRi_2cCBODbghck-BqUTw2B_ci3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:28:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxof-0007Eq-9d
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab2J2W2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:28:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43146 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328Ab2J2W2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:28:02 -0400
Received: (qmail 24781 invoked by uid 107); 29 Oct 2012 22:28:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 18:28:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 18:27:59 -0400
Content-Disposition: inline
In-Reply-To: <CABURp0otR2S1aOAWwnaFYFGRi_2cCBODbghck-BqUTw2B_ci3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208652>

On Mon, Oct 29, 2012 at 06:21:08PM -0400, Phil Hord wrote:

> > Maybe instead of blindly converting config into the environment, it
> > should forward or clear specific known-meaning config.
> 
> Well, that's where we started.  I was aiming for the more generic
> "never needs updating" direction.

Then I think you are probably stuck taking the conservative approach of
not propagating recursively.

-Peff
