From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: use internal argv_array of struct
 child_process in run_hook_ve()
Date: Thu, 17 Jul 2014 17:32:40 -0400
Message-ID: <20140717213239.GC2622@peff.net>
References: <53C6F55B.9000404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:32:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7tII-0000Zn-S0
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 23:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbaGQVcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 17:32:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:35593 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752507AbaGQVcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 17:32:46 -0400
Received: (qmail 28155 invoked by uid 102); 17 Jul 2014 21:32:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (208.181.190.99)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Jul 2014 16:32:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jul 2014 17:32:40 -0400
Content-Disposition: inline
In-Reply-To: <53C6F55B.9000404@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253783>

On Wed, Jul 16, 2014 at 11:57:47PM +0200, Ren=C3=A9 Scharfe wrote:

> Use the existing argv_array member instead of providing our own.  Thi=
s
> way we don't have to initialize or clean it up explicitly.

Yay. Thanks for this cleanup (and all of the other recent ones; they al=
l
looked good to me).

-Peff
