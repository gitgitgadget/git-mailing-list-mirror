From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] protocol-capabilities documentation updates
Date: Wed, 24 Jul 2013 04:00:51 -0400
Message-ID: <20130724080051.GA3890@sigill.intra.peff.net>
References: <CACsJy8BcEfc33HNxQB+_msbkbcxFfqg1xOpeRxNGL_cUqruE0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 10:01:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1u0J-0000xa-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 10:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab3GXIAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 04:00:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:36942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab3GXIAz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 04:00:55 -0400
Received: (qmail 23208 invoked by uid 102); 24 Jul 2013 08:00:54 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 03:00:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 04:00:51 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BcEfc33HNxQB+_msbkbcxFfqg1xOpeRxNGL_cUqruE0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231083>

On Mon, Jul 15, 2013 at 07:25:19PM +0700, Nguyen Thai Ngoc Duy wrote:

> I noticed that "quiet" and "agent" capabilities were missing in
> protocol-capabilitities.txt. I have a rough idea what they do, but I
> think it's best to be documented by the authors. Maybe you have some
> time to make a patch?

Thanks for bringing it up; we should be more careful about documenting
these as we add them.

I went ahead and documented them both, as I also remember the rationale
for "quiet". And of course I found some other inaccuracies in the
capabilities documentation while I was there. :)

  [1/4]: docs: fix 'report-status' protocol capability thinko
  [2/4]: docs: note that receive-pack knows side-band-64k capability
  [3/4]: document 'agent' protocol capability
  [4/4]: document 'quiet' receive-pack capability

-Peff
