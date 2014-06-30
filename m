From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] sha1_file: replace PATH_MAX buffer wirh strbuf
 in, prepare_packed_git_one()
Date: Mon, 30 Jun 2014 09:24:24 -0400
Message-ID: <20140630132423.GA14799@sigill.intra.peff.net>
References: <53AED59B.1020209@web.de>
 <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
 <53AFA775.1090900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 15:24:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1bZO-0005iu-7x
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 15:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbaF3NY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 09:24:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:53508 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750944AbaF3NYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 09:24:25 -0400
Received: (qmail 28758 invoked by uid 102); 30 Jun 2014 13:24:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 08:24:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 09:24:24 -0400
Content-Disposition: inline
In-Reply-To: <53AFA775.1090900@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252666>

On Sun, Jun 29, 2014 at 07:43:17AM +0200, Ren=C3=A9 Scharfe wrote:

> Instead of using strbuf to create a message string in case a path is
> too long for our fixed-size buffer, replace that buffer with a strbuf
> and thus get rid of the limitation.

Yay. Safer, and the end result is much more readable.

-Peff
