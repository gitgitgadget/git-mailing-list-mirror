From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: respect --no-thin
Date: Sat, 10 Aug 2013 06:31:23 -0400
Message-ID: <20130810103123.GB6237@sigill.intra.peff.net>
References: <1376129407-30590-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 12:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V86SI-0005Cq-NW
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 12:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017Ab3HJKb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 06:31:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:55664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968544Ab3HJKb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 06:31:26 -0400
Received: (qmail 5968 invoked by uid 102); 10 Aug 2013 10:31:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 05:31:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 06:31:23 -0400
Content-Disposition: inline
In-Reply-To: <1376129407-30590-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232090>

On Sat, Aug 10, 2013 at 05:10:07PM +0700, Nguyen Thai Ngoc Duy wrote:

> Over the time the default value for --thin has been switched between
> on and off. As of now it's always on, even if --no-thin is given.
> Correct the code to respect --no-thin.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

This makes sense, and I confirmed with the script I posted earlier that
it does work (and didn't before). Thanks.

It might be nice to have a test, but I am not sure of a good way to
check whether a push was thin. I guess we can grep the output of
GIT_TRACE, though it feels a bit hacky.

-Peff
