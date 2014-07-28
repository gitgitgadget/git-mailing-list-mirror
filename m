From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/10] getcwd without PATH_MAX
Date: Mon, 28 Jul 2014 15:19:13 -0400
Message-ID: <20140728191913.GF11265@peff.net>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBqSA-0006WU-2D
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 21:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbaG1TTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 15:19:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:41953 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750995AbaG1TTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 15:19:18 -0400
Received: (qmail 28538 invoked by uid 102); 28 Jul 2014 19:19:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 14:19:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 15:19:13 -0400
Content-Disposition: inline
In-Reply-To: <53D694A2.8030007@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254351>

On Mon, Jul 28, 2014 at 08:21:22PM +0200, Ren=C3=A9 Scharfe wrote:

> Paths longer than PATH_MAX can be created and used on at least on som=
e
> file systems.  Currently we use getcwd() generally with a PATH_MAX-
> sized buffer.  This series adds two functions, strbuf_getcwd() and
> xgetcwd(), then uses them to reduce the number of fixed-sized buffers
> and to allow us to handle longer working directory paths.

With the exception of the potential strbuf_reset/init I pointed out, al=
l
of these look sane to me.

-Peff
