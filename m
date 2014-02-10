From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t5538: fix default http port
Date: Mon, 10 Feb 2014 14:15:24 -0500
Message-ID: <20140210191521.GA3112@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-3-git-send-email-pclouds@gmail.com>
 <20140206193533.GB14552@sigill.intra.peff.net>
 <20140207234727.GA17520@sigill.intra.peff.net>
 <CACsJy8CLR4qerWPWs+0TWxnTWidm_VLtYExjKqAOLOSNK0chaA@mail.gmail.com>
 <20140210143948.GA21242@sigill.intra.peff.net>
 <xmqqwqh2su6e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 20:15:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCwKN-0002bK-8e
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 20:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbaBJTP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 14:15:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:48126 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752367AbaBJTP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 14:15:27 -0500
Received: (qmail 12520 invoked by uid 102); 10 Feb 2014 19:15:27 -0000
Received: from mobile-032-162-138-072.mycingular.net (HELO sigill.intra.peff.net) (32.162.138.72)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Feb 2014 13:15:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Feb 2014 14:15:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwqh2su6e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241925>

On Mon, Feb 10, 2014 at 10:23:53AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > Here it is as a Real Patch=E2=84=A2. I just based it on master, so =
it can
> > replace your 5537/5538 fix in your series.
>=20
> Thanks, looks good.  Will put this at the bottom and rebuild the
> nd/http-fetch-shallow-fix series on top.

Thanks. It might be worth squashing in the patch below (or sticking it
on top), to cover git-daemon as well.

AFAICT, that leaves SVN_HTTPD_PORT, which we do not set by default at
all, and the p4 tests, which already do their own similar magic.

The "set GIT_HTTPD_TESTS by default" magic should probably go in a
separate series, so I'll roll them by themselves.

-Peff
