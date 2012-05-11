From: Jeff King <peff@peff.net>
Subject: Re: Git fetch/pull stopped working
Date: Fri, 11 May 2012 16:28:28 -0400
Message-ID: <20120511202828.GA17750@sigill.intra.peff.net>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org>
 <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com>
 <7v8vh2v501.fsf@alter.siamese.dyndns.org>
 <20120508200842.GA14779@sigill.intra.peff.net>
 <CADB4Qb3sqy859k6QPuqU9u1cdxwz0LSQ7bdUXXFW_gQqaT+P3A@mail.gmail.com>
 <CADB4Qb2-VB0LTrP8_i75V9e2FDeSjNLc+Pc4m73UJ0AX9NfX=w@mail.gmail.com>
 <CAH-tXsCi+zL5hKAHROA0hVfvOr07o4cknS8jy9qngapwB77QnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Egor Ryabkov <egor.ryabkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 22:28:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSwS5-00023f-51
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 22:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab2EKU2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 16:28:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40213
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab2EKU2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 16:28:31 -0400
Received: (qmail 14495 invoked by uid 107); 11 May 2012 20:28:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 May 2012 16:28:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2012 16:28:28 -0400
Content-Disposition: inline
In-Reply-To: <CAH-tXsCi+zL5hKAHROA0hVfvOr07o4cknS8jy9qngapwB77QnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197695>

On Sat, May 12, 2012 at 01:25:42AM +0530, jaseem abid wrote:

> On Sat, May 12, 2012 at 12:17 AM, Egor Ryabkov <egor.ryabkov@gmail.com> wrote:
> > Problem solved.
> >
> > Turns out that was a miscommunication on out side: the guy who setup
> > the keys on that box left, and his access to GH repo has been revoked.
> >
> > And GitHub returns "repo not found" rather than "you have no access
> > rights for this repository".
> 
> I have seen a lot of github guys in this list. I hope they will fix
> this soon. I had this issue a long time back and now I'm understanding
> what exactly happened then :)

This is not a bug, but rather the intentional behavior. It is there to
prevent an information leak about the names of private repositories that
the user has. Git-daemon has the same behavior by default (though it has
a "friendly" mode if you are willing to leak that information for your
site).

-Peff
