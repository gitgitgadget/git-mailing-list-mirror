From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/7] Column output
Date: Tue, 8 Feb 2011 17:47:45 -0500
Message-ID: <20110208224745.GA14190@sigill.intra.peff.net>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 23:47:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmwLi-0000M6-GH
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 23:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab1BHWrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 17:47:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38511 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954Ab1BHWrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 17:47:48 -0500
Received: (qmail 6511 invoked by uid 111); 8 Feb 2011 22:47:47 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 08 Feb 2011 22:47:47 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Feb 2011 17:47:45 -0500
Content-Disposition: inline
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166372>

On Tue, Feb 08, 2011 at 10:22:14PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> In short, the series is very simple: give porcelain commands column
> output, just like good old "ls". There could be a few more candidates=
,
> I believe Ren=C3=A9 Scharfe mentioned other files in "git status".

I don't really care for column output myself, so maybe you have a good
reason why my idea won't work. But why not use the BSD column program?
I.e.:

  git config pager.tag column
  git config pager.branch column

True it will use "column" no matter whether the specific branch or tag
operation produces a lot of output or not, but in general that should b=
e
OK. Most "action" commands like "tag -d" or "branch new old" just
produce one line of output and look fine piped through column.

-Peff
