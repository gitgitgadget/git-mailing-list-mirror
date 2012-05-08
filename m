From: Jeff King <peff@peff.net>
Subject: Re: Git fetch/pull stopped working
Date: Tue, 8 May 2012 16:08:42 -0400
Message-ID: <20120508200842.GA14779@sigill.intra.peff.net>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org>
 <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com>
 <7v8vh2v501.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Egor Ryabkov <egor.ryabkov@gmail.com>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 22:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRqiH-0006Jr-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 22:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831Ab2EHUIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 16:08:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34365
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756443Ab2EHUIo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 16:08:44 -0400
Received: (qmail 7685 invoked by uid 107); 8 May 2012 20:09:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 16:09:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 16:08:42 -0400
Content-Disposition: inline
In-Reply-To: <7v8vh2v501.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197418>

On Tue, May 08, 2012 at 12:37:18PM -0700, Junio C Hamano wrote:

> But as I said, "ERROR: Repository not found." does not seem to match any
> message of the released version of Git, so I cannot even tell where it is
> failing.
> 
> It could be that the message is coming from a customized version of ssh
> login handler github uses to shard and map the user accounts to
> directories[...]

That is exactly where it comes from.

> if they were running the vanilla Git), and if that is the case,
> perhaps the argument thrown at git-upload-pack from your local box and
> the problematic box somehow look different to Github, but that is in
> the "(REDACTED)" part, so I cannot tell from what was pasted in the
> pastebin.

Agreed. It's hard to tell if there's a real problem or not. If the
redacted bits are the same, then it is probably a github issue. In that
case, Egor, you should email support@github.com about it and mention the
name of the problematic repo.

I'll look into the weird routing thing that Carlos mentioned, too.

-Peff
