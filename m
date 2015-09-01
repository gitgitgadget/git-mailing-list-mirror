From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7300: fix broken && chains
Date: Tue, 1 Sep 2015 13:36:51 -0400
Message-ID: <20150901173650.GA5723@sigill.intra.peff.net>
References: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
 <20150831185414.GB20555@sigill.intra.peff.net>
 <CAMpP7NZ=K62XVkuuJHpDruBy7b2gECHrJ30L43LzdE54vTVB2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:36:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpUQ-0007X5-JN
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbbIARgy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 13:36:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53140 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752888AbbIARgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:36:53 -0400
Received: (qmail 6026 invoked by uid 102); 1 Sep 2015 17:36:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 12:36:53 -0500
Received: (qmail 2888 invoked by uid 107); 1 Sep 2015 17:36:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 13:36:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 13:36:51 -0400
Content-Disposition: inline
In-Reply-To: <CAMpP7NZ=K62XVkuuJHpDruBy7b2gECHrJ30L43LzdE54vTVB2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276999>

On Tue, Sep 01, 2015 at 08:27:59AM +0200, erik elfstr=C3=B6m wrote:

>      (
>         echo "100644 $o5 0    a"
>         echo "100644 $o0 0    c"
>         echo "160000 $c1 0    d"
>     ) >expected &&
>=20
> I'd estimate that there are hundreds of these (see t3030 for
> examples). I'm not sure if you care about these? As you say they are
> not really very interesting cases.

I think patches for these are OK, but no, I don't consider it a high
priority if they are harmless (IMHO the real value of the patches is
that it removes the noise from the output of your script, so you can
find any cases that _do_ matter).

-Peff
