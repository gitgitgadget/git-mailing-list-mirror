From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Sun, 31 Aug 2014 11:17:53 -0400
Message-ID: <20140831151753.GA17449@peff.net>
References: <20140829205538.GD29456@peff.net>
 <20140829205809.GB7060@peff.net>
 <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com>
 <20140829220818.GA24834@peff.net>
 <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com>
 <20140830131649.GA26833@peff.net>
 <5401F53B.6070707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 31 17:18:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO6tD-0002gg-8k
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 17:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbaHaPRz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2014 11:17:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:41876 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbaHaPRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 11:17:55 -0400
Received: (qmail 15592 invoked by uid 102); 31 Aug 2014 15:17:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Aug 2014 10:17:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:17:53 -0400
Content-Disposition: inline
In-Reply-To: <5401F53B.6070707@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256288>

On Sat, Aug 30, 2014 at 06:00:59PM +0200, Ren=C3=A9 Scharfe wrote:

> My only nit with patch 2: Petr Stodulka <pstodulk@redhat.com> and Mar=
tin von
> Gagern <Martin.vGagern@gmx.net> should be mentioned as bug reporters.

Yeah, I agree with that. And actually, you should get a Reported-by:
on the first patch. :)

However, I think there are some grave implications of this series; see
the message I just posted elsewhere in the thread. I think we will end
up dropping patch 2, but keep patch 1.

-Peff
