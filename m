From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/3] Take four on fixing OPT_SET_PTR issues
Date: Mon, 31 Mar 2014 17:07:14 -0400
Message-ID: <20140331210714.GA6422@sigill.intra.peff.net>
References: <7vtxago359.fsf@alter.siamese.dyndns.org>
 <cover.1396177207.git.marat@slonopotamus.org>
 <xmqq4n2e8eov.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjQT-00058M-5p
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbaCaVHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:07:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:51244 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750996AbaCaVHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:07:16 -0400
Received: (qmail 11318 invoked by uid 102); 31 Mar 2014 21:07:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 31 Mar 2014 16:07:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Mar 2014 17:07:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n2e8eov.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245531>

On Mon, Mar 31, 2014 at 10:23:44AM -0700, Junio C Hamano wrote:

> SET_PTR() may not be used, but are there places where SET_INT() is
> abused with a cast-to-pointer for the same effect?  I didn't check,
> but if there are such places, converting them to use SET_PTR() with
> their existing cast removed may be a better way to go.

Anyone doing that should be beaten with a clue stick.

Fortunately, I grepped through and I did not see any cases. My clue
stick remains untouched.

-Peff
