From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Mon, 25 Aug 2014 15:35:20 -0400
Message-ID: <20140825193519.GH30953@peff.net>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
 <20140825133550.GE17288@peff.net>
 <CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
 <20140825150028.GA28176@peff.net>
 <xmqq8umcmnmo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM033-000479-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 21:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933345AbaHYTfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 15:35:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:58643 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933246AbaHYTfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 15:35:22 -0400
Received: (qmail 32078 invoked by uid 102); 25 Aug 2014 19:35:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 14:35:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 15:35:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8umcmnmo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255857>

On Mon, Aug 25, 2014 at 11:26:39AM -0700, Junio C Hamano wrote:

> Good digging, and I agree that it should use the FLEX_ARRAY for
> consistency.

I can produce a patch, but I did not want to steal Arjun's thunder.

Arjun, did my proposal make sense? Do you want to try implementing that?

-Peff
