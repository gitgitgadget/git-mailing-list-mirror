From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/2] pretty: support right alignment
Date: Mon, 24 Sep 2012 20:27:01 -0400
Message-ID: <20120925002700.GA19586@sigill.intra.peff.net>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <20120920143803.GA9527@lanh>
 <7v392cd4vi.fsf@alter.siamese.dyndns.org>
 <CACsJy8AAjxMN7MX09Eq4Dy6NJHMkyxGJZm9uZquXWTi0goAYLQ@mail.gmail.com>
 <7vvcf517bs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 02:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGIze-0000ef-1M
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 02:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab2IYA1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 20:27:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57455 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238Ab2IYA1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 20:27:07 -0400
Received: (qmail 7500 invoked by uid 107); 25 Sep 2012 00:27:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 20:27:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 20:27:01 -0400
Content-Disposition: inline
In-Reply-To: <7vvcf517bs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206339>

On Sun, Sep 23, 2012 at 01:17:43AM -0700, Junio C Hamano wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > ... On the other hand, I don't
> > really wish to turn pretty format machinery into a full feature text
> > layout engine (by ripping of links/lynx?).
> 
> That is very true.  We should restrain ourselves and avoid going
> overboard piling shiny new toys on a not-so-useful foundation that
> is not expressive enough.  One feature that is probably much more
> needed on the foundation side would be some form of conditional
> output, without which built-in output elements like --show-notes
> cannot be emulated with --format option.

The embedded lua patch series I just posted may interest (or horrify)
the both of you:

  http://article.gmane.org/gmane.comp.version-control.git/206335

-Peff
