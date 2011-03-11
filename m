From: Jeff King <peff@peff.net>
Subject: Re: GSoC resumable clone
Date: Fri, 11 Mar 2011 10:48:22 -0500
Message-ID: <20110311154822.GA30605@sigill.intra.peff.net>
References: <AANLkTinrgqLhZK=fQ_+gUanT-zy9Mcbw-y3o7nYV9A-m@mail.gmail.com>
 <20110311153752.GA30329@sigill.intra.peff.net>
 <AANLkTi=D5kYh-w-6CKuCf39fnH1SYT5HxJ31tdq2vb9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Miseler <alexander@miseler.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4Zs-0005uN-TK
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab1CKPsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:48:25 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48348
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512Ab1CKPsX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:48:23 -0500
Received: (qmail 8605 invoked by uid 107); 11 Mar 2011 15:48:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Mar 2011 10:48:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2011 10:48:22 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=D5kYh-w-6CKuCf39fnH1SYT5HxJ31tdq2vb9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168912>

On Fri, Mar 11, 2011 at 07:41:14AM -0800, Shawn O. Pearce wrote:

> > I think there is room for both ideas. The cached bundle idea is not just
> > "here, download this bundle first". It is "here, download this _other
> > thing_ first, which might be a bundle, another git repo, a torrent,
> > etc".
> 
> Fair enough. Though I wouldn't limit this to bundles. Instead I would
> suggest supporting any valid Git URLs, and then extend our URL syntax
> to support bundles over http://, rsync://, and torrent.

Sorry, I didn't mean to imply that it was limited to bundles. It would
support arbitrary URLs or schemes. See this thread for some past
discussion:

  http://article.gmane.org/gmane.comp.version-control.git/164700

> If we support any URL and don't assume the URL is a bundle, you can
> point traffic at kernel.org to for example grab Linus' primary
> repository first, even if he doesn't have a bundle.

Exactly.

-Peff
