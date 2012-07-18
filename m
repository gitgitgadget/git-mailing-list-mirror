From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Wed, 18 Jul 2012 03:27:53 -0400
Message-ID: <20120718072753.GC12942@sigill.intra.peff.net>
References: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
 <20120703063511.GA16679@sigill.intra.peff.net>
 <CAGxub4-9E0W8ZgsPHeTyUyxmPD80LUd7NjSezg5Zt2-nZPBMJA@mail.gmail.com>
 <20120704064450.GA24807@sigill.intra.peff.net>
 <7v394py7r2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: Katsuyama Takeharu <gkatsu.ne@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:28:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOgF-0000Ii-4A
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab2GRH2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:28:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36868
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab2GRH16 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:58 -0400
Received: (qmail 16011 invoked by uid 107); 18 Jul 2012 07:27:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 03:27:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 03:27:53 -0400
Content-Disposition: inline
In-Reply-To: <7v394py7r2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201665>

On Tue, Jul 17, 2012 at 10:10:25PM -0700, Junio C Hamano wrote:

> Ping on a seemingly stalled thread.

Hrm. I could swear that Takeharu sent a follow-up using
pick_one_utf8_char directly that looked OK, but now I can't seem to find
it in the list archives. I wonder if it was off-list and I didn't
realize it.

If I did not simply dream it, can you re-post the latest patch you
sent?

-Peff
