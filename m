From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "stash: require a clean index to apply"
Date: Thu, 25 Jun 2015 20:27:07 -0400
Message-ID: <20150626002706.GA6367@peff.net>
References: <5570F094.10007@quantopian.com>
 <20150607124001.GA11042@peff.net>
 <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
 <20150610185635.GA22800@peff.net>
 <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
 <20150610192734.GA23715@peff.net>
 <xmqqsi9samx1.fsf@gitster.dls.corp.google.com>
 <20150615182721.GA4041@peff.net>
 <xmqqy4jk7muq.fsf@gitster.dls.corp.google.com>
 <f06e573d-02e3-47e9-85d8-3bb6551d72f5.maildroid@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?b=C3=A4r?= <crashcookie@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Kamens <jkamens@quantopian.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 02:27:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8HUB-0002xZ-78
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 02:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbbFZA1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 20:27:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:52069 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751655AbbFZA1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 20:27:09 -0400
Received: (qmail 6757 invoked by uid 102); 26 Jun 2015 00:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 19:27:09 -0500
Received: (qmail 12315 invoked by uid 107); 26 Jun 2015 00:27:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 20:27:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 20:27:07 -0400
Content-Disposition: inline
In-Reply-To: <f06e573d-02e3-47e9-85d8-3bb6551d72f5.maildroid@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272747>

On Thu, Jun 25, 2015 at 05:49:11PM -0400, Jonathan Kamens wrote:

> Is this revert going to be applied and released?

It is on "master", and part of v2.5.0-rc0 (it is not part of v2.4.x, because
the original problem was not there, either).

-Peff
